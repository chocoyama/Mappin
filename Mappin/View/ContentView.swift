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
        ZStack(alignment: .bottomTrailing) {
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
                    .foregroundColor(Color.white)
                    .padding()
                    .frame(width: 50, height: 50)
                    .background(Color.blue)
                    .clipShape(Circle())
            }
            .padding(.trailing, 24)
            .padding(.bottom, 32)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
