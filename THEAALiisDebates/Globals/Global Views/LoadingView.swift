//
//  LoadingView.swift
//  TheAaliiDebates
//
//  Created by Ali Abraham on 2/21/23.
//

import SwiftUI

struct LoadingView: View {
    
//    @Binding var show: Bool
    @State private var rotation: Double = -360
    
    var body: some View {
               
        ZStack {
            
//            if show {
                Rectangle()
                    .edgesIgnoringSafeArea(.all)
                    .foregroundColor(.black)
                    .opacity(0.25)
                
                RoundedRectangle(cornerRadius: 20)
                    .foregroundColor(.black)
                    .frame(width: width * 0.2, height: width * 0.2)
                
                Circle()
                    .trim(from: 0.25, to: 1)
                    .stroke(lineWidth: 2.5)
                    .frame(width: width * 0.1, height: width * 0.1)
                    .foregroundColor(.gray)
                    .rotationEffect(.degrees(self.rotation))
                    .onAppear() {
                        if self.rotation == 0 {
                            withAnimation(.linear(duration: 1).repeatForever(autoreverses: false)) {
                                self.rotation = 360
                            }
                        } else {
                            withAnimation(.linear(duration: 0.7).repeatForever(autoreverses: false)) {
                                self.rotation = 0
                            }
                        }
                    }
//            }
        }
        .animation(.easeInOut(duration: 0.25), value: true)
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
