//
//  Rating.swift
//  Bookworm10
//
//  Created by Viettasc on 2/1/20.
//  Copyright © 2020 Viettasc. All rights reserved.
//

import SwiftUI

struct Rating: View {
    @Binding var rating: Int16
    func tap(number: Int) -> Void {
        rating = Int16(number)
    }
    var body: some View {
        HStack {
            ForEach(1...5, id: \.self) { number in
                Image(systemName: "star.fill")
                    .foregroundColor(self.rating >= number ? Color.yellow : Color.gray)
                    .onTapGesture {
                        self.tap(number: number)
                }
            }
        }
        .foregroundColor(Color.pink.opacity(0.6))
    }
}

struct Rating_Previews: PreviewProvider {
    static var previews: some View {
        Rating(rating: .constant(3))
    }
}
