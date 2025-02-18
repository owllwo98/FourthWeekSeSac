//
//  Book.swift
//  FourthWeekSeSac
//
//  Created by 변정훈 on 1/15/25.
//

import Foundation


struct Book: Decodable {
    let documents: [BookDetail]
    let meta: metaDetail
}

struct BookDetail: Decodable {
    let contents: String
    let price : Int
    let title: String
    let thumbnail: String
}

struct metaDetail: Decodable {
    let is_end: Bool
}
