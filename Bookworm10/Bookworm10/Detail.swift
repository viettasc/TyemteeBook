//
//  Detail.swift
//  Bookworm10
//
//  Created by Viettasc on 2/1/20.
//  Copyright © 2020 Viettasc. All rights reserved.
//

import SwiftUI

struct Detail: View {
    @Environment(\.managedObjectContext) private var moc
    @Environment(\.presentationMode) private var presentationMode
    @State var book: Book
    @State var active = false
    func date() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: book.date ?? Date())
    }
    var body: some View {
        VStack {
            ZStack(alignment: .bottomTrailing) {
                Image(book.title?.lowercased() ?? "tyemtee")
                    .resizable()
                    .scaledToFit()
                    .padding()
                Text(genre())
                    .font(.caption)
                    .bold()
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.black.opacity(0.75))
                    .clipShape(Capsule())
                    .offset(x: -45, y: -45)
            }
            Text(date())
                .font(.callout)
                .padding()
            Text(book.author ?? "Viettasc")
                .font(.largeTitle)
//                .foregroundColor(.secondary)
            .foregroundColor( book.rating > 1 ? Color.pink.opacity(0.6) : Color.red)
            Text(book.review ?? "So Cool")
//                .font(.headline)
                .padding()
            Rating(rating: $book.rating)
                .font(.largeTitle)
            Spacer()
        }
        .navigationBarTitle(Text(book.title ?? "tyemtee"), displayMode: .inline)
        .alert(isPresented: $active) {
            Alert(title: Text("Remove Book"), message: Text("Are you sure?"), primaryButton: .destructive(Text("Remove"), action: {
                self.remove()
            }), secondaryButton: .cancel())
        }
        .navigationBarItems(trailing: Button(action: {
            self.trash()
        }, label: {
            Image(systemName: "trash")
        }))
        .foregroundColor(Color.pink.opacity(0.6))
    }
    
    func remove() -> Void {
        moc.delete(book)
        do {
            try moc.save()
            presentationMode.wrappedValue.dismiss()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func trash() -> Void {
        active.toggle()
    }
    
    func genre() -> String {
        if let genre = book.genre,
            genre != "" {
            return genre
        }
        return "Lomonoxop"
    }
    
}

struct Detail_Previews: PreviewProvider {
    @Environment(\.managedObjectContext) private static var moc
    static var previews: some View {
        Detail(book: Book(context: moc))
    }
}
