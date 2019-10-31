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
    @State var course = ""
    
    var body: some View {
        VStack {
            TextField("name", text: $name).textFieldStyle(RoundedBorderTextFieldStyle())
            TextField("age", text: $age).textFieldStyle(RoundedBorderTextFieldStyle())
            TextField("course", text: $course).textFieldStyle(RoundedBorderTextFieldStyle())
            
            Button(action: {
                let config = Realm.Configuration(schemaVersion: 1)
                do {
                    let realm = try Realm(configuration: config)
                    let newdata = datatype1()
                    newdata.name = self.name
                    newdata.age = self.age
                    newdata.Course = self.course
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
                    let result = realm.objects(datatype1.self)
                    print(result)
                }
                catch {
                    print(error.localizedDescription)
                }
            }) {
                Text("Display")
            }
            Button(action: {
                let config = Realm.Configuration(schemaVersion: 1)
                do {
                    let realm = try Realm(configuration: config)
                    let result = realm.objects(datatype1.self)
                    
                    for i in result {
                        try realm.write({
                            if i.name == "user" {
                                i.age = "25"
                                realm.add(i)
                            }
                        })
                    }
                }
                catch {
                    print(error.localizedDescription)
                }
            }) {
                Text("Edit")
            }
            Button(action: {
                let config = Realm.Configuration(schemaVersion: 1)
                do {
                    let realm = try Realm(configuration: config)
                    let result = realm.objects(datatype1.self)
                    
                    for i in result {
                        try realm.write({
                            if i.name == "user" {
                              
                                realm.delete(i)
                            }
                        })
                    }
                }
                catch {
                    print(error.localizedDescription)
                }
            }) {
                Text("Delete")
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

class datatype1: Object {
    @objc dynamic var name = ""
    @objc dynamic var age = ""
    @objc dynamic var Course = ""
}
