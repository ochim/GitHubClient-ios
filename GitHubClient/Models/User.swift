//
//  User.swift
//  GithubClient
//
//  Created by 越智宗洋 on 2023/01/01.
//
struct User: Decodable, Equatable {
    let name: String
    
    private enum CodingKeys: String, CodingKey {
        case name = "login"
    }
}
