//
//  AddInteractionInfoSV.swift
//  THEAALiisDebates
//
//  Created by Ali Kadhum on 4/7/24.
//

import SwiftUI

struct AddInteractionInfoSV: View {
    
    let tiID: String
    @Binding var tiInteractionType: TIType
    
    @Binding var tiThumbnailData: Data?
    @Binding var thumbnailForTypeID: String


    @Binding var leftUser: String?
    @Binding var rightUser: String?
    
    
    var body: some View {

        HStack(spacing: 0) {
            
//            if tiInteractionType == .d2 {
//                if leftUser == nil {
//                    Button {
//                        
//                    } label: {
//                        PersonTITIconSV(color: .red, scale: 1.5)
//                            .padding(.leading, width * 0.05)
//                            .frame(width: width * 0.3, alignment: .leading)
//                    }
//                    
//                } else{
//                    UserButton(userID: nil)
//                        .padding(.leading)
//                        .frame(width: width * 0.3, alignment: .leading)
//                }
//            }
            
            PickThumbnailButton(thumbnailFor: .TI, thumbnailForTypeID: tiID, imageData: $tiThumbnailData, buttonText: "TI \nThumbnail")
            
//            if tiInteractionType == .d2 {
//                if leftUser == nil {
//                    Button {
//                        
//                    } label: {
//                        PersonTITIconSV(color: .red, scale: 1.5)
//                            .padding(.trailing, width * 0.05)
//                            .frame(width: width * 0.3, alignment: .trailing)
//                    }
//                    
//                } else {
//                    UserButton(userID: nil)
//                        .padding(.trailing)
//                        .frame(width: width * 0.3, alignment: .trailing)
//                }
//            }
        }
    }
}

#Preview {
    AddInteractionInfoSV(tiID: "", tiInteractionType: .constant(.d1), 
                         tiThumbnailData: .constant(nil),
                         thumbnailForTypeID: .constant(""),
                         leftUser: .constant(nil), rightUser: .constant(nil))
}
