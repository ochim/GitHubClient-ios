//
//  ContentView.swift
//  GitHubClient
//
//  Created by 越智宗洋 on 2022/12/29.
//

import SwiftUI

struct RepoListView: View {
    @StateObject private var reposStore = ReposStore()
    
    var body: some View {
        NavigationView {
            Group {
                switch reposStore.state {
                case .idle, .loading:
                    ProgressView("loading...")
                case .failed:
                    VStack {
                        Group {
                            Image("GitHubMark")
                            Text("Failed to load repositories")
                                .padding(.top, 4)
                        }
                        .foregroundColor(.black)
                        .opacity(0.4)
                        Button(
                            action: {
                                Task {
                                    await reposStore.loadRepos() // リトライボタンをタップしたときに再度リクエストを投げる
                                }
                            },
                            label: {
                                Text("Retry")
                                    .fontWeight(.bold)
                            }
                        )
                        .padding(.top, 8)
                    }
                case .loaded([]):
                    Text("No repositories")
                        .fontWeight(.bold)
                case let .loaded(repos):
                    List(repos) { repo in
                        NavigationLink(destination: RepoDetailView(repo: repo)) {
                            RepoRow(repo: repo)
                        }
                    }
                }
            }
            .navigationTitle("Repositories")
            
        }
        .task {
            await reposStore.loadRepos()
        }
    }
}

enum Stateful<Value> {
    case idle // まだデータを取得しにいっていない
    case loading // 読み込み中
    case failed(Error) // 読み込み失敗、遭遇したエラーを保持
    case loaded(Value) // 読み込み完了、読み込まれたデータを保持
}

@MainActor
class ReposStore: ObservableObject {
    @Published private(set) var state: Stateful<[Repo]> = .idle
    
    func loadRepos() async {
        let url = URL(string: "https://api.github.com/orgs/mixigroup/repos")!
        state = .loading
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        urlRequest.allHTTPHeaderFields = [
            "Accept": "application/vnd.github.v3+json"
        ]
        
        do {
            let (data, response) = try await URLSession.shared.data(for: urlRequest)
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                throw URLError(.badServerResponse)
            }
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let value = try decoder.decode([Repo].self, from: data)
            state = .loaded(value)
            
        } catch {
            state = .failed(error)
        }
    }
}

struct RepoListView_Previews: PreviewProvider {
    static var previews: some View {
        RepoListView()
    }
}
