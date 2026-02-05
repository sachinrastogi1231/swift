//
//  Consumer.swift
//  producer-consumer
//
//  Created by Sachin Rastogi on 2/3/26.
//

actor Consumer {
    private let throughput: Int
    private let logger: Logger = .init(label: "Consumer")
    
    init(throughput: Int) {
        self.throughput = throughput
    }
    
    func consume(_ products: AsyncStream<Int>) async throws {
        logger.log("Starting consumer with throughput \(throughput)")
        for await val in products {
            logger.log("Consuming: \(val)")
            try await Task.sleep(nanoseconds: 1000_000_000 / UInt64(throughput))
        }
        logger.log("Finished consuming")
    }
}
