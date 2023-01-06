//
//  GitHubClientApp.swift
//  GitHubClient
//
//  Created by 越智宗洋 on 2022/12/29.
//

import SwiftUI

@main
struct GitHubClientApp: App {
    var body: some Scene {
        WindowGroup {
            RepoListView(viewModel: RepoListViewModel())
        }
    }
}
