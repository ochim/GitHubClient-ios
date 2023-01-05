//
//  RepoRepository.swift
//  GithubClient
//
//  Created by 越智宗洋 on 2023/01/05.
//

import Foundation

struct RepoRepository {
    func fetchRepos() async throws -> [Repo] {
        return try await RepoAPIClient().getRepos()
    }
}
