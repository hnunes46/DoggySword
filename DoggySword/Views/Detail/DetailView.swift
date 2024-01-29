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

                    VStack(alignment:.leading) {

                        Label("Breed name", systemImage: "pawprint")
                            .bold()
                        Text(breed.name)

                        Divider()

                        Label("Bred for", systemImage: "dog")
                            .bold()
                        Text(breed.bredFor ?? "")

                        Divider()


                        Label("Breed group", systemImage: "square.grid.2x2")
                            .bold()
                        Text(breed.breedGroup ?? "")

                        Divider()

                        Label("Life Span", systemImage: "staroflife.shield")
                            .bold()
                        Text(breed.lifeSpan)

                        Divider()
                        Label("Temperament", systemImage: "suit.heart.fill")
                            .bold()
                        Text(breed.temperement ?? "")
                            .multilineTextAlignment(.center)
                    }
                    .padding(.horizontal, 18)
                }
            }
            .edgesIgnoringSafeArea(.top)
        }
        .navigationTitle("Dog")
    }
}

#Preview {
    DetailView(item: Dog(id: "aaa", url: URL(string: "https://images.pexels.com/photos/1108099/pexels-photo-1108099.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2")!, width: 200, height: 300, breeds: []))
}
