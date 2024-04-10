//
//  TIControls.swift
//  TheAaliiDebates
//
//  Created by Ali Abraham on 5/17/23.
//

import SwiftUI

//MARK: - TI Controls SV
struct TIControlsSV: View {
    
    @Binding var ti: TIModel
    @Binding var currentIndex: Int
    let isAdmin: Bool
    @State private var tiChain: [TITChainLModel] = []
    @State var chain: [TIVideoModel] = []
    
    
    @StateObject private var vmControls = TIContolsViewModel()
    @State private var expandTIControls = false
    
    var body: some View {
        
        ZStack(alignment: .top) {
            
            // - Outer border
            RoundedRectangle(cornerRadius: 8)
                .strokeBorder(lineWidth: 0.5)
                .foregroundColor(.secondary)
                .frame(width: width,
                       height: expandTIControls ? width * 0.7 : width * 0.15)
            
            
            VStack(spacing: 0) {
                
                //MARK: - Indicators & CurrentIndexControls -
                TICurrentIndexControlsSV(ti: $ti, currentIndex: $currentIndex, expandTIControls: $expandTIControls)
                
                //MARK: - Expanded Controls -
                if expandTIControls {
//                    TIControlsExpandedSV(ti: $ti, tiChain: vmControls.tiChain, currentIndex: $currentIndex, isAdmin: isAdmin)
                    TIControlsExpandedSV(ti: $ti, tiChain: $tiChain, currentIndex: $currentIndex, isAdmin: isAdmin)

                }
                
            }//VStack - //
            .frame(height: expandTIControls ? width * 0.5 : width * 0.15, alignment: .top)
        }//ZStack - //
        .background(Color.black)
//        .task { try? await vmControls.fetchTIMap(ti: ti) }
        .task { try? await onAppearFetch() }
//        .onAppear { Task { try await onAppearFetch()} }
//        .onAppear{ Task { try await vmControls.fetchTIMap(ti: ti) } }
    }
    
    //MARK: - Functions
    func onAppearFetch() async throws {
                
        guard !ti.interactionChain.isEmpty else { return }

        Task {
            for chainLId in ti.interactionChain {
                let tiChainL = try await TITChainLManager.shared.readCLink(titId: ti.id, titCLinkId: chainLId)
                tiChain.append(tiChainL)
            }
        }
    }
}

struct TIControlsSV_Previews: PreviewProvider {
    static var previews: some View {
        TIControlsSV(ti: .constant(TestingComponents().testingTIT), currentIndex: .constant(0), isAdmin: true)
            .preferredColorScheme(.dark)
        
        TIMap(ti: .constant(TestingComponents().testingTIT),
              tiChain: .constant([TestingComponents().testTIChainL]), currentIndex: .constant(0))
    }
}

//MARK: - Controls Expanded SV
struct TIControlsExpandedSV: View {
    
//    let ti : TIModel
    @Binding var ti: TIModel
    @Binding var tiChain: [TITChainLModel]
//    let tiChain: [TIVideoModel]
    @Binding var currentIndex: Int
    let isAdmin: Bool
    
    var body: some View {
        VStack(spacing: 0) {
            // - Debate Map (0.35)
            TIMap(ti: $ti, tiChain: $tiChain, currentIndex: $currentIndex)
            
            
            HStack(spacing: 0) {
                
                //FIXME: isAdmin check in function
                //- Add to Chain
                if isAdmin {
                    UploadToTIChainButton(ti: ti)
                }
                
                Spacer()
                
                //Debate Info
                TIInfoButton(ti: $ti)
            }
            .frame(width: width, height: width * 0.2)
        }
    }
}

//MARK: - TI Map
struct TIMap: View {
    
    @Binding var ti: TIModel
    @Binding var tiChain: [TITChainLModel]
    @Binding var currentIndex: Int
        
