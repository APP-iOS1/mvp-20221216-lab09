////
////  SegmentationControlView.swift
////  CardMoaMVP
////
////  Created by 장다영 on 2022/12/20.
////
//
import SwiftUI

struct SegmentedControlView: View {
    @Binding var currentTab: Int
        @Namespace var namespace
        
        var tabBarOptions: [String] = ["신용카드", "체크카드"]
        var body: some View {
            HStack {
                ForEach(Array(zip(self.tabBarOptions.indices,
                                  self.tabBarOptions)),
                        id: \.0,
                        content: {
                    index, name in
                    TabBarItem(currentTab: self.$currentTab,
                               namespace: namespace.self,
                               tabBarItemName: name,
                               tab: index)
                    
                })
            }
            .padding(.horizontal)
            .font(.title2)
            .foregroundColor(Color.black)
            .background(Color.white)
            .frame(width: 200, height: 100)
            .bold()
        }

}

struct TabBarItem: View {
    @Binding var currentTab: Int
    let namespace: Namespace.ID
    
    var tabBarItemName: String
    var tab: Int
    
    var body: some View {
        Button {
            self.currentTab = tab
        } label: {
            VStack {
                Spacer()
                Text(tabBarItemName)
                if currentTab == tab {
                    // 상단 탭 line 색상
                    Color.accentColor
                        .frame(height: 3)
                        .matchedGeometryEffect(id: "underline",
                                               in: namespace,
                                               properties: .frame)
                } else {
                    Color.clear.frame(height: 2)
                }
            }
            .animation(.spring(), value: self.currentTab)
        }
        .buttonStyle(.plain)
    }
}
//
//struct SegmentedControlView: View {
//    @Binding private var selectedIndex: Int
//
//    @State private var frames: Array<CGRect>
//    @State private var backgroundFrame = CGRect.zero
//    @State private var isScrollable = true
//
//    private let titles: [String] = ["신용카드", "체크카드"]
//
//    init(selectedIndex: Binding<Int>) {
//        self._selectedIndex = selectedIndex
//        //self.titles = ["신용카드", "체크카드"]
//        frames = Array<CGRect>(repeating: .zero, count: titles.count)
//    }
//
//    var body: some View {
//        VStack {
//            if isScrollable {
//                ScrollView(.horizontal, showsIndicators: false) {
//                    SegmentedControlButtonView(selectedIndex: $selectedIndex, frames: $frames, backgroundFrame: $backgroundFrame, isScrollable: $isScrollable, checkIsScrollable: checkIsScrollable)
//                }
//            } else {
//                SegmentedControlButtonView(selectedIndex: $selectedIndex, frames: $frames, backgroundFrame: $backgroundFrame, isScrollable: $isScrollable, checkIsScrollable: checkIsScrollable)
//            }
//        }
//        .background(
//            GeometryReader { geoReader in
//                Color.clear.preference(key: RectPreferenceKey.self, value: geoReader.frame(in: .global))
//                    .onPreferenceChange(RectPreferenceKey.self) {
//                    self.setBackgroundFrame(frame: $0)
//                }
//            }
//        )
//    }
//
//    private func setBackgroundFrame(frame: CGRect)
//    {
//        backgroundFrame = frame
//        checkIsScrollable()
//    }
//
//    private func checkIsScrollable()
//    {
//        if frames[frames.count - 1].width > .zero
//        {
//            var width = CGFloat.zero
//
//            for frame in frames
//            {
//                width += frame.width
//            }
//
//            if isScrollable && width <= backgroundFrame.width
//            {
//                isScrollable = false
//            }
//            else if !isScrollable && width > backgroundFrame.width
//            {
//                isScrollable = true
//            }
//        }
//    }
//}
//
//private struct SegmentedControlButtonView: View {
//    @Binding private var selectedIndex: Int
//    @Binding private var frames: [CGRect]
//    @Binding private var backgroundFrame: CGRect
//    @Binding private var isScrollable: Bool
//
//    private let titles: [String] = ["신용카드", "체크카드"]
//    let checkIsScrollable: (() -> Void)
//
//    init(selectedIndex: Binding<Int>, frames: Binding<[CGRect]>, backgroundFrame: Binding<CGRect>, isScrollable: Binding<Bool>, checkIsScrollable: (@escaping () -> Void))
//    {
//        _selectedIndex = selectedIndex
//        _frames = frames
//        _backgroundFrame = backgroundFrame
//        _isScrollable = isScrollable
//
//        self.checkIsScrollable = checkIsScrollable
//    }
//
//    var body: some View {
//        HStack(spacing: 0) {
//            ForEach(titles.indices, id: \.self) { index in
//                Button(action:{ selectedIndex = index })
//                {
//                    HStack {
//                        Text(titles[index])
//                            .foregroundColor(selectedIndex==index ? .black : .gray)
//                            .font(.title2)
//                            .bold()
//                            .frame(height: 10)
//
//                    }
//                }
//                .buttonStyle(CustomSegmentButtonStyle())
//                .background(
//                    GeometryReader { geoReader in
//                        Color.clear.preference(key: RectPreferenceKey.self, value: geoReader.frame(in: .global))
//                            .onPreferenceChange(RectPreferenceKey.self) {
//                                self.setFrame(index: index, frame: $0)
//                            }
//                    }
//                )
//            }
//        }
//        .modifier(UnderlineModifier(selectedIndex: selectedIndex, frames: frames))
//    }
//
//    private func setFrame(index: Int, frame: CGRect) {
//        self.frames[index] = frame
//        checkIsScrollable()
//    }
//}
//
//private struct CustomSegmentButtonStyle: ButtonStyle {
//    func makeBody(configuration: Configuration) -> some View {
//        configuration
//            .label
//            .padding(EdgeInsets(top: 40, leading: 8, bottom: 14, trailing: 8))
//            //.background(configuration.isPressed ? Color(red: 0.808, green: 0.831, blue: 0.855, opacity: 0.5): Color.clear)
//    }
//}
//
//struct UnderlineModifier: ViewModifier
//{
//    var selectedIndex: Int
//    let frames: [CGRect]
//
//    func body(content: Content) -> some View
//    {
//        content
//            .background(
//                Rectangle()
//                    .foregroundColor(.mainColor)
//                    .frame(width: frames[selectedIndex].width, height: 2)
//                    .offset(x: frames[selectedIndex].minX - frames[0].minX), alignment: .bottomLeading
//            )
////            .background(
////                Rectangle()
////                    .fill(Color.gray)
////                    .frame(height: 3), alignment: .bottomLeading
////            )
//            .animation(.default)
//    }
//}
//
//struct RectPreferenceKey: PreferenceKey
//{
//    typealias Value = CGRect
//
//    static var defaultValue = CGRect.zero
//
//    static func reduce(value: inout CGRect, nextValue: () -> CGRect)
//    {
//        value = nextValue()
//    }
//}
//
