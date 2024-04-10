//
//  VotingSV.swift
//  TheAaliiDebates
//
//  Created by Ali Abraham on 5/25/23.
//

import SwiftUI

struct VotingSV: View {
    
    let tiId: String
    @Binding var tiVideo: TIVideoModel?
    
    @AppStorage("current_user_id") private var currentUserId: String = ""
    @Binding var showSideOptions: Bool

    var body: some View {
        
        VStack(spacing: 0) {
            
            Button {
                upVote()
            } label: {
                Image(systemName: "chevron.up")
                    .foregroundColor(tiVideo!.upVotersIDArray.contains(currentUserId) ? .ADColors.green : .secondary)
                    .font(.title)
                    .fontWeight(tiVideo!.upVotersIDArray.contains(currentUserId) ? .heavy : .regular)
                    .frame(width: width * 0.15, height: width * 0.15)
            }
            
            //MARK: show options
            Button {
                withAnimation(.spring()) {
                    showSideOptions.toggle()
                }
            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 8)
                        .strokeBorder(lineWidth: 0.5)
                        .frame(width: width * 0.13, height: width * 0.1)
                    
                    //Text("4.6K")
                    Text( String(tiVideo!.totalVotes) )
//                    Text( String(tiVideo!.upVotes - tiVideo!.downVotes) )
                        .fontWeight(.light)
                }
                .foregroundColor(.primary)
                .frame(width: width * 0.15, height: width * 0.15)
            }
            
            
            Button {
                downVote()
            } label: {
                Image(systemName: "chevron.down")
                    .foregroundColor(tiVideo!.downVotersIDArray.contains(currentUserId) ? .red : .secondary)
                    .font(.title)
                    .fontWeight(tiVideo!.downVotersIDArray.contains(currentUserId) ? .heavy : .regular)
                    .frame(width: width * 0.15, height: width * 0.15)
            }
            
        }
        .preferredColorScheme(.dark)
    }
    
    //MARK: - UPVOTE func
    private func upVote() {
        Task {
            guard let tiVideoId = tiVideo?.id else { return }
            
            if tiVideo!.upVotersIDArray.contains(currentUserId) {
                //remove userId from array
                try await TITVideoManager.shared.updateUpVotersArray(tiId: tiId, tiVideoId: tiVideoId, userId: currentUserId, addOrRemove: .remove)
                try await TITVideoManager.shared.changeUpVotes(tiId: tiId, tiVideoId: tiVideoId, increaseOrDecrease: .decrease)

                
                tiVideo!.upVotersIDArray.remove(object: currentUserId)
                tiVideo!.upVotes -= 1
                tiVideo!.totalVotes -= 1
                
            } else {
                //if Down Voted
                if tiVideo!.downVotersIDArray.contains(currentUserId) {
                    try await TITVideoManager.shared.updateDownVotersArray(tiId: tiId, tiVideoId: tiVideoId, userId: currentUserId, addOrRemove: .remove)
                    try await TITVideoManager.shared.changeDownVotes(tiId: tiId, tiVideoId: tiVideoId, increaseOrDecrease: .decrease)
                    
                    tiVideo!.downVotersIDArray.remove(object: currentUserId)
                    tiVideo!.downVotes -= 1
                    tiVideo!.totalVotes += 1

                }
                    
                try await TITVideoManager.shared.updateUpVotersArray(tiId: tiId, tiVideoId: tiVideoId, userId: currentUserId, addOrRemove: .add)
                try await TITVideoManager.shared.changeUpVotes(tiId: tiId, tiVideoId: tiVideoId, increaseOrDecrease: .increase)

                
                tiVideo!.upVotersIDArray.append(currentUserId)
                tiVideo!.upVotes += 1
                tiVideo!.totalVotes += 1

            }
        }
    }
    
    //MARK: - DOWNVOTE func
    private func downVote() {
        Task {
            guard let tiVideoId = tiVideo?.id else { return }
            
            if tiVideo!.downVotersIDArray.contains(currentUserId) {
                //remove userId from array
                try await TITVideoManager.shared.updateDownVotersArray(tiId: tiId, tiVideoId: tiVideoId, userId: currentUserId, addOrRemove: .remove)
                try await TITVideoManager.shared.changeDownVotes(tiId: tiId, tiVideoId: tiVideoId, increaseOrDecrease: .decrease)

                
                tiVideo!.downVotersIDArray.remove(object: currentUserId)
                tiVideo!.downVotes -= 1
                tiVideo!.totalVotes += 1

                
            } else {
                //if upvoted
                if tiVideo!.upVotersIDArray.contains(currentUserId) {
                    try await TITVideoManager.shared.updateUpVotersArray(tiId: tiId, tiVideoId: tiVideoId, userId: currentUserId, addOrRemove: .remove)
                    try await TITVideoManager.shared.changeUpVotes(tiId: tiId, tiVideoId: tiVideoId, increaseOrDecrease: .decrease)
                    
                    tiVideo!.upVotersIDArray.remove(object: currentUserId)
                    tiVideo!.upVotes -= 1
                    tiVideo!.totalVotes -= 1

                }
                    
                try await TITVideoManager.shared.updateDownVotersArray(tiId: tiId, tiVideoId: tiVideoId, userId: currentUserId, addOrRemove: .add)
                try await TITVideoManager.shared.changeDownVotes(tiId: tiId, tiVideoId: tiVideoId, increaseOrDecrease: .increase)

                
                tiVideo!.downVotersIDArray.append(currentUserId)
                tiVideo!.downVotes += 1
                tiVideo!.totalVotes -= 1

            }
        }
    }
}

