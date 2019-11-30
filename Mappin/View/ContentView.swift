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
    @State var dragOffset: CGFloat = .leastNormalMagnitude
    
    var body: some View {
        ZStack(alignment: .bottom) {
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
            
            MapMenuView()
        }
    }
}

struct MapMenuView: View {
    @State var dragOffset: CGFloat = .leastNormalMagnitude
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8.0) {
            HStack {
                Text("Collection")
            }
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    
                    ForEach(0..<20) { number in
                        Circle()
                            .fill(Color.white)
                            .frame(width: 60, height: 60)
                    }
                }
            }
        }
        .padding([.top, .bottom], 8.0)
        .background(Color.red)
        .offset(x: 0, y: dragOffset)
        .gesture(
            DragGesture(coordinateSpace: .global)
                .onChanged { (value) in
                    self.dragOffset = value.translation.height
                    print("### \(self.dragOffset)")
                }
                .onEnded { (value) in
                    withAnimation(Animation.spring()) {
                        self.dragOffset = 0.0
                    }
                }
        )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
