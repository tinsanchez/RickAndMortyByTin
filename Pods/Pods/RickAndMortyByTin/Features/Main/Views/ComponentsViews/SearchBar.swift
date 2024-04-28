//
//  SearchBar.swift
//  RickAndMortyByTin
//
//  Created by Valentín Sánchez Campañón on 28/4/24.
//

import SwiftUI

struct SearchBar: View {
    
    @Binding var text: String
        
        var body: some View {
            HStack {
                TextField("Search...", text: $text)
                    .padding(.horizontal)
                    .padding(.vertical, 8)
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                
                Button(action: {
                    text = ""
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.gray)
                        .padding(.trailing)
                }
            }
            .padding(.horizontal)
        }
}

#Preview {
    SearchBar(text: .constant(""))
}
