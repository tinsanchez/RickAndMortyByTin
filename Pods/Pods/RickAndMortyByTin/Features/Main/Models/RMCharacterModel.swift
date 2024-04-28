//
//  CharacterModel.swift
//  RickAndMortyByTin
//
//  Created by Valentín Sánchez Campañón on 23/4/24.
//

import Foundation

public struct RMCharacterFilter {
    public let name: String
    public let status: String
    public let species: String
    public let type: String
    public let gender: String
    public let query: String
}

struct RMCharacterInfoModel: Codable {
    let info: Info
    let results: [RMCharacterModel]
}

public struct RMCharacterModel: Codable, Identifiable, Equatable {
    
    public let id: Int
    public let name: String
    public let status: String
    public let species: String
    public let type: String
    public let gender: String
    public let origin: RMCharacterOriginModel
    public let location: RMCharacterLocationModel
    public let image: String
    public let episode: [String]
    public let url: String
    public let created: String
    
    public static func == (lhs: RMCharacterModel, rhs: RMCharacterModel) -> Bool {
        return lhs.id == rhs.id && lhs.name == rhs.name
    }
}

public struct RMCharacterOriginModel: Codable {
    public let name: String
    public let url: String
}

public struct RMCharacterLocationModel: Codable {
    public let name: String
    public let url: String
}

public enum Status: String {
    case alive = "alive"
    case dead = "dead"
    case unknown = "unknown"
    case none = ""
}

public enum Gender: String {
    case female = "female"
    case male = "male"
    case genderless = "genderless"
    case unknown = "unknown"
    case none = ""
}
