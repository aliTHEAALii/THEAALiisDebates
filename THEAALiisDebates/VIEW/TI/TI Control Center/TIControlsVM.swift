//
//  TIControlsVM.swift
//  TheAaliiDebates
//
//  Created by Ali Abraham on 5/17/23.
//

import Foundation
//import FirebaseFirestoreSwift

//struct TIMapModel {
//    let title: String
//    let thumbnail: String?
//}

@MainActor
final class TIContolsViewModel: ObservableObject {
    
    @Published var ti: TIModel? = nil
    @Published var tiChain: [TIVideoModel] = []
    @Published var isLoading: Bool = false
    
    init() { }
    
    //MARK: Fetch ☕️ Map
    func fetchTIMap(ti: TIModel) async throws {
        
        isLoading = true
        self.ti = ti
        
        guard !ti.interactionChain.isEmpty else { return }

        for chainLId in ti.interactionChain {
            Task {
                //1. get TI Chain Link
                let tiChainL = try await TITChainLManager.shared.readCLink(titId: ti.id, titCLinkId: chainLId)
                //2. get TI Video
                let tiVideo = try await TITVideoManager.shared.getTITVideo(TITid: ti.id, TITVideoID: tiChainL.videoId ?? "no video Id")
                //3. add to tiChain
                tiChain.append(tiVideo)
            }
        }
        
        isLoading = false
    }
    
    //MARK: Increase ☕️ Index
    func increaseIndex(currentIndex: inout Int) {
        print("🥶current Index = \(currentIndex)🥶1111")
        guard let ti = ti else { return }
        guard currentIndex < ti.interactionChain.count - 1 else { return }
        currentIndex += 1
        print("🥶current Index = \(currentIndex)🥶")
    }
    
    //MARK: decrease ☕️ Index
    func decreaseIndex(currentIndex: inout Int) {
//        print("🥶current Index = \(currentIndex)🥶22222")
        guard currentIndex > 0 else { return }
        currentIndex -= 1
//        print("🥶current Index = \(currentIndex)🥶")

    }
    
    func mapAppear(ti: TIModel) async throws {
        print("tiVideo Title: 0🧿")
        print("🧿🧿🧿chain::: \(tiChain)")

//        guard let ti = ti else { return }
        print("tiVideo Title: 1🧿")

        guard !ti.interactionChain.isEmpty else { return }
        print("tiVideo Title: 2🧿")

        
        for chainLId in ti.interactionChain {
            Task {
                let tiChainL = try await TITChainLManager.shared.readCLink(titId: ti.id, titCLinkId: chainLId)
                let tiVideo = try await TITVideoManager.shared.getTITVideo(TITid: ti.id, TITVideoID: tiChainL.videoId ?? "no video Id")
                
                tiChain.append(tiVideo)
                print("tiVideo Title: \(tiVideo.name)last🧿")
                print(" 🧿🔗🟠 ti Chain \(tiChain) 🧿🔗🟠")

            }
        }
        
    }
    
    func getChainVideo(tiId: String, chainLId: String) async throws -> TIVideoModel? {
        var tiVideo: TIVideoModel? = nil
        Task {
            let tiChainL = try await TITChainLManager.shared.readCLink(titId: tiId, titCLinkId: chainLId)
            tiVideo = try await TITVideoManager.shared.getTITVideo(TITid: tiId, TITVideoID: tiChainL.videoId ?? "no video Id")
            
//            tiChain.append(tiVideo)
            print("tiVideo Title: \(tiVideo?.name ?? "❌ couldn't get title")last🧿")
        }
        return tiVideo

    }
    
    func uploadTIVideoToTIChain(ti: TIModel, tiVideo: TIVideoModel) async throws {
        
//        guard let tiId = ti?.id else { print("❌🔺☕️🍵🧬 no ti?.Id in : func uploadTIVideoToTIChain") ; return }
        
        Task {
            
            let _ = try await getChainVideo(tiId: ti.id, chainLId: ti.interactionChain[0])

            //1. create  TI Video in DB
            try await TITVideoManager.shared.createTitVideo(titID: ti.id, titVideo: tiVideo)
            
            //2. create Chain in DB
            let tiChainLId = UUID().uuidString
            let tiChainL = TITChainLModel(id: tiChainLId, videoId: tiVideo.id, videoTitle: tiVideo.name, videoThumbnail: tiVideo.thumbnail, responseList: [])
            
            try await TITChainLManager.shared.createCLink(titId: ti.id, titCL: tiChainL)
            
            //3. add Chain to ti interaction Chain
            try await TITManager.shared.addToChain(titId: ti.id, chainId: tiChainLId)
            
            //4. fetch data agian to show upload
//            tiChain.append(tiVideo)
            try await fetchTIMap(ti: ti)
        }
        
        
    }
}
