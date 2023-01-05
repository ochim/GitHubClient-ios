//
//  RepoAPIClient.swift
//  GithubClient
//
//  Created by 越智宗洋 on 2023/01/05.
//

import Foundation

struct RepoAPIClient {
    
    func getRepos() async throws -> [Repo] {
        let url = URL(string: "https://api.github.com/orgs/mixigroup/repos")!
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        urlRequest.allHTTPHeaderFields = [
            "Accept": "application/vnd.github.v3+json"
        ]
        
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return try decoder.decode([Repo].self, from: data)
    }
}
