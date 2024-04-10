//
//  SideOptionsSheet.swift
//  TheAaliiDebates
//
//  Created by Ali Abraham on 3/2/23.
//

import SwiftUI

struct SideOptionsSheet: View {
    
    @Binding var showSideSheet: Bool
    
    var body: some View {
        
        ZStack {
            
            // - Black Background
            RoundedRectangle(cornerRadius: 20)
                .foregroundColor(.black)
                .frame(width: width * 0.35, height: width * 0.45, alignment: .leading)
            
            // - Border
            RoundedRectangle(cornerRadius: 20)
                .strokeBorder(lineWidth: 0.2)
                .foregroundColor(.primary)
                .frame(width: width * 0.35, height: width * 0.45, alignment: .leading)
            
            
            HStack(spacing: 0) {
                
                //MARK: - Left Column
                VStack(spacing: 0) {
                    
                    // -
                    Button {
                        
                    } label: {
//                        Image(systemName: "circle")
//                            .frame(width: width * 0.15, height: width * 0.15)
                        FutureFeatureButton()
                    }
                    
                    // -
                    Button {
                        
                    } label: {
                        Image(systemName: "circle")
                            .frame(width: width * 0.15, height: width * 0.15)
                    }
                    
                    // -
                    Button {
                        
                    } label: {
                        Image(systemName: "circle")
                            .frame(width: width * 0.15, height: width * 0.15)
                    }
                    
                }
                .frame(width: width * 0.15, height: width * 0.15)
                
                //MARK: - Right Column
                VStack(spacing: 0) {
                    
                    // -
                    Button {
                        
                    } label: {
                        Image(systemName: "circle")
                            .frame(width: width * 0.15, height: width * 0.15)
                    }
                    
                    // -
                    Button {
                        
                    } label: {
                        Image(systemName: "circle")
                            .frame(width: width * 0.15, height: width * 0.15)
                        
                    }
                    
                    // -
                    Button {
                        withAnimation(.spring()) {
                            showSideSheet.toggle()
                        }
                    } label: {
                        Image(systemName: "chevron.right")
                            .font(.title)
                            .fontWeight(.thin)
                            .frame(width: width * 0.15, height: width * 0.15)
                    }
                    
                }
                .frame(width: width * 0.15, height: width * 0.15)
                
            }
            .foregroundColor(.primary)
            .frame(width: width * 0.35, height: width * 0.45, alignment: .leading)
        }
    }
}

struct SideOptionsSheet_Previews: PreviewProvider {
    static var previews: some View {
        
//        VideoInfoSV()
//            .preferredColorScheme(.dark)
        
        SideOptionsSheet(showSideSheet: .constant(true))
            .preferredColorScheme(.dark)
    }
}
