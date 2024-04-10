//
//  ParagraphSV.swift
//  TheAaliiDebates
//
//  Created by Ali Abraham on 2/23/23.
//

import SwiftUI

struct DescriptionSV: View {
    
    var descriptionTitle: String
    var text: String
    @State private var showDescriptionSheet = false
    
    var body: some View {
        
        if text == "" {
            
            Text(text == "" ? "No Bio" : text)
                .frame(width: width * 0.85, height: width * 0.45, alignment: .center)
                .foregroundColor(text == "" ? .secondary : .primary)
            
        } else {
            
            Button {
                showDescriptionSheet.toggle()
            } label: {
                
                HStack {
                    Text(text)
                        .foregroundColor(.primary)
                        .multilineTextAlignment(.leading)
                        .frame(width: width * 0.8, alignment: .topLeading)
                    .padding(.top)
                }
                .frame(width: width * 0.85, height: width * 0.4, alignment: .topLeading)

            }
//            .frame(width: width * 0.85, height: width * 0.4, alignment: .topLeading)
            //MARK: Sheet
            .sheet(isPresented: $showDescriptionSheet) {
                
                VStack {
                    
                    Text(descriptionTitle)
                        .font(.title)
                        .padding(.all, 30)
                    
                    Divider()
                    
                    ScrollView(showsIndicators: true) {
                        
                        Text(text)
                        
                    }
                    .frame(width: width * 0.95, alignment: .center)
                }
                .frame(width: width, alignment: .center)
                .background(Color.black)
                .presentationDetents([.medium, .fraction(0.7), .fraction(0.9)])
                .preferredColorScheme(.dark)
            }
        }
        
    }
}

struct DescriptionSV_Previews: PreviewProvider {
    static var previews: some View {
        
//        UserTabView(currentUserBio: "The user entered a bio that is currently medium but will get long later on")
        
        DescriptionSV(descriptionTitle: "Video Description", text: "the paragraph is here man yeesss")
            .preferredColorScheme(.dark)
    }
}
