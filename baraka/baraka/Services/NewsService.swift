//
//  NewsService.swift
//  baraka
//
//  Created by Ivan Volnov on 25.03.2022.
//

import Foundation
import Combine

protocol NewsService: AnyObject {
    func articles() -> AnyPublisher<[Article], Error>
}

final class NewsServiceImpl {
    
    // Constants
    private let url = URL(string: "https://saurav.tech/NewsAPI/everything/cnn.json")!
    
    // Dependencies
    private let decoder: JSONDecoder
    private let session: URLSession
    
    
    init(session: URLSession, decoder: JSONDecoder) {
        self.session = session
        self.decoder = decoder
    }
}

extension NewsServiceImpl: NewsService {
    
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
