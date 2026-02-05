//
//  Logger.swift
//  producer-consumer
//
//  Created by Sachin Rastogi on 2/3/26.
//
import Foundation

struct Logger {
    private let label: String
    
    init(label: String) {
        self.label = label
    }
    
    func log(_ message: String) {
        FileHandle.standardOutput.write("[\(label)] \(message)\n".data(using: .utf8)!)
    }
}
