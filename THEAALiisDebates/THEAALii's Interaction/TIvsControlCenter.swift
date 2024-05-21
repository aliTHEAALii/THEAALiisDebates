//
//  TIvsControlCenter.swift
//  TheAaliiDebates
//
//  Created by Ali Abraham on 5/30/23.
//

import SwiftUI

struct TIvsControlCenter: View {
    
    @AppStorage("current_user_uid") private var currentUserUID: String = ""
    @Binding var ti: TI
    
    @Binding var rightIndex: Int?
    @Binding var leftIndex : Int?
    
    @State private var expandTIControls: Bool = true
    
    var body: some View {
        
        // - Control Center
        ZStack {
            
            VStack(spacing: 0) {
                
                //indicators
                VsIndicators(ti: $ti, rightIndex: $rightIndex, leftIndex: $leftIndex, expandTIControls: $expandTIControls)
                if expandTIControls {
                    
                    VSMap(ti: $ti, rightIndex: $rightIndex, leftIndex: $leftIndex)
                    
                    //Bottom Buttons
                    HStack(spacing: 0) {
                        UserButton(userUID: "")
                            .frame(width: width * 0.15)
                        AddButtonSV()
                            .frame(width: width * 0.15)
                        
                        //MARK: ( Interaction Info ) Button
                        Button {
                            
                        } label: {
                            ZStack {
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(lineWidth: 0.5)
                                    .foregroundColor(.secondary)
                                    .frame(width: width * 0.2, height: width * 0.17)
                                
                                HStack(spacing: width * 0.01) {
                                    VStack(spacing: width * 0.02) {
                                        Image(systemName: "circle")
                                            .font(.system(size: width * 0.04, weight: .regular))
                                        Rectangle().fill(Color.primary).frame(width: 2, height: 20, alignment: .center)
                                    }
                                    VStack(spacing: width * 0.02) {
                                        Image(systemName: "circle")
                                            .font(.system(size: width * 0.04, weight: .regular))
                                        Rectangle().fill(Color.primary).frame(width: 2, height: 20, alignment: .center)
                                    }
                                }.foregroundColor(.primary)
                                
                            }
                        }
                        .frame(width: width * 0.4)
                        
                        
                        
                        AddButtonSV()
                            .frame(width: width * 0.15)
                        
                        UserButton(userUID: "")
                            .frame(width: width * 0.15)
                        
                    }
                    .frame(height: width * 0.2)
                    
                }
            }// - VStack - //
            .frame(height: expandTIControls ? width * 0.65 : width * 0.15, alignment: .top)
            
            //Border ControlCenter
            RoundedRectangle(cornerRadius: 8)
                .strokeBorder(lineWidth: 0.5)
                .foregroundColor(.secondary)
                .frame(width: width,
                       height: expandTIControls ? width * 0.7 : width * 0.15)
            
        }// - ZStack - //
        .preferredColorScheme(.dark)
    }
}

struct TIvsControlCenter_Previews: PreviewProvider {
    static var previews: some View {
        THEAALiiInteractionView()
    }
}



//MARK: - VS Map
struct VSMap: View {
    
    @Binding var ti: TI
    @Binding var rightIndex: Int?
    @Binding var leftIndex: Int?
    
