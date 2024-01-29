//
//  ListNavigationView.swift
//  DoggySword
//
//  Created by Helder Nunes on 29/01/2024.
//

import SwiftUI

enum ListNavigationRoutes: Hashable {

    case detail(item: Dog)
}
struct ListNavigationView: View {

    @State private var path: NavigationPath = .init()

    var body: some View {

        NavigationStack(path: self.$path) {
            
            ListView(path: self.$path)
                .navigationTitle("Explorer")
                .navigationDestination(for: ListNavigationRoutes.self) { route in

                    switch route {

                    case let .detail(item):
                        DetailView(item: item)
                    }
                }
        }
    }
}

#Preview {
    ListNavigationView()
}
