//
//  SemiModalView.swift
//  Mappin
//
//  Created by Takuya Yokoyama on 2019/12/01.
//  Copyright © 2019 chocoyama. All rights reserved.
//

import SwiftUI

struct SemiModalView<Content>: View where Content: View {
    enum Position {
        case full
        case half
        case compact
        
        var offset: CGFloat {
            let screenHeight = UIScreen.main.bounds.height
            switch self {
            case .full: return screenHeight * (1 / 10)
            case .half: return screenHeight * (6 / 10)
            case .compact: return screenHeight * (8.5 / 10)
            }
        }
        
        var larger: Position {
            switch self {
            case .full: return .full
            case .half: return .full
            case .compact: return .half
            }
        }
        
        var smaller: Position {
            switch self {
            case .full: return .half
            case .half: return .compact
            case .compact: return .compact
            }
        }
    }
    
    @State var dragOffset: CGFloat = .leastNormalMagnitude
    @State var position: Position = .half
    @State var isUserInteractionEnabled: Bool = false
    @State var contentOffset: CGFloat = .leastNormalMagnitude
    
    private let content: () -> Content
    
    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }
    
    var body: some View {
        GeometryReader { (geometry: GeometryProxy) in
            VStack {
                RoundedRectangle(cornerRadius: 8.0)
                    .fill(Color(UIColor.lightGray))
                    .frame(width: 40, height: 4)
                
                ScrollableView(
                    contentOffset: self.$contentOffset,
                    isUserInteractionEnabled: self.$isUserInteractionEnabled
                ) {
                    self.content()
                        .frame(width: UIScreen.main.bounds.width)
                }
            }
            .padding(.top, 8.0)
            .padding(.bottom, geometry.safeAreaInsets.bottom + 8.0)
            .background(Color(UIColor.systemBackground))
            .offset(x: 0, y: self.dragOffset + self.position.offset)
            .gesture(
                DragGesture()
                    .onChanged { (value) in
                        if self.position == .full {
                            if value.translation.height > 0 && self.contentOffset <= .leastNormalMagnitude {
                                withAnimation(.spring()) {
                                    self.contentOffset = 0.0
                                    self.position = self.position.smaller
                                    self.isUserInteractionEnabled = false
                                }
                            }
                        } else {
                            self.dragOffset = value.translation.height
                        }
                    }
                    .onEnded { (value) in
                        withAnimation(.spring()) {
                            let position = value.translation.height > 0 ? self.position.smaller : self.position.larger
                            switch position {
                            case .full: self.isUserInteractionEnabled = true
                            case .half: self.isUserInteractionEnabled = false
                            case .compact: self.isUserInteractionEnabled = false
                            }
                            
                            self.dragOffset = 0.0
                            self.position = position
                        }
                    }
            )
        }
    }
}

private struct ScrollableView<Content>: UIViewRepresentable where Content: View {
    class Coordinator: NSObject, UIScrollViewDelegate {
        private let scrollableView: ScrollableView
        
        init(_ scrollableView: ScrollableView) {
            self.scrollableView = scrollableView
        }
        
        func scrollViewDidScroll(_ scrollView: UIScrollView) {
            DispatchQueue.main.async {
                self.scrollableView.contentOffset = scrollView.contentOffset.y
            }
        }
    }
    
    private let content: () -> Content
    @Binding var contentOffset: CGFloat
    @Binding var isUserInteractionEnabled: Bool
    
    init(
        contentOffset: Binding<CGFloat>,
        isUserInteractionEnabled: Binding<Bool>,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self._contentOffset = contentOffset
        self._isUserInteractionEnabled = isUserInteractionEnabled
        self.content = content
    }
    
    func makeCoordinator() -> ScrollableView<Content>.Coordinator {
        Coordinator(self)
    }
    
    func makeUIView(context: UIViewRepresentableContext<ScrollableView>) -> UIScrollView {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.alwaysBounceVertical = true
        scrollView.delegate = context.coordinator
        scrollView.backgroundColor = .systemBackground
        
        let view = UIHostingController(rootView: content()).view!
        view.overlay(on: scrollView)
        
        return scrollView
    }
    
    func updateUIView(_ uiView: UIScrollView, context: UIViewRepresentableContext<ScrollableView>) {
//        uiView.isScrollEnabled = isUserInteractionEnabled
        uiView.isUserInteractionEnabled = isUserInteractionEnabled
    }
}


struct SemiModalView_Previews: PreviewProvider {
    static var previews: some View {
        SemiModalView {
            Text("Test")
        }
    }
}
