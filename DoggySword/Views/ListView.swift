//
//  ListView.swift
//  DoggySword
//
//  Created by Helder Nunes on 26/01/2024.
//

import SwiftUI

struct ListView: View {

    let httpManager: HttpManager = HttpManager()
    @State private var imageItems: [Dog] = [Dog]()
    @State private var columns: [GridItem] = [GridItem(.fixed(UIScreen.main.bounds.width - 16))]
    @State private var numberOfColumns = 2
    @State private var columnWidth = UIScreen.main.bounds.width - 16
    @State private var page: Int = 0
    var body: some View {
    
        NavigationStack {
            
            ScrollView {

//                DynamicGrid(gridItems: self.gridItems, numOfColumns: 2, spacing: 4)
                LazyVGrid(columns: self.columns, spacing: 4) {

                    ForEach (self.imageItems) { item in

                        AsyncImage(url: item.url) { image in

                            image
                                .resizable()
                                .scaledToFill()
                                .frame(width: self.columnWidth, height: 300)
                                .clipped()

                        } placeholder: {

                            Rectangle()
                                .foregroundColor(.gray)

                        }
                        .frame(height: 300)
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                        .task {
                            
                            self.isLastElement(item: item)
                        }
                    }
                }
                .padding(.horizontal, 8)

            }
            .navigationTitle("Explorer")
            .toolbar{

                Button("View") {

                    if numberOfColumns == 2 {

                        self.numberOfColumns = 1
                        self.columnWidth = UIScreen.main.bounds.width - 16
                        self.columns = [GridItem(.fixed(self.columnWidth))]

                    } else {

                        self.numberOfColumns = 2
                        self.columnWidth = (UIScreen.main.bounds.width - 16) / 2 - 4
                        self.columns = [GridItem(.fixed(self.columnWidth)), GridItem(.fixed(self.columnWidth))]
                    }
                }
            }
            .onAppear {

                self.fetch()
            }
        }
    }

    private func fetch() {

        Task {

            do {

                let queryItems = [
                    URLQueryItem(name: "limit", value: "50"),
                    URLQueryItem(name: "include_breeds", value: "true"),
                    URLQueryItem(name: "page", value: "\(self.page)")
                ]

                let response: [Dog] = try await self.httpManager.request(Resource(url: Routes.search, method: .get(queryItems)))
                self.imageItems.append(contentsOf: response)

                print("DEBUG: \(self.imageItems.count)")
            } catch {

                print("\(error.localizedDescription)")
            }
        }
    }

    private func isLastElement(item: Dog) {

        if imageItems[self.imageItems.count - 15].id == item.id {
            self.page = page + 1
            self.fetch()
        }
    }
}

#Preview {
    ListView()
}
