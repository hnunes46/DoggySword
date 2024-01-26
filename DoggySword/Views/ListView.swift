//
//  ListView.swift
//  DoggySword
//
//  Created by Helder Nunes on 26/01/2024.
//

import SwiftUI

struct ListView: View {

    let httpManager: HttpManager = HttpManager()

    var body: some View {
    
        VStack {

            Text("List View")
            
        }
        .onAppear {

            Task {

                do {
                    
                    let queryItems = [URLQueryItem(name: "limit", value: "50"), URLQueryItem(name: "include_breeds", value: "true")]
                    let response: [Dog] = try await self.httpManager.request(Resource(url: Routes.search, method: .get(queryItems)))

                    print("DEBUG: \(response)")

                } catch {

                    print("\(error)")
                }
            }

        }
    }
}

#Preview {
    ListView()
}
