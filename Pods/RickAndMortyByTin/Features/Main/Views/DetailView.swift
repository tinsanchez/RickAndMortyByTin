//
//  DetailView.swift
//  RickAndMortyByTin
//
//  Created by Valentín Sánchez Campañón on 26/4/24.
//

import SwiftUI
import Kingfisher

struct CharacterDetail: View {
    
    @ObservedObject var mainViewModel: MainViewModel
    @State var selectedCharacter: RMCharacterModel
    
    var isFavoriteCharacter: Bool {
        let isFavoriteCharacter = mainViewModel.favoritesCharactersList.contains { $0.id == selectedCharacter.id
        }
        return isFavoriteCharacter
    }
    
    var body: some View {
        VStack {
            /// Notes: import Kingsfisher to cached image and improve performance
            KFImage(URL(string: selectedCharacter.image))
                .resizable()
                .clipShape(Circle())
                .overlay {
                    Circle().stroke(.white, lineWidth: 4)
                }
                .shadow(color: .purple, radius: 7, x: 0.0, y: 0.0)
                .padding(40)
                .padding(.bottom, -40)
                .accessibilityHidden(true)

            ScrollView() {
                HStack {
                    Text(selectedCharacter.name)
                        .font(.title)
                        .foregroundColor(.purple)
                        .bold()
                        .padding(.trailing, 20)
                    Button {
                        if isFavoriteCharacter {
                            mainViewModel.remove(selectedCharacter)
                        } else {
                            mainViewModel.add(selectedCharacter)
                        }
                    } label: {
                        Label("Toggle Favorite", systemImage: isFavoriteCharacter ? "star.fill" : "star")
                            .labelStyle(.iconOnly)
                            .foregroundStyle(isFavoriteCharacter ? .yellow : .purple)
                            .font(.system(size: 30))
                    }.accessibilityHint(isFavoriteCharacter ? "Seleccionado" : "No seleccionado")
                        
                }
                Divider()
                HStack {
                    Text("Status:")
                        .foregroundColor(.purple)
                    Spacer()
                    Text(selectedCharacter.status)
                        .foregroundColor(.purple)
                }
                .font(.title3)
                .foregroundStyle(.primary)
                .padding(.top, 10)
                .padding(.horizontal, 40)
                HStack {
                    Text("Species:")
                        .foregroundColor(.purple)
                    Spacer()
                    Text(selectedCharacter.species)
                        .foregroundColor(.purple)
                }
                .font(.title3)
                .foregroundStyle(.primary)
                .padding(.top, 10)
                .padding(.horizontal, 40)
                HStack {
                    Text("Gender:")
                        .foregroundColor(.purple)
                    Spacer()
                    Text(selectedCharacter.gender)
                        .foregroundColor(.purple)
                }
                .font(.title3)
                .foregroundStyle(.primary)
                .padding(.top, 10)
                .padding(.horizontal, 40)
                HStack {
                    Text("Origin:")
                        .foregroundColor(.purple)
                    Spacer()
                    Text(selectedCharacter.origin.name)
                        .foregroundColor(.purple)
                }
                .font(.title3)
                .foregroundStyle(.primary)
                .padding(.top, 10)
                .padding(.horizontal, 40)
                HStack {
                    Text("Location:")
                        .foregroundColor(.purple)
                    Spacer()
                    Text(selectedCharacter.location.name)
                        .foregroundColor(.purple)
                }
                .font(.title3)
                .foregroundStyle(.primary)
                .padding(.top, 10)
                .padding(.horizontal, 40)
            }
            .padding()
            .offset(y: -0)
            Spacer()
        }
    }
}


#Preview {
    CharacterDetail(mainViewModel: MainViewModel(), selectedCharacter: RMCharacterModel(id: 1, name: "toTest", status: "toTest", species: "toTest", type: "toTest", gender: "toTest", origin: RMCharacterOriginModel(name: "toTest", url: "toTest"), location: RMCharacterLocationModel(name: "toTest", url: "toTest"), image: "toTest", episode: [], url: "toTest", created: "toTest"))
}
