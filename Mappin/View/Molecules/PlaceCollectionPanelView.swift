//
//  PlaceCollectionPanelView.swift
//  Mappin
//
//  Created by Takuya Yokoyama on 2019/12/01.
//  Copyright © 2019 chocoyama. All rights reserved.
//

import SwiftUI

struct PlaceCollectionPanelView: View {
    private let rows: [Row<Int>]
    
    init(column: Int, maxLength: Int) {
        rows = Row.build(forColumn: column, values: Array(0..<22), maxLength: maxLength)
    }
    
    var body: some View {
        VStack {
            MenuHeaderView(title: "Collection", buttonTitle: "Show All")
                .padding([.leading, .trailing], 16.0)
            
            ForEach(rows) { row in
                HStack(spacing: 8.0) {
                    ForEach(row.items, id: \.self) { item in
                        PlaceCollectionItemView(title: "\(item + 1)")
                    }
                    if !row.isFitting {
                        ForEach(0..<row.emptyColumnCount) { _ in
                            PlaceCollectionItemView(title: "")
                                .hidden()
                        }
                    }
                }
                .padding([.top, .bottom], 8.0)
            }
        }
    }
}

struct PlaceCollectionPanelView_Previews: PreviewProvider {
    static var previews: some View {
        PlaceCollectionPanelView(column: 4, maxLength: 4 * 2)
    }
}
