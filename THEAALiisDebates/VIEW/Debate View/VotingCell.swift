//
//  VotingCell.swift
//  TheAaliiDebates
//
//  Created by Ali Abraham on 2/22/23.
//

import SwiftUI

struct VotingCell: View {
    
    @State private var showSideOptions: Bool = false
    
    var body: some View {


        VStack(spacing: 0) {
            ZStack {
                HStack(spacing: 0) {
                    Rectangle()
                        .foregroundColor(.gray)
//                        .frame(width: width * 0.85, height: width * 0.5625 * 0.85)
                        .frame(width: width * 0.85, height: width * 0.5625 * 0.8) // ???

                    
                    //Voting
                    VStack(spacing: 0) {

                        Button {
                            
                        } label: {
                            
                            Image(systemName: "chevron.up")
                                .foregroundColor(.secondary)
                                .font(.title)
                                .frame(width: width * 0.15, height: width * 0.15)
                        }

                        Button {
                            withAnimation(.spring()) {
                                showSideOptions.toggle()
                            }
                        } label: {
                            ZStack {
                                RoundedRectangle(cornerRadius: 8)
                                    .strokeBorder(lineWidth: 0.5)
                                    .frame(width: width * 0.13, height: width * 0.1)
                                
                                Text("4.6K")
                                    .fontWeight(.light)
                            }
                            .foregroundColor(.primary)
                            .frame(width: width * 0.15, height: width * 0.15)
                        }

                        
                        Button {
                            
                        } label: {
                            Image(systemName: "chevron.down")
                                .foregroundColor(.secondary)
                                .font(.title)
                                .frame(width: width * 0.15, height: width * 0.15)
                        }

                    }//voting
                    .frame(width: width * 0.15)
                    
                    
                    
                }
                .frame(width: width, alignment: .leading)
                
//                SideOptionsSheet(showSideSheet: $showSideOptions)
                SideSheetForVotingCellOld(isAdmin: false, showSideSheet: $showSideOptions)
                                    .offset(x: showSideOptions ? width * 0.375 : width * 0.68)
            }
            
            Text("Video Title: or maybe debate title goes here to show that the user is putting some things where they are supposed to go")
                .frame(width: width * 0.95, height: width * 0.15)
            
            Divider()
        }
        .background(Color.black)

    }
}

struct VotingCell_Previews: PreviewProvider {
    static var previews: some View {
        VotingCell()
            .preferredColorScheme(.dark)
    }
}
