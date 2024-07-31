//
//  TabSearchView.swift
//  THEAALiisDebates
//
//  Created by Ali Kadhum on 7/28/24.
//

import SwiftUI

struct TabSearchView: View {
    
    @State private var searchInteractions = true
    @State private var searchText = ""
    
    @State private var interactionsFeed: [TI] = []

    var body: some View {
        
        NavigationStack {
            
            //Search [ TIs || Users ] Bar
            HStack {
                Spacer()
                
                Button {
                    searchInteractions = true
                } label: {
                    ZStack {
                        if searchInteractions {
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(lineWidth: 0.5)
                        }
                        Text("Interactions")
                    }
                    .frame(width: width * 0.4, height: width * 0.1)
                }
                
                
                Spacer()
                
                
                Button {
                    searchInteractions = false
                } label: {
                    ZStack {
                        if !searchInteractions {
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(lineWidth: 0.5)
                        }
                        Text("Users")
                    }
                    .frame(width: width * 0.4, height: width * 0.1)
                }
                
                Spacer()
            }
            .foregroundStyle(.primary)
            
            if !interactionsFeed.isEmpty {
                
            }
            
            Spacer()
        }
        .searchable(text: $searchText, prompt: "Search \(searchInteractions ? "THEAALii's Interactions" : "Users")")
        .onChange(of: searchText) { oldValue, newValue in
            guard searchText.count > 3 else { return }
            
            Task {
                await TIManager.shared.searchItems(searchText: newValue)
            }
        }
    }
    
//    func searchItems() {
//        db.collection("items").whereField("name", isGreaterThanOrEqualTo: searchText)
//            .whereField("name", isLessThanOrEqualTo: searchText + "\u{f8ff}")
//            .getDocuments { (querySnapshot, error) in
//                if let error = error {
//                    print("Error getting documents: \(error)")
//                } else {
//                    self.items = querySnapshot?.documents.compactMap { queryDocumentSnapshot in
//                        try? queryDocumentSnapshot.data(as: Item.self)
//                    } ?? []
//                }
//            }
//    }
}

#Preview {
    TabSearchView()
}