    var body: some View {
        
        ScrollViewReader { proxy in
            ScrollView(.horizontal, showsIndicators: false) {
                
                LazyHStack(spacing: 10) {
                    
                    //
                    if ti.leftSideChain.count < 2 {
                        if ti.leftSideChain.count < 1 {
                            Rectangle()
                                .foregroundStyle(.black)
                                .frame(width: width * 0.22, height: width * 0.5625 * 0.22)
                        }
                        
                        Rectangle()
                            .foregroundStyle(.black)
                            .frame(width: width * 0.22, height: width * 0.5625 * 0.22)
                    }
                    
                    ForEach(0..<mapArray.count, id: \.self) { i in
                        
                        if i == introVideoIndex {
                            
                            //Center
                            Button {
                                rightIndex = nil
                                leftIndex  = nil
                            } label: {
                                ZStack {
                                    Circle()
                                        .fill(Color.black)
                                        .frame(width: width * 0.25)
                                    Circle()
                                        .stroke(lineWidth: 0.7)
                                        .frame(width: width * 0.25)
                                    
                                    Image(systemName: "timelapse")
                                        .foregroundColor(.gray)
                                        .font(.system(size: width * 0.21, weight: .ultraLight))
                                    
                                    if rightIndex == nil && leftIndex == nil {
                                        Image(systemName: "triangle")
                                            .foregroundColor(.ADColors.green)
                                            .font(.system(size: width * 0.09, weight: .thin))
                                            .offset(y: -3)
                                            .rotationEffect(.degrees(180))
                                    }
                                }
                                .foregroundColor(.primary)
                                .id(i)
                            }
                        } else {

                            // if left.count == 1 {  +1 black box }
                            VSMapVideoSV(ti: $ti, order: order(index: i), rightIndex: $rightIndex, leftIndex: $leftIndex)
                                .id(i)
                        }
                    }
                    
                    if ti.rightSideChain.count < 2 {
                        if ti.rightSideChain.count < 1 {
                            Rectangle()
                                .foregroundStyle(.black)
                                .frame(width: width * 0.22, height: width * 0.5625 * 0.22)
                        }
                        
                        Rectangle()
                            .foregroundStyle(.black)
                            .frame(width: width * 0.22, height: width * 0.5625 * 0.22)
                    }
                }
            }
            .onAppear{ proxy.scrollTo(ti.leftSideChain.count, anchor: .center)}
        }
        .frame(minWidth: width)
        
    }
    
    //MARK: Functions
    var mapArray: [String] {
        
        var mapArray: [String] = []
        
        for id in ti.leftSideChain.reversed() {
            mapArray.append(id.key)
        }
        
        mapArray.append(ti.introPostID)
        
        for id in ti.rightSideChain {
            mapArray.append(id.key)
        }
        
        return mapArray
    }
    
    //MARK: - THIS!!!!!!! Change indecies
    private func selectClink() {
        
    }
    
    private func order(index: Int) -> Int {
        if index < ti.leftSideChain.count {
            return ti.leftSideChain.count - index
        }
        return index - ti.leftSideChain.count
    }
    var introVideoIndex: Int {
        return ti.leftSideChain.count
    }
}

//MARK: - VS Map Video SV
struct VSMapVideoSV: View {
    
    @Binding var ti: TI
    let order: Int
//    @Binding var selectedIndex: Int
    
    @Binding var rightIndex: Int?
    @Binding var leftIndex: Int?
    
    @State private var tiCLink: TITChainLinkModel? = nil
    
    var body: some View {
        
        Button {
            
        } label: {
            ZStack {
                ZStack(alignment: .topLeading) {
                    VStack(spacing: 0) {
                        Rectangle()
                            .foregroundColor(.gray)
                            .frame(width: width * 0.22, height: width * 0.5625 * 0.22)
                        
                        Text("TI Video Title: Long title goes here to see how things go. is it good?")
                            .font(.caption)
                            .frame(height: width * 0.1)
                    }
                    .frame(width: width * 0.22)
                    
                    Text("\(order)")
                        .padding(.all, width * 0.01)
                    
                    
                }
                .foregroundStyle(.white)
                
                //triangel
//                if selectedIndex
                Image(systemName: "triangle.fill")
                    .foregroundColor(.ADColors.green)
                    .font(.system(size: width * 0.15, weight: .bold))
//                    .offset(y: -3)
                    .rotationEffect(.degrees(180))
                
                Image(systemName: "triangle")
                    
                    .foregroundColor(.white)
                    .font(.system(size: width * 0.15, weight: .ultraLight))
//                    .offset(y: -3)
                    .rotationEffect(.degrees(180))
            }
        }
    }
}
