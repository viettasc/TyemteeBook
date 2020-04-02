//
//  ContentView.swift
//  Bookworm10
//
//  Created by Viettasc on 2/1/20.
//  Copyright © 2020 Viettasc. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) private var moc
    @FetchRequest(entity: Book.entity(), sortDescriptors: []) var books: FetchedResults<Book>
    @State var active = false
    func action() -> Void {
        active.toggle()
    }
    func remove(at indexs: IndexSet) -> Void {
        for index in indexs {
            let book = books[index]
            moc.delete(book)
        }
        do {
            try moc.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    var body: some View {
        NavigationView {
            List {
                ForEach(books, id: \.id) { book in
                    NavigationLink(destination: Detail(book: book)) {
                        Emoji(rating: book.rating)
                            .font(.largeTitle)
                        VStack {
                            Text("\(book.title ?? "Unknown title")")
                                .font(.headline)
                            Text("\(book.author ?? "Unknown author")")
                                .foregroundColor(.secondary)
                        }
                    }
                }
                .onDelete(perform: remove(at:))
            }
            .navigationBarTitle("Bookworm")
            .navigationBarItems(leading: EditButton(), trailing: Button(action: {
                self.action()
            }, label: {
                Image(systemName: "plus")
            }))
        }
        .sheet(isPresented: self.$active) {
            Add().environment(\.managedObjectContext, self.moc)
        }
        .foregroundColor(Color.pink.opacity(0.6))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
