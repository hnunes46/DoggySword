//
//  DynamicGrid.swift
//  DoggySword
//
//  Created by Helder Nunes on 28/01/2024.
//

import SwiftUI

struct GridItems: Identifiable {

    let id: UUID = UUID()
    let height: CGFloat
    let imageUrl: URL
}

struct DynamicGrid: View {

    struct Column: Identifiable {

        let id = UUID()
        var gridItems = [GridItems]()
    }

    let columns: [Column]
    let spacing: CGFloat
    let horizontalPadding: CGFloat

    init(gridItems: [GridItems], numOfColumns: Int, spacing: CGFloat = 20, horizontalPadding: CGFloat =  10) {

        self.spacing = spacing
        self.horizontalPadding = horizontalPadding

        var columns = [Column]()

        for _ in 0 ..< numOfColumns {

            columns.append(Column())
        }

        var columnsHeight = Array<CGFloat>(repeating: 0, count: numOfColumns)

        for gridItem in gridItems {

            var smallestColumnIndex = 0
            var smallestHeight = columnsHeight.first!

            for i in 1 ..< columnsHeight.count {

                let currentHeight = columnsHeight[i]

                if currentHeight < smallestHeight {

                    smallestHeight = currentHeight
                    smallestColumnIndex = i
                }
            }

            columns[smallestColumnIndex].gridItems.append(gridItem)
            columnsHeight[smallestColumnIndex] += gridItem.height
        }

        self.columns = columns
    }

    var body: some View {
    
        HStack(alignment: .top, spacing: self.spacing) {

            ForEach(columns) {  column in
                
                LazyVStack(spacing: self.spacing) {

                    ForEach(column.gridItems) { gridItem in
                        
                        AsyncImage(url: gridItem.imageUrl) { image in

                            image
                                .resizable()
                                .scaledToFill()
                                .frame(width: (UIScreen.main.bounds.width / CGFloat(self.columns.count) - self.spacing - self.horizontalPadding), height: gridItem.height / 3)
                                .clipped()
                        } placeholder: {
                            Rectangle()
                                .foregroundColor(.gray)

                        }
                        .frame(height: gridItem.height / 3)
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                    }
                }
            }
        }
        .padding(.horizontal, self.horizontalPadding)
    }
}

#Preview {
    DynamicGrid(gridItems: [GridItems](), numOfColumns: 2)
}
