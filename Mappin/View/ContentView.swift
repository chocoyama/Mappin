//
//  ContentView.swift
//  Mappin
//
//  Created by Takuya Yokoyama on 2019/11/29.
//  Copyright © 2019 chocoyama. All rights reserved.
//

import SwiftUI
import Combine

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
                        .clipShape(RoundedRectangle(cornerRadius: 8.0))
                        .shadow(color: .gray, radius: 0.2, x: 1, y: 1)
                }
                .padding(.top, 16)
                .padding(.trailing, 16)
            }
            
            SemiModalView {
                MapMenuView()
            }
        }.gesture(
            DragGesture()
                .onChanged { _ in
                    UIApplication.shared.hideKeyboard()
                }
        )
    }
}

struct SemiModalView<Content>: View where Content: View {
    @State var dragOffset: CGFloat = .leastNormalMagnitude
    
    private let content: () -> Content
    
    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }
    
    var body: some View {
        VStack {
            RoundedRectangle(cornerRadius: 8.0)
                .fill(Color(UIColor.lightGray))
                .frame(width: 40, height: 4)
            
            content()
        }
        .padding([.top, .bottom], 8.0)
        .background(Color.white)
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

struct MapMenuView: View {
    private let searchQuery = PassthroughSubject<String, Never>()
    
    var body: some View {
        VStack(alignment: .center, spacing: 8.0) {
            SearchBarView(text: searchQuery, placeholder: "場所または住所を検索します")
                .padding([.leading, .trailing], 8.0)
                .padding(.top, -10.0)
            
            HStack {
                Text("Collection")
                    .foregroundColor(Color.gray)
                Spacer()
            }.padding([.leading, .trailing], 16.0)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 0.0) {
                    ForEach(0..<20) { number in
                        Circle()
                            .frame(width: 60, height: 60)
                            .padding(8.0)
                    }
                }.padding([.leading, .trailing], 8.0)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
