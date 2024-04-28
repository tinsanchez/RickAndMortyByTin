//
//  MainViewModel.swift
//  RickAndMortyByTin
//
//  Created by Valentín Sánchez Campañón on 24/4/24.
//

import Foundation
import Combine

final class MainViewModel: ObservableObject {
    
    enum State {
        case idle
        case loading
        case loaded
        case error
    }
        
    @Published var charactersList: [RMCharacterModel] = []
    @Published var favoritesCharactersList: [RMCharacterModel]
    @Published var state = State.idle
    @Published var searchText = ""
    
    let client = RMClient()
    let saveKey = "favoritesCharacters"
    
    init() {
        if let data = UserDefaults.standard.data(forKey: saveKey) {
            if let decoded = try? JSONDecoder().decode([RMCharacterModel].self, from: data) {
                favoritesCharactersList = decoded
                return
            }
        }
        favoritesCharactersList = []
    }
    
    func save() {
        if let encoded = try? JSONEncoder().encode(favoritesCharactersList) {
            UserDefaults.standard.set(encoded, forKey: saveKey)
        }
    }
    
    func add(_ character: RMCharacterModel) {
        guard let index = charactersList.firstIndex(of: character) else { return }
        favoritesCharactersList.append(character)
        charactersList.remove(at: index)
        save()
    }
    
    func remove(_ character: RMCharacterModel) {
        guard let index = favoritesCharactersList.firstIndex(of: character) else { return }
        favoritesCharactersList.remove(at: index)
        charactersList.insert(character, at: character.id)
        save()
    }
    
    func fetchAllCharacter() async {
        state = .loading
        do {
            let characters = try await client.character().getAllCharacters()
            await MainActor.run {
                let newCharacters = characters.filter { newCharacter in
                    !favoritesCharactersList.contains(where: { $0.id == newCharacter.id })
                }
                for newCharacter in newCharacters {
                    charactersList.append(newCharacter)
                }
                let sortedCharacter = charactersList.sorted { $0.id < $1.id }
                charactersList = sortedCharacter
            }
        } catch  {
            state = .error
        }
        
    }
    
    func getAllCharacter() {
        Task {
            await fetchAllCharacter()
            state = .loaded
        }
    }
    
    func filterByName(_ name: String, in characters: [RMCharacterModel]) -> [RMCharacterModel] {
        if name.isEmpty {
            return characters
        } else {
            return characters.filter { $0.name.lowercased().contains(name.lowercased()) }
        }
    }
}
