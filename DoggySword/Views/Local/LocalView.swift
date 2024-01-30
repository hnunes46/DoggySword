//
//  LocalView.swift
//  DoggySword
//
//  Created by Helder Nunes on 30/01/2024.
//

import SwiftUI

struct LocalView: View {

    @Binding var path: NavigationPath

    @State private var imageItems: [ImageBreed] = [ImageBreed]()
    @State private var columns: [GridItem] = [GridItem(.fixed(UIScreen.main.bounds.width - 16))]
    @State private var numberOfColumns = 1
    @State private var columnWidth = UIScreen.main.bounds.width - 16
    @State private var buttonGridLayout = "rectangle.grid.1x2"

    @State private var isShowingAlertError = false
    @State private var alerMessage: ErrorMessage = .localSave

    var body: some View {

        ScrollView {
            LazyVGrid(columns: self.columns, spacing: 4) {

                ForEach (self.imageItems) { item in

                    NavigationLink(value: LocalNavigationRoutes.detail(item: item)) {

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
                    }
                }
            }
            .padding(.horizontal, 8)

        }
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

        }
        .alert("Error", isPresented: self.$isShowingAlertError, actions: {

            Button("Ok", role: .cancel) { }

        }, message: {

            Text(self.alerMessage.rawValue)
        })
        .onLoad {

            self.fetch()
        }
    }

    private func fetch() {

        guard let data = UserDefaults.standard.data(forKey: "images") else { return }

        do {

            let decoder = JSONDecoder()

            let images: [ImageBreed] = try decoder.decode([ImageBreed].self, from: data)

            self.imageItems = images

        } catch {
            
            self.alerMessage = .localSave
            self.isShowingAlertError.toggle()
        }
    }
}

#Preview {
    LocalView(path: .constant(NavigationPath()))
}
