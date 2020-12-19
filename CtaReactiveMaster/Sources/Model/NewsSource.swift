//
//  NewsSource.swift
//  CtaReactiveMaster
//
//  Created by 小幡 十矛 on 2020/12/06.
//

struct NewsSource: Decodable {
    let status: String
    let totalResults: Int?
    let articles: [Article]
}

struct Article: Decodable {
    let title: String?
    let author: String?
    let description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String?
    let content: String?
    let source: Source
}

struct Source: Decodable {
    let id: String?
    let name: String?
}
