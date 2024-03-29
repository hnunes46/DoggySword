//
//  HttpManager.swift
//  DoggySword
//
//  Created by Helder Nunes on 26/01/2024.
//

import Foundation

enum NetworkError: Error {

    case badURL
    case invalidResponse
    case decodingError
    case invalidServerResponse
    case invalidURL
}

enum HttpMethod {

    case get([URLQueryItem])
    case post(Data?)
    case put(Data?)
    case delete

    var name: String {

        switch self {

        case .get:
            return "GET"

        case .post:
            return "POST"

        case .put:
            return "PUT"

        case .delete:
            return "DELETE"
        }
    }
}

struct Resource<T: Codable> {

    let url: URL
    var headers: [String: String] = ["x-api-key": "live_cvkdFFvfmACE3tKIv1ydA1ZYTOWNhKJnp04NNfqs6AalUpyQIwjg1BqwHHclPWUU"]
    var method: HttpMethod = .get([])
}

class HttpManager {

    func request<T: Codable>(_ resource: Resource<T>) async throws -> T {

        var request = URLRequest(url: resource.url)
        request.allHTTPHeaderFields = resource.headers
        request.httpMethod = resource.method.name

        switch resource.method {

        case .get(let queryItems):
            var components = URLComponents(url: resource.url, resolvingAgainstBaseURL: true)
            components?.queryItems = queryItems

            guard let url = components?.url else { throw NetworkError.badURL }

            request.url = url

        default:
            break
        }

        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = ["Content-Type": "application/json"]

        let session = URLSession(configuration: configuration)

        let (data, response) = try await session.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse,
                httpResponse.statusCode == 200 || httpResponse.statusCode == 201 else {

            throw NetworkError.invalidResponse
        }

        guard let result = try? JSONDecoder().decode(T.self, from: data) else {

            throw NetworkError.decodingError
        }

        return result
    }
}
