//
//  RickAndMortyByTinApp.swift
//  RickAndMortyByTin
//
//  Created by Valentín Sánchez Campañón on 23/4/24.
//

import SwiftUI

@main
struct RickAndMortyByTinApp: App {
    var body: some Scene {
        WindowGroup {
            MainView(mainViewModel: MainViewModel()).preferredColorScheme(.light)
        }
    }
}
