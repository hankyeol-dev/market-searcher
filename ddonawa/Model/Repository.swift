//
//  Repository.swift
//  ddonawa
//
//  Created by 강한결 on 7/7/24.
//

import Foundation
import RealmSwift

struct Repository<T: Object> {
    private let db = try! Realm()
    
    func getRecordById(_ id: String) -> T? {
        return db.object(ofType: T.self, forPrimaryKey: id)
    }
    
    func getRecords() -> Results<T> {
        return db.objects(T.self)
    }
    
    func addRecord(_ record: T) {
        do {
            try db.write {
                db.add(record)
            }
        } catch {
            print(error)
        }
    }
    
    func addRecord(_ record: T, handler: @escaping (T) -> ()) {
        do {
            try db.write {
                handler(record)
                db.add(record)
            }
        } catch {
            print(error)
        }
    }
    
    func editRecord(_ record: T, editHandler: @escaping (T) -> ()) {
        do {
            try db.write {
                editHandler(record)
            }
        } catch {
            print(error)
        }
    }
    
    func deleteRecord(_ record: T) {
        do {
            try db.write {
                db.delete(record)
            }
        } catch {
            print(error)
        }
    }
    
    func deleteAllRecords() {
        do {
            try db.write {
                db.deleteAll()
            }
        } catch {
            print(error)
        }
    }
}
