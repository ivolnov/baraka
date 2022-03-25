//
//  NewsService.swift
//  baraka
//
//  Created by Ivan Volnov on 25.03.2022.
//

import Foundation
import Combine

final class NewsServiceeImpl {
    
    private let url = URL(string: "https://saurav.tech/NewsAPI/everything/cnn.json")!
    
    private let session = URLSession.shared
    
    private lazy var decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return decoder
    }()
    
    func articles() -> AnyPublisher<[Article], Error> {
        session
            .dataTaskPublisher(for: url)
            .tryMap() { element -> Data in
                guard let response = element.response as? HTTPURLResponse,
                      200 ..< 300 ~= response.statusCode else {
                        throw URLError(.badServerResponse)
                    }
                return element.data
                }
            .decode(type: News.self, decoder: decoder)
            .map { news in news.articles}
            .eraseToAnyPublisher()
    }
}
