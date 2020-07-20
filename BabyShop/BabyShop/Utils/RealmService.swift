import Foundation
import RealmSwift

class RealmService {
    static let deleteIfMigration = Realm.Configuration(deleteRealmIfMigrationNeeded: true)

    static func save<T: Object>(items: [T],
                                configuration: Realm.Configuration = deleteIfMigration,
                                update: Realm.UpdatePolicy = .modified) throws {
        let realm = try Realm(configuration: configuration)
        try realm.write {
            realm.add(items, update: update)
        }
    }
    static func get<T: Object>(_ type: T.Type,
                               configuration: Realm.Configuration = deleteIfMigration)
        throws -> Results<T> {
            let realm = try Realm(configuration: configuration)
            return realm.objects(type)
    }
    static func get<T: Object, KeyType>(_ type: T.Type,
                                        primaryKey: KeyType,
                                        config: Realm.Configuration = .defaultConfiguration
    ) throws -> T? {
        let realm = try Realm(configuration: config)
        return realm.object(ofType: type, forPrimaryKey: primaryKey)
    }
}
