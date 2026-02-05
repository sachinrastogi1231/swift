// The Swift Programming Language
// https://docs.swift.org/swift-book
import Foundation

@main
struct producer_consumer {
    let producer: Producer
    let logger: Logger = .init(label: "main")
    let consumer: Consumer
    
    init() {
        let config = Config(args: CommandLine.arguments)
        self.producer = Producer(capacity: config.producer_capacity,
                                 bufferSize: config.bufferSize,
                                 throughput: config.producer_throughput)
        self.consumer = Consumer(throughput: config.consumer_throughput)
    }
    
    static func main() {
        let tool = producer_consumer()
        tool.run()
        CFRunLoopRun()
    }
    
    func run() {
        logger.log("Start")
        Task {
            await withTaskGroup(of: Void.self) { group in
                group.addTask {
                    do {
                        try await self.producer.startProduction()
                    } catch {
                        logger.log(error.localizedDescription)
                    }
                }
                
                group.addTask {
                    do {
                        try await self.consumer.consume(self.producer.products())
                    } catch {
                        logger.log(error.localizedDescription)
                    }
                }
            }
            CFRunLoopStop(CFRunLoopGetMain())
            logger.log("End")

        }
    }
}

