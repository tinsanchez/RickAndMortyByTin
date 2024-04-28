//
//  BaseNetworkProvider.swift
//  RickAndMortyByTin
//
//  Created by Valentín Sánchez Campañón on 23/4/24.
//

import Foundation

struct Info: Codable {
    let count: Int
    let pages: Int
    let next: String?
    let prev: String?
}

enum NetworkHandlerError: Error {
    case InvalidURL
    case JSONDecodingError
    case RequestError(String)
    case UnknownError
}

struct ResponseErrorMessage: Codable {
    let error: String
}

public struct RMClient {
    
    public init() {}
    
    public func character() -> CharacterNetworkProvider {
        let character = CharacterNetworkProvider(client: self)
        return character
    }
}

public struct BaseNetworkProvider {
    var baseURL: String = "https://rickandmortyapi.com/api/"
    
    func performAPIRequestByMethod(method: String) async throws -> Data {
        if let url = URL(string: baseURL+method) {
            print("RequestURL: \(baseURL)\(method)")
            let (data, response) = try await URLSession.shared.data(from: url)
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, 200..<299 ~= statusCode else {
               let error: ResponseErrorMessage = try decodeJSONData(data: data)
               throw NetworkHandlerError.RequestError(error.error)
            }
            return data
        } else {
            throw(NetworkHandlerError.InvalidURL)
        }
    }
    
    func performAPIRequestByURL(url: String) async throws -> Data {
        if let url = URL(string: url) {
            print("RequestURL: \(url)")
            let (data, response) = try await URLSession.shared.data(from: url)
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, 200..<299 ~= statusCode else {
               let error: ResponseErrorMessage = try decodeJSONData(data: data)
               throw NetworkHandlerError.RequestError(error.error)
            }
            return data
        } else {
            throw(NetworkHandlerError.InvalidURL)
        }
    }
    
    func decodeJSONData<T: Codable>(data: Data) throws -> T {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(T.self, from: data)
            return decodedData
        } catch {
            throw NetworkHandlerError.JSONDecodingError
        }
    }
}
