//
//  Add.swift
//  Bookworm10
//
//  Created by Viettasc on 2/1/20.
//  Copyright © 2020 Viettasc. All rights reserved.
//

import SwiftUI

struct Add: View {
    @Environment(\.managedObjectContext) private var moc
    @Environment(\.presentationMode) private var presentationMode
    @State private var component: (id: UUID, author: String, title: String, genre: String, review: String, rating: Int16) = (UUID(), "", "", "", "", 0)
    let genres = ["Nguyen Trai", "Phan Dinh Phung", "Lomonoxop"]
    func add() -> Void {
        let book = Book(context: moc)
        book.title = component.title
        book.author = component.author
        book.rating = component.rating
        book.review = component.review
        book.id = UUID()
        book.genre = component.genre
        book.date = Date()
        do {
            try moc.save()
            presentationMode.wrappedValue.dismiss()
        } catch {
            print(error.localizedDescription)
        }
    }
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Title", text: $component.title)
                    TextField("Author", text: $component.author)
                    Picker("Genre", selection: $component.genre) {
                        ForEach(genres, id: \.self) {
                            Text("\($0)")
                        }
                        .id(UUID())
                    }
                }
                Section {
                    Rating(rating: $component.rating)
                    TextField("Review", text: $component.review)
                }
                Button("Add") {
                    self.add()
                }
            }
        }
        .foregroundColor(Color.pink.opacity(0.6))
    }
}

struct Add_Previews: PreviewProvider {
    static var previews: some View {
        Add()
    }
}
