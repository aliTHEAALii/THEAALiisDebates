//
//  AddD2Info.swift
//  THEAALiisDebates
//
//  Created by Ali Kadhum on 4/10/24.
//

import SwiftUI

struct AddD2Info: View {
    
    let tiID: String
    @Binding var tiInteractionType: TIType?
    
    @Binding var tiThumbnailData: Data?
    let thumbnailForTypeID: String

    @Binding var tiTitle: String
    enum Field {
        case debateTitle, debateDescription, videoTitle, videoDescription
    }
    @FocusState private var focusField: Field?

    @Binding var leftUser : String?
    @Binding var rightUser: String?
    

    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
//    AddD2Info()
    CreateTI(showFSC: .constant(true), selectedTabIndex: .constant(2), indexStep: 1)

}
