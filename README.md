# CoreNetworking

A very simple **Swift Package** to help networking tasks in Swift.

## Advice

This is a work in progress project. New features are being added. Contributions are welcome!

## Getting started

1. Add package to your project (Xcode > File > Swift Packages > Add Package Dependency...). Point to branch `master`.
2. Search for the following url: https://github.com/persiogv/CoreNetworking
3. Add `import CoreNetworking` in your Swift file

## NetworkingProvider

#### Requests

```swift
  /// Performs an HTTP request using a given URL and HTTP method
  ///
  /// - Parameters:
  ///   - url: The URL to be requested
  ///   - method: The HTTP request method
  ///   - session: Your URLSession, optional
  ///   - body: A data to be sent as the request body, optional
  ///   - headers: Your HTTP headers, optional
  ///   - completion: A closure called when the request is finished
  public final func request(url: URL,
               method: RequestMethod,
               session: URLSession = URLSession.shared,
               body: Data? = nil,
               headers: [RequestHeader]? = nil,
               completion: @escaping RequestCompletion)
```

#### Uploads

```swift
  /// Performs an HTTP file upload using a given URL and HTTP method
  ///
  /// - Parameters:
  ///   - url: The URL to send the file
  ///   - method: The HTTP request method, should not be different of POST or PUT
  ///   - data: The data of the file to be uploaded
  ///   - session: Your URLSession, optional
  ///   - completion: A closure called when the upload is finished
  public final func upload(url: URL,
              method: RequestMethod,
              data: Data,
              session: URLSession = URLSession.shared,
              completion: @escaping RequestCompletion)
```

#### Downloads

```swift
  /// Performs an HTTP file download using a given URL
  ///
  /// - Parameters:
  ///   - url: The URL that contains the file to be downloaded
  ///   - session: Your URLSession, optional
  ///   - completion: A closure called when the download is finished
  public final func download(url: URL, session: URLSession = URLSession.shared, completion: @escaping RequestCompletion)
```

## ApiProvider

#### GET

```swift
  /// GET
  ///
  /// - Parameters:
  ///   - path: The path of the service
  ///   - headers: HTTP headers
  ///   - parameters: Parameters to send within the request
  ///   - completion: Callback completion handler
  public final func GET(path: String, headers: [RequestHeader], parameters: [RequestParameter], completion: @escaping RequestCompletion)
```

#### POST

```swift
  /// POST
  ///
  /// - Parameters:
  ///   - path: The path of the service
  ///   - body: Optional data to send within the request
  ///   - headers: HTTPHeaders
  ///   - completion: Callback completion handler
public final func POST(path: String, body: Data?, headers: [RequestHeader], completion: @escaping RequestCompletion)
```

## License

The MIT License (MIT)

Copyright (c) 2020 Persio Vieira

Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in
the Software without restriction, including without limitation the rights to
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
the Software, and to permit persons to whom the Software is furnished to do so,
subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
