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
    
    func initialOffset(for geometryHeight: CGFloat) -> CGFloat {
        geometryHeight * (7 / 10)
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                RoundedRectangle(cornerRadius: 8.0)
                    .fill(Color(UIColor.lightGray))
                    .frame(width: 40, height: 4)
                
                self.content()
                    .frame(width: geometry.size.width)

                Spacer()
            }
            .frame(height: geometry.size.height)
            .padding([.top, .bottom], 8.0)
            .background(Color.white)
            .offset(x: 0, y: self.dragOffset + self.initialOffset(for: geometry.size.height))
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
}

struct MapMenuView: View {
    private let searchQuery = PassthroughSubject<String, Never>()
    private let rows = Row.build(
        forColumn: 4,
        values: Array(0..<22),
        maxLength: 4 * 2
    )
    
    var body: some View {
        VStack(alignment: .center, spacing: 8.0) {
            SearchBarView(text: searchQuery, placeholder: "場所または住所を検索します")
                .padding([.leading, .trailing], 8.0)
                .padding(.top, -10.0)

            HStack {
                Text("Collection")
                    .foregroundColor(Color.gray)
                Spacer()
                Button(action: {
                    
                }) {
                    Text("Show All")
                }
            }.padding([.leading, .trailing], 16.0)
            
            ForEach(rows) { row in
                HStack(spacing: 8.0) {
                    ForEach(row.items, id: \.self) { item in
                        Circle()
                    }
                    if !row.isFitting {
                        ForEach(0..<row.emptyColumnCount) { _ in
                            Circle().hidden()
                        }
                    }
                }
                .frame(height: 60)
                .padding([.top, .bottom], 8.0)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
