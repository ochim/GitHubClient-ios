//
//  RepoListViewModelTests.swift
//
//  Created by 越智宗洋 on 2023/01/06.
//

import XCTest

@testable import GithubClient

class RepoListViewModelTests: XCTestCase {

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
    
    func test_onAppear_異常系() async {
        let viewModel = await RepoListViewModel(
            repoRepository: MockRepoRepository(
                repos: [],
                error: DummyError()
            )
        )

        await viewModel.onAppear()

        switch await viewModel.state {
        case let .failed(error):
            XCTAssert(error is DummyError)
        default:
            XCTFail()
        }
    }
}
