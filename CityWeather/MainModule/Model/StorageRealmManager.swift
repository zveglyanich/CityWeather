//
//  StorageRealmManager.swift
//  CityWeather
//
//  Created by Pavel Zveglyanich on 1/21/21.
//

import RealmSwift
import Foundation

enum RealmErrors: Error {
    
    var error: String {
        switch self {
        case .ErrorOfReadDataBase: return "Data isn't read in Database"
        case .ErrorOfWriteInDataBase: return "Current data isn't write in Database"
        case .ErrorOfDeleteInDataBase: return "Current data isn't delete in Database"
        }
    }
    
    case ErrorOfWriteInDataBase
    case ErrorOfDeleteInDataBase
    case ErrorOfReadDataBase
}


protocol Storageprotocol: class {
    func saveCity(_ data: CityData) throws
    func deleteCity(_ data: CityData) throws
    var realm: Realm? { get }
}

class StorgeRealmManager: Storageprotocol {
    
    static let shared = StorgeRealmManager()  //remark #6
    
    var realm: Realm? { //remark #34
        do {
            return try Realm()
        } catch {
            print (RealmErrors.ErrorOfReadDataBase.error)
        }
        return self.realm
    }
    
    private init () {}  //remark #6
    
    func saveCity(_ data: CityData) throws { //remark #34
        guard realm != nil else { throw RealmErrors.ErrorOfWriteInDataBase}
        try realm?.write {
            realm?.add(data)
        }
    }
    
    func deleteCity(_ data: CityData) throws { //remark #34
        guard realm != nil else { throw RealmErrors.ErrorOfDeleteInDataBase}
        try realm?.write {
            realm?.delete(data)
        }
    }
}
