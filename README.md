# CoinbaseSocketSwift

[![Version](https://img.shields.io/cocoapods/v/CoinbaseSocketSwift.svg?style=flat)](http://cocoapods.org/pods/CoinbaseSocketSwift)
[![License](https://img.shields.io/cocoapods/l/CoinbaseSocketSwift.svg?style=flat)](http://cocoapods.org/pods/CoinbaseSocketSwift)
[![Platform](https://img.shields.io/cocoapods/p/CoinbaseSocketSwift.svg?style=flat)](http://cocoapods.org/pods/CoinbaseSocketSwift)

## Features

- WebSocket library agnostic (use any library you like! the example uses [Starscream](https://github.com/daltoniam/Starscream))
- Minimal Swift codebase with all JSON parsing handled internally
- Objects for all outgoing and incoming channel JSON
- Optional automatic request signing when subscribing to channels

Please read over the [official Coinbase Pro documentation](https://docs.pro.coinbase.com) *before* using this library.

This library was inspired by [GDAXSwift](https://github.com/anthonypuppo/GDAXSwift) and is a continuation of [GDAXSocketSwift](https://github.com/hanishabsigh/GDAXSocketSwift).

## Requirements

- iOS 8.1+ / macOS 10.13+ / tvOS 9.0+ / watchOS 4.0+
- Xcode 9.0+
- Swift 4.0+

## Installation

CoinbaseSocketSwift is available through [CocoaPods](http://cocoapods.org). Check out [Get Started](http://cocoapods.org/) tab on [cocoapods.org](http://cocoapods.org/) to learn more.

To install CoinbaseSocketSwift, simply add the following line to your Podfile:

```ruby
pod 'CoinbaseSocketSwift'
```

Then run:

pod install

## Usage

##### Import

First thing is to import the framework. See the Installation instructions above how to add the framework to your project using [CocoaPods](http://cocoapods.org).

```
import CoinbaseSocketSwift
```

##### Initialize

Create an instance of `CoinbaseSocketClient` using the available initializer. Note that it is probably best to use a property, so it doesn't get deallocated right after being setup.

The `apiKey`, `secret64`, and `passphrase` parameters are optional if you want to receive authenticated messages. Read the [official Coinbase Pro documentation](https://docs.pro.coinbase.com) for more details on authenticated WebSocket messages.

```swift
socketClient = CoinbaseSocketClient(apiKey: "apiKey", secret64: "secret64", passphrase: "passphrase")
```

##### Setup WebSocket

CoinbaseSocketSwift is made to be used with any WebSocket library. As such, a class that conforms to the protocol `CoinbaseWebSocketClient` must be passed in to `CoinbaseSocketClient`. `CoinbaseSocketClient` keeps a strong reference to this socket class and handles connecting, disconnecting, receiving messages, and connection status. Check out the example project to see how to do this with [Starscream](https://github.com/daltoniam/Starscream).

```swift
socketClient.webSocket = ExampleWebSocketClient(url: URL(string: CoinbaseSocketClient.baseProAPIURLString)!)
```

##### Setup Logger (optional)

If you want to see logs from CoinbaseSocketSwift you can optionally pass a class that conforms to the protocol `CoinbaseSocketClientLogger`. A `CoinbaseSocketClientDefaultLogger` is provided with an example of basic logging.

```swift
socketClient?.logger = CoinbaseSocketClientDefaultLogger()
```

##### Setup Delegate

Finally, set a class to receive the delegate calls.

```swift
socketClient?.delegate = self
```

Then you can create an extension and implement the delegate methods. The delegate methods are optional (by way of empty default implementations). 

```swift
extension ViewController: CoinbaseSocketClientDelegate {
	func coinbaseSocketDidConnect(socket: CoinbaseSocketClient) {
		socket.subscribe(channels:[.ticker], productIds:[.BTCUSD])
	}

	func coinbaseSocketDidDisconnect(socket: CoinbaseSocketClient, error: Error?) {

	}

	func coinbaseSocketClientOnErrorMessage(socket: CoinbaseSocketClient, error: ErrorMessage) {
		print(error.message)
	}

	func coinbaseSocketClientOnTicker(socket: CoinbaseSocketClient, ticker: TickerMessage) {
		let formattedPrice = priceFormatter.string(from: ticker.price as NSNumber) ?? "0.0000"
		self.tickerLabel.text = ticker.type.rawValue
		self.priceLabel.text = "Price = " + formattedPrice
		self.productIdLabel.text = ticker.productId.rawValue

		if let time = ticker.time {
			self.timeLabel.text = timeFormatter.string(from: time)
		} else {
			self.timeLabel.text = timeFormatter.string(from: Date())
		}
	}
}
```

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## TODOs

- [ ] Tests...

## Author

Hani Shabsigh, [LinkedIn](http://hanishabsigh.com), [GitHub](https://github.com/hanishabsigh)

## License

CoinbaseSocketSwift is available under the MIT license. See the LICENSE file for more info.

## Donations

Making money using this? Support open source by donating.

Bitcoin: 1EkkFgBZp4jN21b6N85ZWDmxMohytt9L2Z

![Bitcoin](https://i.imgur.com/r7SVFZt.png)


