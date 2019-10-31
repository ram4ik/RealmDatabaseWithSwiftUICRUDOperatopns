//
//  ContentView.swift
//  RealmDatabaseWithSwiftUICRUDOperatopns
//
//  Created by Ramill Ibragimov on 31.10.2019.
//  Copyright © 2019 Ramill Ibragimov. All rights reserved.
//

import SwiftUI
import RealmSwift

struct ContentView: View {
    @State var name = ""
    @State var age = ""
    var body: some View {
        VStack {
            TextField("name", text: $name).textFieldStyle(RoundedBorderTextFieldStyle())
            TextField("age", text: $age).textFieldStyle(RoundedBorderTextFieldStyle())
            Button(action: {
                let config = Realm.Configuration(schemaVersion: 1)
                do {
                    let realm = try Realm(configuration: config)
                    let newdata = datatype()
                    newdata.name = self.name
                    newdata.age = self.age
                    try realm.write({
                        realm.add(newdata)
                        print("Success")
                    })
                }
                catch {
                    print(error.localizedDescription)
                }
            }) {
                Text("Save")
            }
            Button(action: {
                let config = Realm.Configuration(schemaVersion: 1)
                do {
                    let realm = try Realm(configuration: config)
                    let result = realm.objects(datatype.self)
                    print(result)
                }
                catch {
                    print(error.localizedDescription)
                }
            }) {
                Text("Display")
            }
        }.padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

class datatype: Object {
    @objc dynamic var name = ""
    @objc dynamic var age = ""
}
