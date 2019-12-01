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
        ZStack(alignment: .bottom) {
            ZStack(alignment: .topTrailing) {
                MapView(userLocation: self.store.state.map.userLocation,
                        tappingCurrentLocation: self.$tappingCurrentLocation)
                
                MapActionButton {
                    // Bindingで渡して一度falseにしないとupdateされなかった
                    self.tappingCurrentLocation = false
                    self.tappingCurrentLocation = true
                }
                .padding(.top, 16)
                .padding(.trailing, 16)
            }
            
            SemiModalView {
                MapMenuView()
            }
        }
        .gesture(
            DragGesture()
                .onChanged { _ in
                    UIApplication.shared.hideKeyboard()
            }
        )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
