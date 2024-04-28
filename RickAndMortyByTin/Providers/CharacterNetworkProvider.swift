//
//  CharacterNetworkProvider.swift
//  RickAndMortyByTin
//
//  Created by Valentín Sánchez Campañón on 23/4/24.
//


import Combine
import Foundation

public struct CharacterNetworkProvider {
    
    public init(client: RMClient) {self.client = client}
    
    let client: RMClient
    let networkHandler: BaseNetworkProvider = BaseNetworkProvider()
    
    public func getCharacterByID(id: Int) async throws -> RMCharacterModel {
        let characterData = try await networkHandler.performAPIRequestByMethod(method: "character/"+String(id))
        let character: RMCharacterModel = try networkHandler.decodeJSONData(data: characterData)
        return character
    }
    
    public func getAllCharacters() async throws -> [RMCharacterModel] {
        let characterData = try await networkHandler.performAPIRequestByMethod(method: "character")
        let infoModel: RMCharacterInfoModel = try networkHandler.decodeJSONData(data: characterData)
        let characters: [RMCharacterModel] = try await withThrowingTaskGroup(of: [RMCharacterModel].self) { group in
            for index in 1...infoModel.info.pages {
                group.addTask {
                    let characterData = try await networkHandler.performAPIRequestByMethod(method: "character/"+"?page="+String(index))
                    let infoModel: RMCharacterInfoModel = try networkHandler.decodeJSONData(data: characterData)
                    return infoModel.results
                }
            }
            
            return try await group.reduce(into: [RMCharacterModel]()) { allCharacters, characters in
                allCharacters.append(contentsOf: characters)
            }
        }
        
        return characters.sorted { $0.id < $1.id }
    }
    
}
