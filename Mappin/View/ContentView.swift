//
//  ContentView.swift
//  Mappin
//
//  Created by Takuya Yokoyama on 2019/11/29.
//  Copyright © 2019 chocoyama. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var store: Store<AppState, AppAction>
    @State var tappingCurrentLocation: Bool = false
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            MapView(userLocation: store.state.map.userLocation,
                    tappingCurrentLocation: $tappingCurrentLocation)
            
            Button(action: {
                // Bindingで渡して一度falseにしないとupdateされなかった
                self.tappingCurrentLocation = false
                self.tappingCurrentLocation = true
            }) {
                Image(systemName: "location.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(Color.blue)
                    .frame(width: 20, height: 20)
                    .padding(12.0)
                    .background(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .shadow(color: .gray, radius: 0.2, x: 1, y: 1)
            }
            .padding(.top, 16)
            .padding(.trailing, 16)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