    var body: some View {
        
        if !tiChain.isEmpty {
            ScrollView(.horizontal, showsIndicators: false) {
                
                //Spacing
//                Rectangle()
//                    .foregroundColor(.black)
//                    .frame(width: width * 0.1)
//                    .padding(.leading)
                
                LazyHStack {
                    ForEach(0..<ti.interactionChain.count, id: \.self) { i in
                        
                        
                        Button {
                            currentIndex = i
                        } label: {
                            ZStack(alignment: .topLeading) {
                                VStack(spacing: 0) {
                                    
                                    ThumbnailSV(urlSting: tiChain[i].videoThumbnail,
                                                name: tiChain[i].videoTitle ?? "No Title Detected", sf: 0.25)
                                    .frame(width: width * 0.25, height: width * 0.5625 * 0.25)
                                    
                                    //                            Text(vmControls.tiChain[i].name)
                                    Text(tiChain[i].videoTitle ?? "No title Detected")
                                        .font(.caption)
                                        .frame(width: width * 0.25, height: width * 0.5625 * 0.25)
                                }
                                .foregroundColor(i == currentIndex ? .ADColors.green : .primary)
                                
                                ZStack {
//                                    Circle()
//                                        .frame(width: width * 0.25 * 0.1)
                                    Text("\(i + 1)")
                                        .foregroundColor(.primary)
                                }
                                
                                if i == currentIndex {
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(lineWidth: 2)
                                        .foregroundColor(.ADColors.green)
//                                        .frame(width: width * 0.25, height: width * 0.5625 * 0.5)
                                        .frame(width: width * 0.25, height: width * 0.35)


                                }
                            }
                        }
                        
//                        Divider()
                    }
                }
                .padding(.horizontal, width * 0.1)
            }
            .frame(height: width * 0.35)
        } else {
            Rectangle()
                .foregroundColor(.black)
                .frame(width: width * 0.8, height: width * 0.35)
        }
    }
}

//MARK: - TI Chain Indicators -
struct TIChainIndicators: View {
    
    let count: Int
    @Binding var ti: TIModel
    @Binding var currentIndex: Int
    @ObservedObject private var controlsVM = TIContolsViewModel()
    
    var body: some View {
        
        ZStack {
            RoundedRectangle(cornerRadius: 8)
                .strokeBorder(lineWidth: 0.5)
                .foregroundColor(.secondary)
                .frame(width: width * 0.5, height: width * 0.1)
            
            //            if count != 0 {
            ScrollView(.horizontal, showsIndicators: true) {
            HStack(spacing: 10) {
                
                //                    ForEach(0..<(count < 6 ? count : 5), id: \.self) { i in
//                    ForEach(0..<(ti.interactionChain.count < 6 ? count : 5), id: \.self) { i in
                        ForEach(0..<(ti.interactionChain.count ), id: \.self) { i in

                        
                        
                        if i == currentIndex {
                            
                            Image(systemName: "triangle")
                                .font(.title)
                                .foregroundColor(.ADColors.green)
                            
                        } else {
                            ZStack {
                                
//                                Text("\(count < 6 ? i + 1 : (count - 4 + i))")
                                Text("\(i + 1)")
                                //                            .font(debateChainsCount < 10 ? .body : .caption)
                                    .fontWeight(.light)
                                
                                Circle()
                                    .stroke(lineWidth: 1)
                                    .frame(width: width * 0.07)
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                }
            }
            .frame(width: width * 0.48, height: width * 0.1)

            //            } else { ProgressView() }
        }
    }
}

//MARK: - TI Current Index Controls SV -
struct TICurrentIndexControlsSV: View {
    
    //Data
    @Binding var ti: TIModel
    @Binding var currentIndex: Int
    
    @StateObject private var vmControls = TIContolsViewModel()
    //View
    @Binding  var expandTIControls: Bool
    
    var body: some View {
        HStack(spacing: 0) {
            
            // - Decrease Index (previous chain Link)
            Button {
//                vmControls.decreaseIndex(currentIndex: &currentIndex)
                decreaseIndex()
            } label: {
                Image(systemName: "triangle")
                    .rotationEffect(Angle(degrees: -90))
                    .frame(width: width * 0.15, height: width * 0.15)
                
            }
            
            Spacer()
            
            //MARK: TI Indicators
            Button {
                withAnimation {
                    expandTIControls.toggle()
                    //                            Task { try await vmControls.mapAppear(ti: ti)}
//                    chain = vmControls.tiChain
                }
            } label: {
                TIChainIndicators(count: ti.interactionChain.count, ti: $ti, currentIndex: $currentIndex)
            }
            
            Spacer()
            
            // - Increase Index (next Chain L)
            Button {
//                vmControls.increaseIndex(currentIndex: &currentIndex)
                increaseIndex()
            } label: {
                Image(systemName: "triangle")
                    .rotationEffect(Angle(degrees: 90))
                    .frame(width: width * 0.15, height: width * 0.15)
            }
        }
        .foregroundColor(.primary)
    }
    
    //MARK: - Functions
    func decreaseIndex() {
        print("entered🍃")

        guard currentIndex > 0 else { return }
        print("mid🍃👈")

        currentIndex -= 1
        print("last🍃👈")

    }
    func increaseIndex() {
        print("entered🍃👉")
        guard currentIndex < ti.interactionChain.count - 1 else { return }
        print("mid🍃👉")

        currentIndex += 1
        print("last🍃👉")

    }
}
