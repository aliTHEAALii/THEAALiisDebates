////
////  TI1DIcon.swift
////  TheAaliiDebates
////
////  Created by Ali Abraham on 6/23/23.
////
//
//import SwiftUI
//
////MARK: - TI 1D Icon
//struct TI1DIcon: View {
//    var body: some View {
//        
//        ZStack(alignment: .leading) {
//            
//            //Right Ribbon
//            RoundedRectangle(cornerRadius: 2)
//                .stroke(lineWidth: 1)
//                .frame(width: width * 0.2, height: width * 0.03)
//                .offset(x: 5)
//            
//            TIPostIcon()
//        }
//        .frame(height: width * 0.05)
//        .preferredColorScheme(.dark)
//    }
//}
//
//struct TI1DIcon_Previews: PreviewProvider {
//    static var previews: some View {
//        CreateTIFSC(showFSC: .constant(true), selectedTabIndex: .constant(2))
////        TI1DIcon()
//
//        TIPostIcon()
//    }
//}
//
//
////MARK: - TI 2D Icon
//struct TI2DIcon: View {
//    var body: some View {
//        
//        ZStack(alignment: .center) {
//            
//            //Right Ribbon
//            RoundedRectangle(cornerRadius: 2)
//                .stroke(lineWidth: 1)
//                .frame(width: width * 0.15, height: width * 0.03)
//                .offset(x: 25)
//            
//            //Left Ribbon
//            RoundedRectangle(cornerRadius: 2)
//                .stroke(lineWidth: 1)
//                .frame(width: width * 0.15, height: width * 0.03)
//                .offset(x: -25)
//            
//            TIPostIcon()
//        }
//        .frame(height: width * 0.05)
//        .preferredColorScheme(.dark)
//    }
//}
//
////MARK: - TI Post Icon
//struct TIPostIcon: View {
//    var body: some View {
//        
//        ZStack(alignment: .center) {
//            
//            //Black Background
//            Circle()
//                .fill(.black)
//            Circle()
//                .stroke(lineWidth: 1)
//            
//            Image(systemName: "triangle")
//                .font(.system(size: width * 0.025, weight: .light))
//                .rotationEffect(.degrees(180))
//                .foregroundColor(.ADColors.green)
//        }
//        .frame(height: width * 0.05)
//        .preferredColorScheme(.dark)
//    }
//}
//
//
