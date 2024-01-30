//
//  TabBar.swift
//  DoggySword
//
//  Created by Helder Nunes on 26/01/2024.
//

import SwiftUI

struct TabBar: View {

    var body: some View {

        TabView {

            ListNavigationView()
                .tabItem { Label("Dogs", systemImage: "pawprint.fill") }

            SearchNavigationView()
                .tabItem { Label("Search", systemImage: "magnifyingglass") }
        }
    }
}

#Preview {
    TabBar()
}
