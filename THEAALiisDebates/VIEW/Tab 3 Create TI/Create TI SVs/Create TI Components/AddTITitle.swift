//
//  AddTITitle.swift
//  THEAALiisDebates
//
//  Created by Ali Kadhum on 4/29/24.
//

import SwiftUI

//MARK: - Add TIT Title
struct AddTITitle: View {
    
    @Binding var tiTitle: String
    
    enum Field { case tiTitle }
    @FocusState private var focusField: Field?
    
    let maxLength: Int = 75
    @State private var showSheet = false
    
    var body: some View {
        HStack(spacing: 10) {
            
            //MARK: Title
            ZStack {
                //Border
                RoundedRectangle(cornerRadius: 8)
                    .strokeBorder(lineWidth: 0.5)
                    .foregroundColor(tiTitle != "" ? .primary : .red)
                    .frame(width: width * 0.9, height: width * 0.2)
                
                if tiTitle == "" {
                    Text("TI Title")
                        .foregroundStyle(.white)
                }
                
                // -- //
                TextField("", text: $tiTitle, axis: .vertical)
                    .multilineTextAlignment(.center) // Aligns text to the left
                    .lineLimit(2)
                    .frame(width: width * 0.9, height: width * 0.15, alignment: .center)
                    .focused($focusField, equals: .tiTitle)
                    .submitLabel(.done)
                    .onChange(of: tiTitle) { newValue, _ in
                        
                        if tiTitle.contains("\n") {
                            focusField = nil
                            tiTitle = tiTitle.replacingOccurrences(of: "\n", with: "")
                        }
                        
                        if newValue.count > maxLength {
                            tiTitle = String(newValue.prefix(maxLength)) // Truncate text to max length
                        }
                    }
            }
        }
    }
}

#Preview {
    //    AddTITitle()
    
    CreateTI(showFSC: .constant(true), selectedTabIndex: .constant(2), indexStep: 1)
    
}
