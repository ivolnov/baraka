//
//  TickersService.swift
//  baraka
//
//  Created by Ivan Volnov on 25.03.2022.
//

import Combine
import Foundation
import TabularData

final class TickerServiceImpl {
    
    private let url = URL(string: "https://raw.githubusercontent.com/dsancov/TestData/main/stocks.csv")!
    
    private let session = URLSession.shared
    
    
    func tickers() -> AnyPublisher<[Ticker], Error> {
        Timer
            .publish(every: 1.0, on: .main, in: .common)
            .autoconnect()
            .setFailureType(to: Error.self)
            .flatMap { _ in self.csv() }
            .map { csv in self.convert(dataFrame: csv) }
            .eraseToAnyPublisher()
    }
    
    private func csv() -> AnyPublisher<DataFrame, Error> {
        session
            .dataTaskPublisher(for: url)
            .tryMap(handleOutput)
            .eraseToAnyPublisher()
    }
    
    private func convert(dataFrame: DataFrame) -> [Ticker] {
         (dataFrame.grouped(by: "STOCK") as! RowGrouping<String>)
            .compactMap { grouping in grouping.group.rows.randomElement() }
            .map { row in Ticker(symbol: row[0] as! String, price: row[1] as! Double)  }
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
