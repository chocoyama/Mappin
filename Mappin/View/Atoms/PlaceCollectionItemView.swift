//
//  PlaceCollectionItemView.swift
//  Mappin
//
//  Created by Takuya Yokoyama on 2019/12/01.
//  Copyright © 2019 chocoyama. All rights reserved.
//

import SwiftUI

struct PlaceCollectionItemView: View {
    let title: String
    
    var body: some View {
        VStack {
            Circle()
                .frame(height: 60)
            Text(title)
        }
    }
}

struct PlaceCollectionItemView_Previews: PreviewProvider {
    static var previews: some View {
        PlaceCollectionItemView(title: "Title")
    }
}
