//
//  NewsSource.swift
//  CtaReactiveMaster
//
//  Created by 小幡 十矛 on 2020/12/06.
//

struct NewsSource: Decodable {
    let status: String
    let totalResults: Int?
    let sources: [Source]?
    let articles: [Article]?

    struct Source: Decodable {
        let id: String?
        let name: String?
    }

    struct Article: Decodable {
        let title: String?
        let author: String?
        let description: String?
        let url: String?
        let urlToImage: String?
        let publishedAt: String?
    }

    private enum CodingKeys: String, CodingKey {
        case status
        case totalResults
        case sources
        case articles
    }
}
