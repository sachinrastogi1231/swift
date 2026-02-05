//
//  Producer.swift
//  producer-consumer
//
//  Created by Sachin Rastogi on 2/3/26.
//

import Foundation

actor Producer {
    private let stream: AsyncStream<Int>
    private let continuation: AsyncStream<Int>.Continuation
    private let capacity: Int
    private let throughput: Int
    private let bufferSize: Int
    private let logger: Logger = .init(label: "Producer")
    
    init(capacity: Int, bufferSize: Int, throughput: Int) {
        self.capacity = capacity
        self.throughput = throughput
        self.bufferSize = bufferSize
        var cont: AsyncStream<Int>.Continuation!
        let policy: AsyncStream<Int>.Continuation.BufferingPolicy =
        bufferSize > 0 ? .bufferingNewest(bufferSize) : .unbounded
        stream = AsyncStream(bufferingPolicy: policy) { cont = $0 }
        self.continuation = cont
    }
    
    func startProduction() throws {
        logger.log("Starting producer with capacity \(capacity), buffer size \(bufferSize) and throughput \(throughput)")
        Task {
            for val in 1...capacity {
                logger.log("Producing \(val)")
                continuation.yield(val)
                try await Task.sleep(nanoseconds: 1_000_000_000 / UInt64(throughput))
            }
            logger.log("Ending producer")
            continuation.finish()
        }
    }
    
    func products() -> AsyncStream<Int> {
        stream
    }
}
