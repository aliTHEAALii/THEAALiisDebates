////
////  AddD2Info.swift
////  THEAALiisDebates
////
////  Created by Ali Kadhum on 4/10/24.
////
//
//import SwiftUI
//
//struct AddD2Info: View {
//    
//    @AppStorage("current_user_id") var currentUserUID: String = ""
//    let currentUser: UserModel?
//
//    let tiID: String
//    @Binding var tiInteractionType: TIType
//    
//    @Binding var tiThumbnailData: Data?
//    let thumbnailForTypeID: String
//
//    @Binding var tiTitle: String
////    enum Field {
////        case debateTitle, debateDescription, videoTitle, videoDescription
////    }
////    @FocusState private var focusField: Field?
//
//    @Binding var leftUser : UserModel?
//    @Binding var rightUser: UserModel?
//    
//
//    var body: some View {
//        
//        ZStack {
//            VStack(spacing: width * 0.07) {
//                
//                //Thumbnail & Users
//                ZStack(alignment: .bottom) {
//                    
//                    VStack(spacing: width * 0.02) {
//                        
//                        //MARK: Thumbnail
//                        PickThumbnailButton(thumbnailFor: .TI, thumbnailForTypeID: tiID, imageData: $tiThumbnailData, buttonText: "TI \nThumbnail")
//                        
//                        
//                        
//                        //MARK: Pick Left & Write User
//                        HStack {
//                            
//                            PickUserButton(currentUser: currentUser, pickedUser: $leftUser)
//
//                            Spacer()
//                            
//                            PickUserButton(currentUser: currentUser, pickedUser: $rightUser)
//                        }
//                    }
//                    .frame(height: width * 0.7)
//
//                    //TI Icon
//                    TIIconD2(scale: 0.95, showTwoSides: false)
//                }
//                .frame(width: width, height: width * 0.7)
//
//                
//                
//                //MARK: TI Title
//                AddTITitle(tiTitle: $tiTitle)
////                    .offset(y: width * 0.03)
//
//                //MARK: Description
////                EnterDescriptionButton(description: .constant("meaw"), buttonTitle: "TI Description")
//
//            }
//        }
//    }
//}
//
//#Preview {
////    AddD2Info(tiID: "", tiInteractionType: .constant(.d2), tiThumbnailData: .constant(nil), thumbnailForTypeID: <#T##String#>, tiTitle: <#T##Binding<String>#>, leftUser: <#T##Binding<String?>#>, rightUser: <#T##Binding<String?>#>)
//    CreateTI(showFSC: .constant(true), selectedTabIndex: .constant(2), indexStep: 1)
//
//}
//
////MARK: - Add TIT Title
////struct AddTITitle: View {
////    
////    @Binding var tiTitle: String
//////    @FocusState private var focusField: Field?
////    enum Field {
////        case debateTitle, debateDescription, videoTitle, videoDescription
////    }
////    @FocusState private var focusField: Field?
////    
////    var body: some View {
////        HStack(spacing: 10) {
////            
////            //MARK: Left User
////            //                UserButton(userID: "")
////            
////            //MARK: Title
////            ZStack {
////                //Border
////                RoundedRectangle(cornerRadius: 8)
////                    .strokeBorder(lineWidth: 0.5)
////                    .foregroundColor(tiTitle != "" ? .primary : .red)
////                    .frame(width: width * 0.9, height: width * 0.2)
////                
////                if tiTitle == "" {
////                    Text("TI Title")
////                    //                                .foregroundColor(.secondary.opacity(0.5))
////                }
////                
////                TextField("", text: $tiTitle, axis: .vertical)
////                    .multilineTextAlignment(.center)
////                    .frame(width: width * 0.9, height: width * 0.1, alignment: .center)
////                    .submitLabel(.done)
////                    .focused($focusField, equals: .debateTitle)
////                    .onSubmit { focusField = .debateDescription }
////            }
////            
////            //MARK: Right User
////            //                UserButton(userID: "")
////        }
////    }
////}
