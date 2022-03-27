//
//  TickersService.swift
//  baraka
//
//  Created by Ivan Volnov on 25.03.2022.
//

import Combine
import Foundation
import TabularData


protocol TickerService: AnyObject {
    func tickers() -> AnyPublisher<[Ticker], Error>
}

final class TickerServiceImpl {
    
    // Constants
    private let url = URL(string: "https://raw.githubusercontent.com/dsancov/TestData/main/stocks.csv")!
    
    // Dependencies
    private let session: URLSession
    
    init(session: URLSession) {
        self.session = session
    }
}

// MARK: - TickerService

extension TickerServiceImpl: TickerService {
    
    func tickers() -> AnyPublisher<[Ticker], Error> {
        Timer
            .publish(every: 1.0, on: .main, in: .common)
            .autoconnect()
            .setFailureType(to: Error.self)
            .flatMap { _ in self.dataFrame() }
            .map { dataFrame in self.convert(dataFrame) }
            .eraseToAnyPublisher()
    }
}

// MARK: - Private

extension TickerServiceImpl {
    
    private func dataFrame() -> AnyPublisher<DataFrame, Error> {
        session
            .dataTaskPublisher(for: url)
            .tryMap(handleOutput)
            .eraseToAnyPublisher()
    }
    
    private func convert(_ dataFrame: DataFrame) -> [Ticker] {
        guard let rowGrouping = dataFrame.grouped(by: "STOCK") as? RowGrouping<String> else {
            return []
        }
        return rowGrouping
            .compactMap { grouping in grouping.group.rows.randomElement() }
            .compactMap { row in
                guard
                    let symbol = row[0] as? String,
                    let price = row[1] as? Double else {
                        return nil
                    }
                return Ticker(symbol: symbol, price: price)
            }
    }
    
    private func handleOutput(output: URLSession.DataTaskPublisher.Output) throws -> DataFrame {
        guard
            let response = output.response as? HTTPURLResponse,
            200 ..< 300 ~= response.statusCode,
            let dataFrame = try? DataFrame(csvData: output.data)
        else {
            throw URLError(.badServerResponse)
        }
        return dataFrame
    }
}
