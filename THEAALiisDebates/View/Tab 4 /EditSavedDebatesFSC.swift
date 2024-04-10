//
//  SavedDebatesEditingFSC.swift
//  TheAaliiDebates
//
//  Created by Ali Abraham on 2/22/23.
//

import SwiftUI

struct EditSavedDebatesFSC: View {
    
    ///@Binding showDebateView: Bool
    
    ///var currentUser.savedDebatesArray
    
    var body: some View {
        
        VStack(spacing: 0) {
            
            //Close
            HStack(spacing: 0) {
                
                Text("Edit Saved Debates")
                    .font(.title2)
                    .foregroundColor(.ADColors.green)
                
            }
            .padding(.bottom)
            .frame(width: width, height: width * 0.15, alignment: .center)
            
            //Edit
            HStack(spacing: 0) {
                
                ZStack() {
                    
                    EditButton()
                        .frame(width: width * 0.15)
                        .foregroundColor(.primary)
                    
                    RoundedRectangle(cornerRadius: 4)
                        .stroke(lineWidth: 2)
                        .foregroundColor(.ADColors.green)
                        .frame(width: width * 0.12, height: width * 0.1)
                }
            }
            .frame(width: width, height: width * 0.15, alignment: .trailing)
            
            //MARK: - List
            List{
                ForEach(0..<5, id: \.self) { i in
                    
                    HStack(spacing: 0) {
                        
                        Text("\(i + 1).")
                            .frame(width: width * 0.1)
                        
                        VStack(spacing: 3) {
                            Rectangle()
                                .foregroundColor(.gray)
                                .frame(width: width * 0.3, height: width * 0.5625 * 0.3)
                            //Number of Chain Links in Debate
                            Text("5 \(Image(systemName: "ellipsis"))")
                        }
                        
                        Text("Debate Title: let's try something else  for change and we'll see how bad it gets ")
                            .multilineTextAlignment(.leading)
                            .padding(.leading, width * 0.02)
                            .frame(width: width * 0.5, height: width * 0.5625 * 0.4 , alignment: .leading)
                    }
                }//forEach
//                .onDelete(perform: delete)
//                .onMove(perform: move)
                
            }//List
//            .listStyle(GroupedListStyle())
        }
        .preferredColorScheme(.dark)
    }
    
    //MARK: - Functions
    //    func delete(indexSet: IndexSet){
    //        SavedDebates.remove(atOffsets: indexSet)
    //    }
    //
    //    func move(indices : IndexSet, newOffset : Int){
    //        SavedDebates.move(fromOffsets: indices, toOffset: newOffset)
    //    }
}

struct EditSavedDebatesFSC_Previews: PreviewProvider {
    static var previews: some View {
        EditSavedDebatesFSC()
            .preferredColorScheme(.dark)
    }
}
