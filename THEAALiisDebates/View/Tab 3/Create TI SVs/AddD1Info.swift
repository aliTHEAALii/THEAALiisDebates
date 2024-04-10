//
//  AddD1Info.swift
//  THEAALiisDebates
//
//  Created by Ali Kadhum on 4/10/24.
//

import SwiftUI

struct AddD1Info: View {
    
    let tiID: String
    @Binding var tiInteractionType: TIType?
    
    @Binding var tiThumbnailData: Data?
    let thumbnailForTypeID: String

    @Binding var tiTitle: String
    enum Field {
        case debateTitle, debateDescription, videoTitle, videoDescription
    }
    @FocusState private var focusField: Field?

//    @Binding var leftUser : String?
    @Binding var rightUser: String?
    
    var body: some View {
        
        VStack(spacing: 10) {
            ZStack(alignment: .bottom) {
                
                VStack(spacing: 0) {
                    
                    PickThumbnailButton(thumbnailFor: .TI, thumbnailForTypeID: tiID, imageData: $tiThumbnailData, buttonText: "TI \nThumbnail")
                    
                    Spacer()
                }
                
                TIIconD1(scale: 0.8)

            }
            .frame(width: width, height: width * 0.68)
            
            
            //MARK: TI Title
            ZStack {
                //Border
                RoundedRectangle(cornerRadius: 8)
                    .strokeBorder(lineWidth: 0.5)
                    .foregroundColor(tiTitle != "" ? .primary : .red)
                    .frame(width: width * 0.9, height: width * 0.13)
                
                if tiTitle == "" {
                    Text("TI Title")
//                                .foregroundColor(.secondary.opacity(0.5))
                }
                
                TextField("", text: $tiTitle)
                    .multilineTextAlignment(.center)
                    .frame(width: width * 0.8, height: width * 0.1, alignment: .center)
                    .submitLabel(.done)
                    .focused($focusField, equals: .debateTitle)
                    .onSubmit { focusField = .debateDescription }
            }
            
            EnterDescriptionButton(description: .constant("meaw"), buttonTitle: "TI Description")
        }

        
    }
}

#Preview {
//    AddD1Info(tiID: "", tiInteractionType: .constant(.d1),
//              tiThumbnailData: .constant(nil),
//              thumbnailForTypeID: "",
//              leftUser: .constant(nil), rightUser: .constant(nil)
//    )
    
    CreateTI(showFSC: .constant(true), selectedTabIndex: .constant(2), indexStep: 1)
}
