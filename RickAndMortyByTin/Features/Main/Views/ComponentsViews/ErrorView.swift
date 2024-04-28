//
//  ErrorView.swift
//  RickAndMortyByTin
//
//  Created by Valentín Sánchez Campañón on 28/4/24.
//

import SwiftUI

struct ErrorView: View {
    
    var errorMessage: String
    let retryAction: (() -> Void)?
    
    var body: some View {
        VStack(spacing: 20) {
                    Image(systemName: "exclamationmark.triangle")
                        .font(.system(size: 50))
                        .foregroundColor(.red)
                    
                    Text("Error")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.red)
                    
            Text(LocalizedStringKey(errorMessage))
                        .multilineTextAlignment(.center)
                        .foregroundColor(.gray)
                    
                    if let retryAction = retryAction {
                        Button("Retry", action: retryAction)
                            .padding(.vertical, 10)
                            .padding(.horizontal, 20)
                            .background(Color.red)
                            .foregroundColor(.white)
                            .font(.headline)
                            .cornerRadius(10)
                            .shadow(color: .black.opacity(0.3), radius: 5, x: 0, y: 2)
                    }
                }
                .padding(20)
                .background(Color.white)
                .cornerRadius(20)
                .shadow(color: .black.opacity(0.3), radius: 10, x: 0, y: 5)
    }
}
#Preview {
    ErrorView(errorMessage: "Loading_Error") {
        
    }
}
