//
//  LogInButton.swift
//  TheAaliiDebates
//
//  Created by Ali Abraham on 1/8/23.
//

import SwiftUI

struct LogInButton: View {
    
    enum Provider {
        case apple
        case google
        case email
        case anonymous
    }
    
    var provider: Provider
    
    var body: some View {
        
        ZStack {
            
            //Border
            RoundedRectangle(cornerRadius: 8)
                .strokeBorder(Color.primary, lineWidth: 1)
                .frame(minHeight: 50) //minHeight for iPhone 8 size
                .frame(width: width * 0.85, height: width * 0.145, alignment: .leading)
            
            
            //Button Logo
            HStack {
                
                switch provider {
                // apple
                case .apple:
                    Image(systemName: "applelogo")
                        .font(.system(size: width * 0.1))
                        .padding(.horizontal, 5)
                //google
                case .google:
                    Image("googlelogo")
                        .renderingMode(.template)
                        .resizable()
                        .frame(width: width * 0.1, height: width * 0.1, alignment: .leading) //min height for iPhone 8
                        .padding(.horizontal, 5)
                //email
                case .email:
                    Image(systemName: "envelope.fill")
                        .font(.system(size: width * 0.085, weight: .regular))
                        .padding(.horizontal, 0.3) //0.3
//                        .offset(x: -5)
                    
                case .anonymous:
                    PersonTITIconSV(fill: true, scale: 1.4)
                        .padding(.horizontal, width * 0.025) //0.3
//                        .offset(x: 25)


                }
                
                
                                
            }
            .frame(width: width * 0.8, height: height * 0.07, alignment: .leading)
            
            //Button Text
            HStack {
                if provider == .apple || provider == .google {
                    Text("Continue with \(provider == .apple ? "Apple" : "Google")")
                        .font(Font.title3.weight(.regular)) //medium
                        .kerning(1.05)
                        .padding(.leading, width * 0.3)
                } else if provider == .email {
                    Text("Continue with E-mail")
                        .font(Font.title3.weight(.regular)) //medium
                        .kerning(1.05)
                        .padding(.leading, width * 0.3)

                } else {
                    Text("Continue Anonymously")
                        .font(Font.title3.weight(.regular)) //medium
                        .kerning(1.05)
                        .padding(.leading, width * 0.3)
                }
            }
            .frame(width: width, alignment: .leading)
            
        }
        .frame(width: width)
        .foregroundColor(.primary)
        .padding(.bottom, width * 0.04)
    }
}


struct LogInButton_Previews: PreviewProvider {
    static var previews: some View {
        LoginScreen()
            .preferredColorScheme(.dark)
    }
}
