//
//  RepoRepository.swift
//  GithubClient
//
//  Created by 越智宗洋 on 2023/01/05.
//

import Foundation

protocol RepoRepository {
    func fetchRepos() async throws -> [Repo]
}

struct RepoDataRepository: RepoRepository {
    func fetchRepos() async throws -> [Repo] {
        try await RepoAPIClient().getRepos()
    }
}
