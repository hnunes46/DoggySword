//
//  SwiftUIView.swift
//  DoggySword
//
//  Created by Helder Nunes on 29/01/2024.
//

import SwiftUI

struct DetailView: View {

    var item: Dog
    
    var body: some View {

        ScrollView {

            VStack {

                AsyncImage(url: item.url) { image in

                    image
                        .resizable()
                        .scaledToFill()
                        .frame(height: 300)
                        .clipped()

                } placeholder: {

                    Rectangle()
                        .foregroundColor(.gray)

                }
                .frame(height: 300)


                ForEach (item.breeds) { breed in

                    VStack(alignment: .leading) {

                        Label("Breed name", systemImage: "pawprint")
                            .bold()
                            .multilineTextAlignment(.leading)
                            .frame(maxWidth: .infinity)
                            .padding(.horizontal, 16)

                        Text(breed.name)
                            .multilineTextAlignment(.leading)
                            .frame(maxWidth: .infinity)
                            .padding(.horizontal, 16)

                        Label("Bred for", systemImage: "dog")
                            .bold()
                            .multilineTextAlignment(.leading)
                            .frame(maxWidth: .infinity)
                            .padding(.horizontal, 16)
                        Text(breed.bredFor ?? "")
                            .multilineTextAlignment(.leading)
                            .frame(maxWidth: .infinity)
                            .padding(.horizontal, 16)

                        Label("Breed group", systemImage: "square.grid.2x2")
                            .bold()
                            .multilineTextAlignment(.leading)
                            .frame(maxWidth: .infinity)
                            .padding(.horizontal, 16)
                        Text(breed.breedGroup ?? "")
                            .multilineTextAlignment(.leading)
                            .frame(maxWidth: .infinity)
                            .padding(.horizontal, 16)

                        Label("Life Span", systemImage: "staroflife.shield")
                            .bold()
                            .multilineTextAlignment(.leading)
                            .frame(maxWidth: .infinity)
                            .padding(.horizontal, 16)
                        Text(breed.lifeSpan)
                            .multilineTextAlignment(.leading)
                            .frame(maxWidth: .infinity)
                            .padding(.horizontal, 16)

                        Label("Temperament", systemImage: "suit.heart.fill")
                            .bold()
                            .multilineTextAlignment(.leading)
                            .frame(maxWidth: .infinity)
                            .padding(.horizontal, 16)
                        Text(breed.temperement ?? "")
                            .multilineTextAlignment(.leading)
                            .frame(maxWidth: .infinity)
                            .padding(.horizontal, 16)
                    }
                }
            }
        }
        .navigationTitle("Dog")
    }
}

#Preview {
    DetailView(item: Dog(id: "aaa", url: URL(string: "https://images.pexels.com/photos/1108099/pexels-photo-1108099.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2")!, width: 200, height: 300, breeds: []))
}
