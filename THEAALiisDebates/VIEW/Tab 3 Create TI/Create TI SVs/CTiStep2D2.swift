//
//  CTiStep2.swift
//  THEAALiisDebates
//
//  Created by Ali Kadhum on 4/25/24.
//

import SwiftUI

struct CTiStep2D2: View {
    
    @AppStorage("current_user_uid") var currentUserUID: String = ""
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

    @Binding var leftUser : UserModel?
    @Binding var rightUser: UserModel?
    

    var body: some View {
        
        ZStack {
            VStack(spacing: width * 0.07) {
                
                //Thumbnail & Users
                ZStack(alignment: .bottom) {
                    
                    VStack(spacing: width * 0.02) {
                        
                        //MARK: Thumbnail
                        PickThumbnailButton(thumbnailFor: .TI, thumbnailForTypeID: tiID, imageData: $tiThumbnailData, buttonText: "TI \nThumbnail")
                        
                        
                        
                        //MARK: Pick Left & Write User
                        HStack {
                            
                            PickUserButton(currentUser: currentUser, pickedUser: $leftUser)

                            Spacer()
                            
                            PickUserButton(currentUser: currentUser, pickedUser: $rightUser)
                        }
                    }
                    .frame(height: width * 0.7)

                    //TI Icon
                    TIIconD2(scale: 0.95, showTwoSides: false)
                        .offset(y: width * -0.026)
                    
                }
                .frame(width: width, height: width * 0.7)

                
                
                //MARK: TI Title
                EnterTiTitle(tiTitle: $tiTitle)
//                    .offset(y: width * 0.03)

                //MARK: Description
//                EnterDescriptionButton(description: .constant("meaw"), buttonTitle: "TI Description")

            }
        }
    }
}

#Preview {
//    CTiStep2D2(
//        currentUser: <#UserModel?#>,
//        tiID: <#String#>,
//        tiInteractionType: <#Binding<TIType>#>,
//        tiThumbnailData: <#Binding<Data?>#>,
//        thumbnailForTypeID: <#String#>,
//        tiTitle: <#Binding<String>#>,
//        leftUser: <#Binding<UserModel?>#>,
//        rightUser: <#Binding<UserModel?>#>)
    
    CreateTI(showFSC: .constant(true), selectedTabIndex: .constant(2), indexStep: 1)

}




