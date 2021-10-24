//
//  DataSource.swift
//  1I_ValetiiVvedenskiy_InterfaceApp
//
//  Created by Valera Vvedenskiy on 24.10.2021.
//

import Foundation
import RealmSwift

class DataSource {
    func saveFriendsToRealm(_ friendList: [RFriend]) {
        do {
            let realm = try Realm()
            try realm.write{
                let oldFriendList = realm.objects(RFriend.self)
                realm.delete(oldFriendList)
                realm.add(friendList)
            }
        } catch {
            print(error)
        }
    }

    func savePhotosToRealm(_ photoList: [RPhoto], _ ownerID: String) {
        do {
            let realm = try Realm()
            try realm.write{
                let oldPhotoList = realm.objects(RPhoto.self).filter("ownerID == %@", ownerID)
                realm.delete(oldPhotoList)
                realm.add(photoList)
            }
        } catch {
            print(error)
        }
    }

    func saveGroupsToRealm(_ grougList: [RGroup]) {
        do {
            let realm = try Realm()
            try realm.write{
                let oldGroupList = realm.objects(RGroup.self)
                realm.delete(oldGroupList)
                realm.add(grougList)
            }
        } catch {
            print(error)
        }
    }
    
    func deleteAllFromRealm() {
        do {
            let realm = try Realm()
            try realm.write{
                realm.deleteAll()
            }
        } catch {
            print(error)
        }
    }
}
