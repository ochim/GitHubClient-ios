//
//  Stateful.swift
//  GithubClient
//
//  Created by 越智宗洋 on 2023/01/05.
//

enum Stateful<Value> {
    case idle // まだデータを取得しにいっていない
    case loading // 読み込み中
    case failed(Error) // 読み込み失敗、遭遇したエラーを保持
    case loaded(Value) // 読み込み完了、読み込まれたデータを保持
}
