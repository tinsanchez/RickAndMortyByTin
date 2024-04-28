//
//  ContentView.swift
//  RickAndMortyByTin
//
//  Created by Valentín Sánchez Campañón on 23/4/24.
//

import SwiftUI

struct MainView: View {
    
    @ObservedObject var mainViewModel: MainViewModel
    @State private var isButtonVisible = false
    
    var filteredByNameCharacters: [RMCharacterModel] {
        mainViewModel.filterByName(mainViewModel.searchText, in: mainViewModel.charactersList)
    }
    
    var filteredByNameFavoritesCharacters: [RMCharacterModel] {
        mainViewModel.filterByName(mainViewModel.searchText, in: mainViewModel.favoritesCharactersList)
    }
    
    var body: some View {
        switch mainViewModel.state {
        case .idle:
            ZStack {
                Image("rm_cover_image")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.top)
                    .overlay(Color.black.opacity(0.15))
                VStack(spacing: 20) {
                    Spacer()
                    Button(action: {
                        mainViewModel.getAllCharacter()
                    }) {
                        Text("getCharacter")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding()
                            .padding(.horizontal, 10)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                .foregroundColor(.red)
                                .shadow(radius: 5)
                            )
                        }
                        .opacity(isButtonVisible ? 1 : 0)
                                    .offset(y: isButtonVisible ? 0 : 100)
                                    .animation(.bouncy, value: isButtonVisible)
                                    .onAppear {
                                        isButtonVisible = true
                                    }
                        .padding(.bottom, 50)
                        .shadow(radius: 5)
                }
            }
        case .loading:
            Text("loading...")
                .fontWeight(.bold)
        case .loaded:
            NavigationSplitView {
                SearchBar(text: $mainViewModel.searchText)
                List {
                    ForEach(filteredByNameFavoritesCharacters.sorted { $0.id < $1.id }) { character in
                        NavigationLink {
                            CharacterDetail(mainViewModel: mainViewModel, selectedCharacter: character)
                        } label: {
                            HStack {
                                Label("Toggle Favorite", systemImage: "star.fill")
                                    .labelStyle(.iconOnly)
                                    .foregroundStyle(.yellow)
                                    .accessibilityHidden(true)
                                CharacterRow(character: character)
                            }
                        }
                        /// Notes: added  a unique id to update the Navigation link after navigate and change some parameters
                        .id(UUID())
                    }
                    ForEach(filteredByNameCharacters.sorted { $0.id < $1.id }) { character in
                        NavigationLink {
                            CharacterDetail(mainViewModel: mainViewModel, selectedCharacter: character)
                        } label: {
                            CharacterRow(character: character)
                        }
                        .id(UUID())
                    }
                }
                
                .navigationTitle("Characters")
            } detail: {
                Text("Select a character")
            }
        case .error:
            ErrorView(errorMessage: "Loading_Error") {
                mainViewModel.getAllCharacter()
            }
        }
    }
}

#Preview {
    MainView(mainViewModel: MainViewModel())
        .environment(\.locale, Locale(identifier: "es"))
}
