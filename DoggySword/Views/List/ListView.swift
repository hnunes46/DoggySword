//
//  ListView.swift
//  DoggySword
//
//  Created by Helder Nunes on 26/01/2024.
//

import SwiftUI

enum ImageSorting: String, CaseIterable, Identifiable {
    
    case none
    case ascending
    case descending
    var id: Self { return self }

    var title: String {

        switch self {
            
        case .none:
                return "No order"
        
        case .ascending:
                return "Ascending"

        case .descending:
               return "Descending"
        }
    }

    var value: String {

        switch self {

        case .none:
                return "RAND"

        case .ascending:
                return "ASC"

        case .descending:
               return "DESC"
        }
    }
}

struct ListView: View {

    let httpManager: HttpManager = HttpManager()

    @Binding var path: NavigationPath

    @State private var imageItems: [Dog] = [Dog]()
    @State private var columns: [GridItem] = [GridItem(.fixed(UIScreen.main.bounds.width - 16))]
    @State private var numberOfColumns = 1
    @State private var columnWidth = UIScreen.main.bounds.width - 16
    @State private var page: Int = 0

    @State private var buttonGridLayout = "rectangle.grid.1x2"
    @State private var selectedSorting = ImageSorting.none
    @State private var isShowingAlertError = false

    var body: some View {

        ScrollView {
            LazyVGrid(columns: self.columns, spacing: 4) {

                ForEach (self.imageItems) { item in

                    NavigationLink(value: ListNavigationRoutes.detail(item: item)) {

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

                                VStack {
                                    
                                    Text(item.breeds.first?.name ?? "N/A")
                                        .padding()
                                }
                                .frame(height: 150)
                                .frame(maxWidth: .infinity)
                                .background(Gradient(colors: [Color.black.opacity(0.0), Color.black.opacity(0.9)]))
                                .font(.title)
                                .bold()
                                .foregroundStyle(.white)
                            }

                        }
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                        .task {

                            self.isLastElement(item: item)
                        }
                    }
                }
            }
            .padding(.horizontal, 8)

        }
        .navigationTitle("Explorer")
        .toolbar{

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

            Menu {

                Picker("Sort", selection: self.$selectedSorting) {

                    ForEach(ImageSorting.allCases) {

                        Text($0.title)
                    }
                }
                .onChange(of: self.selectedSorting) {

                    self.page = 0
                    self.fetch()
                }

            } label: {
                
                Text("Sort")
            }
        }
        .alert("Error", isPresented: self.$isShowingAlertError, actions: {

            Button("Ok", role: .cancel) { }

        }, message: {

            Text("Something went wrong!! 😱")
        })
        .onLoad {

            self.fetch()
        }
    }

    private func fetch() {

        Task {

            do {

                let queryItems = [
                    URLQueryItem(name: "has_breeds", value: "true"),
                    URLQueryItem(name: "limit", value: "50"),
                    URLQueryItem(name: "include_breeds", value: "true"),
                    URLQueryItem(name: "page", value: "\(self.page)"),
                    URLQueryItem(name: "order", value: self.selectedSorting.value)
                ]

                let response: [Dog] = try await self.httpManager.request(Resource(url: Routes.search, method: .get(queryItems)))

                if self.page == 0 {

                    self.imageItems = []
                }
                self.imageItems.append(contentsOf: response)

            } catch {

                self.isShowingAlertError.toggle()
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
    ListView(path: .constant(NavigationPath()))
}
