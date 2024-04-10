//
//  ResponseArrayTopBarSV.swift
//  TheAaliiDebates
//
//  Created by Ali Abraham on 2/28/23.
//

import SwiftUI

struct ResponseArrayTopBarSV: View {
    
    let tiID: String
    let chainLID: String
    
    var totalVotesInResponseList: Int? = 0
    @State private var showMore = false

//    @ObservedObject private var tiVM = TIViewVM()
    
    var body: some View {
        
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                
                Spacer()
                
                // - Left Side Numbers
//                Button {
//                    showMore.toggle()
//                } label: {
//                    Image(systemName: "circle")
////                    Text("\(totalVotesInResponseList)") ///Don't Delete
//                        .fontWeight(.light)
//                        .foregroundColor(.secondary)
//                        .frame(width: width * 0.3)
//
//                }
                Text("Response")
                    .foregroundColor(.secondary)
                    .frame(width: width * 0.3)
                
                Spacer()
                
                //MARK: Add Video to list
//                if let tiID = tiVM.ti?.id, let chainLID = tiVM.chainL?.id {
                    AddTIVideoButton(tiID: tiID, tiChainLID: chainLID)
//                }
//                Text(tiVM.ti?.id ?? "nil")
//                Button {
//
//                } label: {
//                    ZStack {
//                        RoundedRectangle(cornerRadius: 8)
//                            .strokeBorder(lineWidth: 0.5)
//                            .foregroundColor(.secondary)
//                            .frame(width: width * 0.10, height: width * 0.10)
//
//                        Image(systemName: "plus")
//                            .font(.system(size: width * 0.075, weight: .thin))
//                            .frame(width: width * 0.1)
//                            .foregroundColor(.primary)
//                    }
//                }

                Spacer()
                
                // - Right Side Numbers
//                Button {
//                    showMore.toggle()
//                } label: {
//                    if totalVotesInResponseList == 0 {
//                        Image(systemName: "circle")
//                            .fontWeight(.light)
//                            .foregroundColor(.secondary)
//                            .frame(width: width * 0.3)
//                    } else if  totalVotesInResponseList == nil{
//                        ProgressView()
//                            .frame(width: width * 0.3)
//                    } else {
//                        Text("\(totalVotesInResponseList!)")
//                            .foregroundColor(.secondary)
//                            .frame(width: width * 0.3)
//                    }
//
//                }
                Text("List")
                    .foregroundColor(.secondary)
                    .frame(width: width * 0.3)

                
                Spacer()
                
            }
            
            if showMore {
                HStack(spacing: 0) {
                    
                    Spacer()

                    
                    Button {
                        showMore.toggle()
                    } label: {
                        Text("Future Feature")
                            .font(.caption)
                            .foregroundColor(.secondary)
                            .frame(width: width * 0.15, height: width * 0.15)

                    }
                    .frame(width: width * 0.3)


                    
                    Spacer()

                    Rectangle()
                        .foregroundColor(.black)
                        .frame(width: width * 0.1)
                    
                    Spacer()

                    
                    Button {
                        showMore.toggle()
                    } label: {
                        Text("Total Votes In List")
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.center)
                            .frame(width: width * 0.3)
                    }
                    
                    
                    Spacer()

                }
            }
        }
        .padding(.vertical, width * 0.005)
        .background(Color.black)

    }
}

//struct ResponseArrayTopBarSV_Previews: PreviewProvider {
//    static var previews: some View {
//
//        TITView(TIT: TestingComponents().testingTIT, showDebateView: .constant(true), isMiniPlayer : .constant(false))
//
//        ResponseArrayTopBarSV()
//    }
//}
