//
//  CTiStep2D1.swift
//  THEAALiisDebates
//
//  Created by Ali Kadhum on 4/29/24.
//

import SwiftUI

struct CTiStep2D1: View {
    
    let currentUser: UserModel?
    
    let tiID: String
    @Binding var tiInteractionType: TIType
    
    @Binding var tiThumbnailData: Data?
    let thumbnailForTypeID: String

    @Binding var tiTitle: String
//    enum Field {
//        case debateTitle, debateDescription, videoTitle, videoDescription
//    }
//    @FocusState private var focusField: Field?

    @Binding var rightUser: UserModel?
    
    var body: some View {
        
        VStack(spacing: 10) {
            ZStack(alignment: .bottom) {
                
                VStack(spacing: 0) {
                    
                    PickThumbnailButton(thumbnailFor: .TI, thumbnailForTypeID: tiID, imageData: $tiThumbnailData, buttonText: "TI \nThumbnail")
                    
                    Spacer()
                }
                
                TIIconD1(scale: 0.8)

                ZStack {
                    if let profileImageURLString = currentUser?.profileImageURLString {
                        
                        AsyncImage(url: URL(string: profileImageURLString), scale: 0.5) { image in
                            
                            image
                                .resizable()
                                .clipShape( Circle() )
                                .scaledToFit()
                                .frame(width: width * 0.125)
                            
                        } placeholder: {
                            ProgressView()
                        }
                        //User with Nil image
                    } else { PersonTITIconSV(scale: 1.3) }
                }
                .frame(width: width, height: width * 0.68, alignment: .bottomTrailing)
            }
            .frame(width: width, height: width * 0.68)
            
            
            //MARK: TI Title
            AddTITitle(tiTitle: $tiTitle)
            
        }

        
    }
}

#Preview {
//    CTiStep2D1(
//        currentUser: TestingModels().user1,
//        tiID: "tiID",
//        tiInteractionType: .constant(.d1),
//        tiThumbnailData: .constant(nil),
//        thumbnailForTypeID: "tiID",
//        tiTitle: .constant("meaw"),
//        rightUser: .constant(TestingModels().user1)
//    )
    
    CreateTI(showFSC: .constant(true), selectedTabIndex: .constant(2), indexStep: 1)

}
