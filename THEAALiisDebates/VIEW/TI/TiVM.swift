//
//  TiViewModel.swift
//  THEAALiisDebates
//
//  Created by Ali Kadhum on 6/19/24.
//

import Foundation

final class TiViewModel: ObservableObject {
    
    @Published var ti: TI = TestingModels().testTId2
    
    init() {
        fetchTestTi { ti in
            if ti != nil {
                self.ti = ti!
            }
        }
    }
    
//    func fetchTestTi() -> TI? {
//        
//        TIManager.shared.getTi(tiID: "7C3CF55B-7119-40BD-9709-E8D6EAB02353") { result in
//            switch result {
//            case .success(let ti):
//                return ti
//            case .failure(_):
//                return nil
//            }
//        }
//    }
    func fetchTestTi(completion: @escaping (TI?) -> Void) {
        TIManager.shared.getTi(tiID: "7C3CF55B-7119-40BD-9709-E8D6EAB02353") { result in
            switch result {
            case .success(let ti):
                completion(ti)
            case .failure(_):
                completion(nil)
            }
        }
    }
}
