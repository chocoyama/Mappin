//
//  MapActionButton.swift
//  Mappin
//
//  Created by Takuya Yokoyama on 2019/12/01.
//  Copyright © 2019 chocoyama. All rights reserved.
//

import SwiftUI

struct MapActionButton: View {
    private let action: () -> Void
    
    init(action: @escaping () -> Void) {
        self.action = action
    }
    
    var body: some View {
        Button(action: self.action) {
            Image(systemName: "location.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .foregroundColor(Color.blue)
                .frame(width: 20, height: 20)
                .padding(12.0)
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 8.0))
                .shadow(color: .gray, radius: 0.2, x: 1, y: 1)
        }
    }
}

struct MapActionButton_Previews: PreviewProvider {
    static var previews: some View {
        MapActionButton {}
    }
}
