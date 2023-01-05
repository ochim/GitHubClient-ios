//
//  RepoListViewModelTests.swift
//
//  Created by 越智宗洋 on 2023/01/06.
//

import XCTest

@testable import GithubClient

class RepoListViewModelTests: XCTestCase {
    struct MockRepoRepository: RepoRepository {
        let repos: [Repo]

        init(repos: [Repo]) {
            self.repos = repos
        }

        func fetchRepos() async throws -> [Repo] {
            repos
        }
    }

    func test_onAppear_正常系() async {
        let viewModel = await RepoListViewModel(
            repoRepository: MockRepoRepository(
                repos: [.mock1, .mock2]
            )
        )

        await viewModel.onAppear()

        switch await viewModel.state {
        case let .loaded(repos):
            XCTAssertEqual(repos, [.mock1, .mock2])
        default:
            XCTFail()
        }
    }
    
}

