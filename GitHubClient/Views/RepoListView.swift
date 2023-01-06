//
//  ContentView.swift
//  GitHubClient
//
//  Created by 越智宗洋 on 2022/12/29.
//

import SwiftUI

struct RepoListView: View {
    @StateObject private var viewModel: RepoListViewModel
    
    init(viewModel: RepoListViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        NavigationView {
            Group {
                switch viewModel.state {
                case .idle, .loading:
                    ProgressView("loading...")
                case let .failed(error):
                    VStack {
                        Group {
                            Image("GitHubMark")
                            Text("Failed to load repositories. \(error.localizedDescription)")
                                .padding(.top, 4)
                        }
                        .foregroundColor(.black)
                        .opacity(0.4)
                        Button(
                            action: {
                                Task {
                                    await viewModel.onRetryButtonTapped()
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
            await viewModel.onAppear()
        }
    }
}

struct RepoListView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            RepoListView(
                viewModel: RepoListViewModel(
                    repoRepository: MockRepoRepository(
                        repos: [
                            .mock1, .mock2, .mock3, .mock4, .mock5
                        ]
                    )
                )
            )
            .previewDisplayName("Default")
            RepoListView(
                viewModel: RepoListViewModel(
                    repoRepository: MockRepoRepository(
                        repos: []
                    )
                )
            )
            .previewDisplayName("Empty")
            RepoListView(
                viewModel: RepoListViewModel(
                    repoRepository: MockRepoRepository(
                        repos: [],
                        error: DummyError()
                    )
                )
            )
            .previewDisplayName("Error")
        }
    }
}
