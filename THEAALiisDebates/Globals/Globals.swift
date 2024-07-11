//
//  Globals.swift
//  TheAaliiDebates
//
//  Created by Ali Abraham on 1/8/23.
//

import SwiftUI

let width  = UIScreen.main.bounds.width
let height = UIScreen.main.bounds.height

struct FrameModifier: ViewModifier {
    
    var width: CGFloat = UIScreen.main.bounds.width
    var height: CGFloat = UIScreen.main.bounds.height
    
    func body(content: Content) -> some View {

        content
            .frame(width: width, height: height)
    }
}

enum AddOrRemove { case add, remove }
enum IncreaseOrDecrease { case increase, decrease }

extension Color {
    
    struct ADColors {
        static let green = Color(red: 40 / 255, green: 159 / 255, blue: 122 / 255)
    }
}


extension Array where Element: Equatable {

    // Remove the first element in collection that is equal to the given `object`:
    mutating func remove(object: Element) {
        guard let index = firstIndex(of: object) else {return}
        remove(at: index)
    }

}


