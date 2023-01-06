//
//  MockRepoRepository.swift
//  GitHubClient
//
//  Created by 越智宗洋 on 2023/01/06.
//

import Foundation

struct MockRepoRepository: RepoRepository {
    let repos: [Repo]
    let error: Error?

    init(repos: [Repo], error: Error? = nil) {
        self.repos = repos
        self.error = error
    }

    func fetchRepos() async throws -> [Repo] {
        if let error = error {
            throw error
        }
        return repos
    }
}
