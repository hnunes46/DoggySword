//
//  LocalNavigationView.swift
//  DoggySword
//
//  Created by Helder Nunes on 30/01/2024.
//

import SwiftUI

enum LocalNavigationRoutes: Hashable {

    case detail(item: ImageBreed)
}

struct LocalNavigationView: View {
    
    @State private var path: NavigationPath = .init()

    var body: some View {
    
        NavigationStack(path: self.$path) {

            LocalView(path: self.$path)
                .navigationTitle("Local")
                .navigationDestination(for: LocalNavigationRoutes.self) { route in

                    switch route {

                    case let .detail(item):
                        DetailView(item: item)
                    }
                }
        }
    }
}

#Preview {
    LocalNavigationView()
}
