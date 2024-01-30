//
//  SearchNavigationView.swift
//  DoggySword
//
//  Created by Helder Nunes on 29/01/2024.
//

import SwiftUI

enum SearchNavigationRoutes: Hashable {

    case detail(item: Dog)
}

struct SearchNavigationView: View {

    @State private var path: NavigationPath = .init()

    var body: some View {

        NavigationStack(path: self.$path) {

            SearchView(path: self.$path)
                .navigationTitle("Search")
                .navigationDestination(for: SearchNavigationRoutes.self) { route in

                    switch route {

                    case let .detail(item: item):
                        DetailView(item: item)
                    }
                }
        }
    }
}

#Preview {
    SearchNavigationView()
}
