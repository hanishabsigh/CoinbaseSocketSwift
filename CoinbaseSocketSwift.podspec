Pod::Spec.new do |s|
  s.name             = 'CoinbaseSocketSwift'
  s.version          = '1.0.3'
  s.summary          = 'Unofficial Swift implementation of Coinbase WebSocket API.'
  s.homepage         = 'https://github.com/hanishabsigh/CoinbaseSocketSwift'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Hani Shabsigh' => 'hani@neuecoin.com' }
  s.source           = { :git => 'https://github.com/hanishabsigh/CoinbaseSocketSwift.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/hanishabsigh'
  s.ios.deployment_target = '8.1'
  s.osx.deployment_target = '10.13'
  s.tvos.deployment_target = '9.0'
  s.watchos.deployment_target = '4.0'
  s.source_files = 'CoinbaseSocketSwift/Classes/**/*'
  s.dependency 'CryptoSwift'
  s.swift_version = '5.0'
end
