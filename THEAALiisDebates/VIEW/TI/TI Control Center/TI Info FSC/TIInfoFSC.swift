//
//  TIInfoFSC.swift
//  TheAaliiDebates
//
//  Created by Ali Abraham on 5/24/23.
//

import SwiftUI

struct TIInfoFSC: View {
    
    @Binding var ti: TIModel
    
    @AppStorage("current_user_id") private var currentUserId: String = ""
    @Binding var showTIInfoFSC: Bool
    
    var body: some View {
        
        
        VStack() {
            
            //MARK: Top Bar
            HStack(spacing: 0) {
                Text("THEAALii's Interaction Info")
                    .foregroundColor(.ADColors.green)
                    .font(.title)
                    .frame(width: width * 0.85)
                
                CloseButton(showFSC: $showTIInfoFSC)
                    .frame(width: width * 0.15)
                
            }
            .frame(width: width)
            .preferredColorScheme(.dark)
            
            Divider()
            
            ScrollView(showsIndicators: false) {
                
                Text(ti.name)
                    .font(.title2)
                
                
                //MARK: 2. Description & Buttons
                ZStack {
                    HStack(spacing: 0) {
                        
                        DescriptionSV(descriptionTitle: ti.name, text: ti.description)
                        
                        // - Video Buttons
                        VStack(spacing: 0) {
                            
                            //Save TI
                            SaveTIButton()
                            
                                                        
                            //Comments
                            CommentsButton()
                            
                            Rectangle()
                                .foregroundColor(.black)
                                .frame(width: width * 0.15, height: width * 0.15)
                            
                        }
                        .frame(width: width * 0.15, height: width * 0.45)
                    }
                    
                    // - Side Sheet (Don't Delete)
                    //                SideOptionsSheet(showSideSheet: $showSideOptions)
                    //                    .offset(x: showSideOptions ? width * 0.375 : width * 0.68)
                    SideSheet()
                }// ZStack - //
                
                Divider()
                
                HStack(spacing: 0) {
                    Text("TI Creator")
                        .padding(.all)
                        .frame(width: width * 0.85, alignment: .leading)
                    
                    UserButton(userUID: ti.creatorUID)
                }
                
                //MARK: - Admins List
                TIAdminsListSV(ti: $ti)
                
            }// Scroll View -//
        }
    }
}

struct TIInfoFSC_Previews: PreviewProvider {
    static var previews: some View {
        TIInfoButton(ti: .constant(TestingModels().testingTI))
        
        TIInfoFSC(ti: .constant(TestingModels().testingTI), showTIInfoFSC: .constant(true))
    }
}

//MARK: - TI Info Button
struct TIInfoButton: View {
    
    @Binding var ti: TIModel
    
    @State private var showTIInfoFSC = false
    
    var body: some View {
        
        Button {
            showTIInfoFSC.toggle()
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .strokeBorder(lineWidth: 0.5)
                    .foregroundColor(.secondary)
                    .frame(width: width * 0.25, height: width * 0.12)
                
                Text("TI Info")
                    .font(.title2)
                    .fontWeight(.light)
                    .foregroundColor(.ADColors.green)
            }
        }
        .padding(.all)
        .preferredColorScheme(.dark)
        .fullScreenCover(isPresented: $showTIInfoFSC) {
            TIInfoFSC(ti: $ti, showTIInfoFSC: $showTIInfoFSC)
        }
    }
}


////MARK: - Creator & Admins SV
//struct TIAdminsListSV: View {
//
//    @Binding var ti: TIModel
//
//    @AppStorage("current_user_id") private var currentUserId: String = ""
//
//    var body: some View {
//
//        VStack {
//
//            Text("TI Administrators")
//                .font(.system(size: width * 0.05, weight: .thin))
//
//
//
//            // - Edit Admins
//            //FIXME: Activate if
////            if currentUserId == ti.creatorUID {
//            HStack(spacing: 0) {
//
//                //MARK: Remove Admin
//                Button {
//                    if currentUserId == ti.creatorUID {
//
//                    }
//                } label: {
//                    ZStack {
//                        RoundedRectangle(cornerRadius: 8)
//                            .strokeBorder(lineWidth: 0.7)
//                            .frame(width: width * 0.3, height: width * 0.1)
//                            .foregroundColor(.secondary)
//
//                        Text("Remove Admin")
////                            .font(.system(size: width * 0.05, weight: .thin))
//                            .foregroundColor(.primary)
//                    }
//                }
//                .padding(.all)
//
//                Spacer()
//
//                //MARK: Add admin
//                Button {
//                    if currentUserId == ti.creatorUID {
//
//                    }
//                } label: {
//                    HStack(spacing: 0) {
//
//                        ZStack {
//                            RoundedRectangle(cornerRadius: 8)
//                                .strokeBorder(lineWidth: 0.7)
//                                .frame(width: width * 0.3, height: width * 0.1)
//                                .foregroundColor(.secondary)
//
////                            Image(systemName: "plus")
//                            Text("Add Admin")
////                                .font(.system(size: width * 0.05, weight: .thin))
//                                .foregroundColor(.primary)
//                        }
////                        .frame(width: width * 0.15)
//                    }
//                }
//                .padding(.all)
//            }
//            .padding(.vertical)
//
//            //MARK: admins List
//            ForEach(ti.administratorsUID, id: \.self) { adminId in
//
//                HStack(spacing: 0) {
//                    Text(adminId)
//                        .foregroundColor(.secondary)
//                        .padding(.all)
//                        .frame(width: width * 0.85, alignment: .leading)
//
//                    UserButton(userID: adminId)
//                }
//            }
//        }
//    }
//}


//MARK: - Save TI Button
struct SaveTIButton: View {
    
    var body: some View {
        Button {
            
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .strokeBorder(lineWidth: 1)
                    .frame(width: width * 0.12, height: width * 0.12)
                    .foregroundColor(.secondary)
                
                Text("Save TI")
                    .foregroundColor(.primary)
                    .multilineTextAlignment(.center)
                    .font(.system(size: width * 0.05, weight: .thin))

            }
            .frame(width: width * 0.15, height: width * 0.15)
        }
    }
}
