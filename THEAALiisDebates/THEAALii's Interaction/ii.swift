//
//  ii.swift
//  TheAaliiDebates
//
//  Created by Ali Abraham on 8/24/23.
//

import SwiftUI


//MARK: - ii Button -
struct iiButton: View {
    
    @Binding var ti : TI
    @State private var iiShowFSC = true
    
    var body: some View {
        
        Button {
            iiShowFSC.toggle()
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .stroke(lineWidth: 0.5)
                    .foregroundColor(.secondary)
                    .frame(width: width * 0.2, height: width * 0.17)
                
                HStack(spacing: width * 0.01) {
                    VStack(spacing: width * 0.02) {
                        Image(systemName: "circle")
                            .font(.system(size: width * 0.04, weight: .regular))
                        Rectangle().fill(Color.primary).frame(width: 2, height: 20, alignment: .center)
                    }
                    VStack(spacing: width * 0.02) {
                        Image(systemName: "circle")
                            .font(.system(size: width * 0.04, weight: .regular))
                        Rectangle().fill(Color.primary).frame(width: 2, height: 20, alignment: .center)
                    }
                }.foregroundColor(.primary)
                
            }
        }
        .frame(width: width * 0.4)
        .preferredColorScheme(.dark)
        .fullScreenCover(isPresented: $iiShowFSC) {
            iiFSC(ti: $ti)
        }
    }
}

//MARK: - ii FSC -
struct iiFSC: View {
    
    @Binding var ti: TI
    
    var body: some View {
        
        VStack(spacing: 0) {
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .stroke(lineWidth: 0.5)
                    .foregroundColor(.gray)
                    .frame(width: width * 0.9, height: width * 0.08)

                HStack {
                    UserButton(userUID: nil)
                    Spacer()
                    TIIcon()
                    Spacer()
                    UserButton(userUID: nil)
                }
            }
            
            
        }
        .preferredColorScheme(.dark)
    }
}

//struct ii_Previews: PreviewProvider {
//    static var previews: some View {
//        iiButton(ti: .constant(TestingComponents().testTI0))
//    }
//}

#Preview {
    iiButton(ti: .constant(TestingModels().testTI0))
}
