//
//  SearchView.swift
//  DoggySword
//
//  Created by Helder Nunes on 26/01/2024.
//

import SwiftUI

struct SearchView: View {

    let httpManager: HttpManager = HttpManager()

    @Binding var path: NavigationPath

    @State private var imageItems: [Dog] = [Dog]()
    @State private var columns: [GridItem] = [GridItem(.fixed(UIScreen.main.bounds.width - 16))]
    @State private var numberOfColumns = 1
    @State private var columnWidth = UIScreen.main.bounds.width - 16
    @State private var buttonGridLayout = "rectangle.grid.1x2"
    @State private var searchText = ""
    @State private var isShowingAlertError = false

    var body: some View {
    
        ScrollView {
            LazyVGrid(columns: self.columns, spacing: 4) {

                ForEach (self.imageItems) { item in

                    NavigationLink(value: SearchNavigationRoutes.detail(item: item)) {

                        ZStack {

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

                            VStack {

                                Spacer()

                                VStack (alignment: .leading) {

                                    Text(item.breeds.first?.name ?? "N/A")
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .font(.headline)
                                        .padding(.horizontal, 8)
                                    Text(item.breeds.first?.breedGroup ?? "N/A")
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .font(.caption)
                                        .padding(.horizontal, 8)
                                    Text(item.breeds.first?.origin ?? "N/A")
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .font(.caption2)
                                        .padding(.horizontal, 8)
                                }
                                .frame(height: 150)
                                .frame(maxWidth: .infinity)
                                .background(Gradient(colors: [Color.black.opacity(0.0), Color.black.opacity(0.9)]))
                                .bold()
                                .foregroundStyle(.white)
                            }
                        }
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                    }
                }
            }
            .padding(.horizontal, 8)

        }
        .toolbar {

            Button("", systemImage: self.buttonGridLayout) {

                if numberOfColumns == 2 {

                    self.numberOfColumns = 1
                    self.columnWidth = UIScreen.main.bounds.width - 16
                    self.columns = [GridItem(.fixed(self.columnWidth))]
                    self.buttonGridLayout = "rectangle.grid.1x2"

                } else {

                    self.numberOfColumns = 2
                    self.columnWidth = ((UIScreen.main.bounds.width - 16) / 2) - 4
                    self.columns = [GridItem(.fixed(self.columnWidth)), GridItem(.fixed(self.columnWidth))]
                    self.buttonGridLayout = "square.grid.2x2"
                }
            }
        }
        .alert("Error", isPresented: self.$isShowingAlertError, actions: {

            Button("Ok", role: .cancel) { }

        }, message: {

            Text("Something went wrong!! 😱")
        })
        .searchable(text: self.$searchText, prompt: "Search for breed")
        .onSubmit(of: .search, self.fetch)
    }

    private func fetch() {

        Task {

            do {

                self.imageItems = []


                let queryItems = [
                    URLQueryItem(name: "q", value: self.searchText),
                ]

                let breeds: [Breed] = try await self.httpManager.request(Resource(url: Routes.breeds, method: .get(queryItems)))

                for breed in breeds {

                    guard let referenceImageId = breed.referenceImageId else { throw NetworkError.badURL }

                    let dog: Dog = try await self.httpManager.request(Resource(url: Routes.image.appending(path: referenceImageId)))

                    self.imageItems.append(dog)
                }
            } catch {

                self.isShowingAlertError.toggle()
            }
        }
    }
}

#Preview {
    SearchView(path: .constant(NavigationPath()))
}
