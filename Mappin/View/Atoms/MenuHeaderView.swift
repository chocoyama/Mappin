//
//  MenuHeaderView.swift
//  Mappin
//
//  Created by Takuya Yokoyama on 2019/12/01.
//  Copyright © 2019 chocoyama. All rights reserved.
//

import SwiftUI

struct MenuHeaderView: View {
    let title: String
    let buttonTitle: String
    
    var body: some View {
        HStack {
            Text(title)
                .foregroundColor(Color.gray)
            Spacer()
            Button(action: {
                
            }) {
                Text(buttonTitle)
            }
        }
    }
}

struct MenuHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        MenuHeaderView(title: "Title", buttonTitle: "Button Title")
    }
}
