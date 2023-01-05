//
//  RepoRow.swift
//  GithubClient
//
//  Created by 越智宗洋 on 2023/01/01.
//
import SwiftUI

struct RepoRow: View {
    let repo: Repo
    
    var body: some View {
        HStack {
            Image("GitHubMark")
                .resizable()
                .frame(width: 44.0, height: 44.0)
            
            VStack(alignment: .leading) {
                Text(repo.owner.name)
                    .font(.caption)
                Text(repo.name)
                    .font(.body)
                    .fontWeight(.semibold)
            }
        }
    }
}
