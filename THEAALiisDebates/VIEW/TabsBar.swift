//
//  TabsBar.swift
//  TheAaliiDebates
//
//  Created by Ali Abraham on 3/12/23.
//

import SwiftUI

struct TabsBar: View {
    
    let icons = ["triangle", "magnifyingglass", "plus", "line.3.horizontal", "person"]
    
    @State private var selectedIndex = 0
    
    @State var presentedAddDebateView = false
    @State var isMiniPlayer = false
    
    var body: some View {
        
        ZStack(alignment: .bottom) {
            
            switch selectedIndex {
            case 0 :
                FeedTabView(showTITView: $presentedAddDebateView)

            case 1 :
                VStack {
                    Spacer()
                    Text("search")
                    Spacer()
                }

                ///case 2 :

            case 3 :
                LibraryTabView()

            case 4 :
                UserTabView()

            default :
                FeedTabView(showTITView: $presentedAddDebateView)
            }
            
            //Debate View (& mini Player)
//            DebateView(showDebateView: $showDebateView)
//                .padding(.bottom, !isMiniPlayer ? 0 : height - width * 0.15)
            //                .frame(height: height - width * 0.15)
            
            //MARK: - Bar
            HStack(spacing: 0) {
                ForEach(0..<5, id: \.self) { index in
                    
                    Spacer()
                    
                    Button {
                        selectedIndex = index
                    } label: {
                        
                        if index == 4 {
                            
                            VStack() {
//                                Image(systemName: "circle")
//                                //                                    .font(.caption)
//                                    .font(.system(size: width * 0.025, weight: .regular))
//
//                                Image(systemName: "triangle")
//                                    .font(.system(size: width * 0.04, weight: .light))
//                                    .rotationEffect(.degrees(180))
                                
                                PersonTITIconSV(color: selectedIndex == 4 ? .ADColors.green : .secondary, fill: false, scale: 1)
                                
                            }
//                            .foregroundColor(selectedIndex == 4 ? .ADColors.green : .secondary)
                            
                            
                        } else if index == 2 {
                            CreateDebateButton(selectedTabIndex: $selectedIndex)
                        } else {
                            //Buttons(home[0], saved[3], user[4])
                            Image(systemName: icons[index])
                                .font(.system(size: width * 0.075, weight: .thin))
                                .frame(width: width * 0.1)
                                .foregroundColor(selectedIndex == index ? .ADColors.green : .secondary)
                            
                        }
                    }
                    
                    Spacer()
                    
                }//ForEach
            }//HStack
            .frame(height: width * 0.125)
            .background(.black)
//            .padding(.top, 5)
//            .padding(.top, width * 0.04)
        }
//        .frame(width: width, height: height, alignment: .bottom)
        .preferredColorScheme(.dark)
    }
}

struct TabsBar_Previews: PreviewProvider {
    static var previews: some View {
        TabsBar()
    }
}
