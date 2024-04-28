//
//  CharacterRow.swift
//  RickAndMortyByTin
//
//  Created by Valentín Sánchez Campañón on 27/4/24.
//

import SwiftUI
import Kingfisher

struct CharacterRow: View {
    
    @State var character: RMCharacterModel
    
    var body: some View {
        HStack {
            /// Notes: import Kingsfisher to cached image and improve performance
            KFImage(URL(string: character.image))
                .resizable()
                .frame(width: 80, height: 80)
                .clipShape(.rect(cornerRadius: 10))
                .padding(.trailing, 25)
            
            .frame(width: 80, height: 80)
            .clipShape(.rect(cornerRadius: 10))
            .padding(.trailing, 25)
            Text(character.name)
                .fontWeight(.bold)
                .tint(.red)
            Spacer()
        }
    }
}

#Preview {
    CharacterRow(character: RMCharacterModel(id: 0, name: "toTest", status: "toTest", species: "toTest", type: "toTest", gender: "toTest", origin: RMCharacterOriginModel(name: "toTest", url: "toTest"), location: RMCharacterLocationModel(name: "toTest", url: "toTest"), image: "toTest", episode: [], url: "toTest", created: "toTest"))
}