//MARK: preview
struct VotingSV_Previews: PreviewProvider {
    static var previews: some View {
        VotingSV(tiId: "tiId", tiVideo: .constant(TestingComponents().titVideo1), showSideOptions: .constant(false))
    }
}


//MARK: - Numbers Simplifier
//func numbersSimplifier(number: Int)-> String {
//
//    //Convert Int to Array of Ints
//    var numberArray = String(describing: number).compactMap { Int(String($0)) }
////        let numberArray = String(describing: number).compactMap { Int(String($0)) }
//
//
////        if number < 1000 {
//    if numberArray.count < 3 {
//
//        return "\(number)"
//
//    //Thousands
//    } else if numberArray.count == 4 { //1,000
//
//        if numberArray[1] == 0 {
//            return "\(numberArray[0])K"
//        } else {
//            return "\(numberArray[0]).\(numberArray[1])K"
//        }
//
//    } else if numberArray.count == 5 {  // 10,000
//        return "\(numberArray[0])\(numberArray[1])K"
//
//    } else if numberArray.count == 6 {  //100,000
//
//        return "\(numberArray[0])\(numberArray[1])\(numberArray[2])K"
//
//    //Millions
//    }else if numberArray.count == 7 { //1,000,000
//
//        if numberArray[1] == 0 {
//            return "\(numberArray[0])M"
//        } else {
//            return "\(numberArray[0]).\(numberArray[1])M"
//        }
//
//    } else if numberArray.count == 8 { //10,000,000
//
//        return "\(numberArray[0])\(numberArray[1]))M"
//
//    } else if numberArray.count == 9 {  //100,000,000
//
//        return "\(numberArray[0])\(numberArray[1])\(numberArray[2])M"
//
//    //Billions
//    } else if numberArray.count == 10 { //1,000,000,000
//
//        if numberArray[1] == 0 {
//            return "\(numberArray[0])B"
//        } else {
//            return "\(numberArray[0]).\(numberArray[1])B"
//        }
//
//    } else if numberArray.count == 11 {  // 10,000,000,000
//        return "\(numberArray[0])\(numberArray[1])B"
//
//    } else if numberArray.count == 12 {  //100,000,000,000
//
//        return "\(numberArray[0])\(numberArray[1])\(numberArray[2])B"
//
//    }
//    return ""
//}
//
////MARK: VoteAbso
//var votesAbsolute: String {
//
//    guard let tiVideo = tiVideo else { return "" }
//
//    var isNegative = tiVideo.totalVotes < 0
//    var numberArray = String(describing: tiVideo.totalVotes).compactMap { Int(String($0)) }
//
//    var votesAbsolute = "0"
//
//    //MARK START
//    if numberArray.count < 3 {
//
//        votesAbsolute = "\(tiVideo.totalVotes)"
//
//    //Thousands
//    } else if numberArray.count == 4 { //1,000
//
//        if numberArray[1] == 0 {
//            return "\(numberArray[0])K"
//        } else {
//            return "\(numberArray[0]).\(numberArray[1])K"
//        }
//
//    } else if numberArray.count == 5 {  // 10,000
//        return "\(numberArray[0])\(numberArray[1])K"
//
//    } else if numberArray.count == 6 {  //100,000
//
//        return "\(numberArray[0])\(numberArray[1])\(numberArray[2])K"
//
//    //Millions
//    }else if numberArray.count == 7 { //1,000,000
//
//        if numberArray[1] == 0 {
//            return "\(numberArray[0])M"
//        } else {
//            return "\(numberArray[0]).\(numberArray[1])M"
//        }
//
//    } else if numberArray.count == 8 { //10,000,000
//
//        return "\(numberArray[0])\(numberArray[1]))M"
//
//    } else if numberArray.count == 9 {  //100,000,000
//
//        return "\(numberArray[0])\(numberArray[1])\(numberArray[2])M"
//
//    //Billions
//    } else if numberArray.count == 10 { //1,000,000,000
//
//        if numberArray[1] == 0 {
//            return "\(numberArray[0])B"
//        } else {
//            return "\(numberArray[0]).\(numberArray[1])B"
//        }
//
//    } else if numberArray.count == 11 {  // 10,000,000,000
//        return "\(numberArray[0])\(numberArray[1])B"
//
//    } else if numberArray.count == 12 {  //100,000,000,000
//
//        return "\(numberArray[0])\(numberArray[1])\(numberArray[2])B"
//
//    }
//    return "\(isNegative ? "-" : "")" + votesAbsolute
//}
