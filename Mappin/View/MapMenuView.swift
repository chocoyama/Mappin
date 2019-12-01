//
//  MapMenuView.swift
//  Mappin
//
//  Created by Takuya Yokoyama on 2019/12/01.
//  Copyright © 2019 chocoyama. All rights reserved.
//

import SwiftUI
import Combine

struct MapMenuView: View {
    private let searchQuery = PassthroughSubject<String, Never>()
    private let rows = Row.build(
        forColumn: 4,
        values: Array(0..<22),
        maxLength: 4 * 2
    )
    
    var body: some View {
        VStack(alignment: .center, spacing: 8.0) {
            SearchBarView(text: searchQuery, placeholder: "場所または住所を検索します")
                .padding([.leading, .trailing], 8.0)
                .padding(.top, -10.0)
            
            placeCollectionView
            placeCollectionView
            placeCollectionView
            placeCollectionView
            placeCollectionView
            placeCollectionView
        }
    }
    
    private var placeCollectionView: some View {
        Group {
            HStack {
                Text("Collection")
                    .foregroundColor(Color.gray)
                Spacer()
                Button(action: {
                    
                }) {
                    Text("Show All")
                }
            }.padding([.leading, .trailing], 16.0)
            
            ForEach(rows) { row in
                HStack(spacing: 8.0) {
                    ForEach(row.items, id: \.self) { item in
                        Circle()
                    }
                    if !row.isFitting {
                        ForEach(0..<row.emptyColumnCount) { _ in
                            Circle().hidden()
                        }
                    }
                }
                .frame(height: 60)
                .padding([.top, .bottom], 8.0)
            }
        }
    }
}


struct MapMenuView_Previews: PreviewProvider {
    static var previews: some View {
        MapMenuView()
    }
}
