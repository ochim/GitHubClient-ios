//
//  Repo.swift
//  GithubClient
//
//  Created by 越智宗洋 on 2023/01/01.
//

struct Repo: Identifiable, Decodable, Equatable {
    var id: Int
    var name: String
    var owner: User
    var description: String?
    var stargazersCount: Int
}
