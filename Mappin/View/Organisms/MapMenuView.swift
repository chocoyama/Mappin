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
    
    var body: some View {
        VStack(alignment: .center, spacing: 8.0) {
            SearchBarView(text: searchQuery, placeholder: "場所または住所を検索します")
                .padding([.leading, .trailing], 8.0)
                .padding(.top, -10.0)
            
            PlaceCollectionCarouselView()
            PlaceCollectionPanelView(column: 4, maxLength: 4 * 2)
            PlaceCollectionPanelView(column: 4, maxLength: 4 * 2)
            PlaceCollectionPanelView(column: 4, maxLength: 4 * 2)
            PlaceCollectionPanelView(column: 4, maxLength: 4 * 2)
            PlaceCollectionPanelView(column: 4, maxLength: 4 * 2)
            PlaceCollectionPanelView(column: 4, maxLength: 4 * 2)
        }
    }
}

struct MapMenuView_Previews: PreviewProvider {
    static var previews: some View {
        MapMenuView()
    }
}
