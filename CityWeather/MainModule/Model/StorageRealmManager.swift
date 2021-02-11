//
//  StorageRealmManager.swift
//  CityWeather
//
//  Created by Pavel Zveglyanich on 1/21/21.
//

import RealmSwift

protocol Storageprotocol: class {
    func saveCity(_ data: CityData)
    func deleteCity(_ data: CityData)
    var realm: Realm { get}
}

class StorgeRealmManager: Storageprotocol {
    
    let realm = try! Realm()
    
    func saveCity(_ data: CityData) {
        try! realm.write {
            realm.add(data)
        }
    }
    func deleteCity(_ data: CityData) {
        try! realm.write {
            realm.delete(data)
        }
    }
}
