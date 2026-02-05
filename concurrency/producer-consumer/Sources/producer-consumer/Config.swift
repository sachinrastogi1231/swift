//
//  Config.swift
//  producer-consumer
//
//  Created by Sachin Rastogi on 2/3/26.
//
import Foundation

struct Config {
    var producer_capacity: Int = 1
    var producer_throughput: Int = 1
    var bufferSize: Int = -1
    var consumer_throughput: Int = 1
    
    init(args: [String]) {
        var i = 0
        while i < args.count {
            if args[i] == "-pc", i+1 < args.count, let val = Int(args[i+1]) {
                self.producer_capacity = val
                i += 1
            } else if args[i] == "-pt", i+1 < args.count, let val = Int(args[i+1]) {
                self.producer_throughput = val
                i += 1
            } else if args[i] == "-b", i+1 < args.count, let val = Int(args[i+1]) {
                self.bufferSize = val
                i += 1
            } else if args[i] == "-ct", i+1 < args.count, let val = Int(args[i+1]) {
                self.consumer_throughput = val
                i += 1
            }
            i += 1
        }

    }
}

