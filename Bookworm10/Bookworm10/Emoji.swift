//
//  Emoji.swift
//  Bookworm10
//
//  Created by Viettasc on 2/1/20.
//  Copyright © 2020 Viettasc. All rights reserved.
//

import SwiftUI

struct Emoji: View {
    var rating: Int16
    
    var body: some View {
        switch rating {
        case 1:
            return Text("😏")
        case 2:
            return Text("😳")
        case 3:
            return Text("🥺")
        case 4:
            return Text("🤤")
        default:
            return Text("😆")
        }
    }
}

struct Emoji_Previews: PreviewProvider {
    static var previews: some View {
        Emoji(rating: 3)
    }
}
