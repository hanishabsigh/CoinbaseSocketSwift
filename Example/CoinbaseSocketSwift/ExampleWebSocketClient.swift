//
//  ExampleWebSocketClient.swift
//  CoinbaseSocketSwift_Example
//
//  Created by Hani Shabsigh on 11/04/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation
import CoinbaseSocketSwift

public class ExampleWebSocketClient: CoinbaseWebSocketClient {
    fileprivate var task: URLSessionWebSocketTask?

    public let url: URL
    
    public required init(url: URL) {
        self.url = url
    }
    
    public weak var delegate: CoinbaseWebSocketClientDelegate?
    
    public func connect() {
        task = URLSession.shared.webSocketTask(with: url)
        task?.resume()
        readMessage()
        delegate?.websocketDidConnect(socket: self)
    }
    
    public func disconnect() {
        task?.cancel()
        task = nil
        delegate?.websocketDidDisconnect(socket: self, error: nil)
    }
    
    public var isConnected: Bool {
        guard let _ = self.task else { return false }
        return true
    }
    
    public func write(string: String, completionHandler: @escaping (Error?) -> Void) {
        task?.send(.string(string), completionHandler: completionHandler)
    }
    
    private func readMessage() {
        guard let task = self.task else { return }
        task.receive { result in
            switch result {
            case .success(.string(let text)):
                self.delegate?.websocketDidReceiveMessage(socket: self, text: text)
                self.readMessage()
            default: break
            }
        }
    }
}
