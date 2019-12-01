//
//  PlaceCollectionCarouselView.swift
//  Mappin
//
//  Created by Takuya Yokoyama on 2019/12/01.
//  Copyright © 2019 chocoyama. All rights reserved.
//

import SwiftUI

struct PlaceCollectionCarouselView: View {
    var body: some View {
        VStack {
            MenuHeaderView(title: "Collection", buttonTitle: "Show All")
                .padding([.leading, .trailing], 16.0)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16.0) {
                    ForEach(0..<10) { number in
                        PlaceCollectionItemView(title: "\(number + 1)")
                            .frame(width: 60)
                    }
                }
                .padding([.leading, .trailing], 16.0)
            }
        }
    }
}

struct PlaceCollectionCarouselView_Previews: PreviewProvider {
    static var previews: some View {
        PlaceCollectionCarouselView()
    }
}
