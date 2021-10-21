//
//  RFriend.swift
//  1I_ValetiiVvedenskiy_InterfaceApp
//
//  Created by Valera Vvedenskiy on 21.10.2021.
//

import UIKit
import RealmSwift

class RFriend: Object {
    @objc dynamic var userName: String = ""
    @objc dynamic var userAvatar: String  = ""
    @objc dynamic var ownerID: String  = ""

    init(userName:String, userAvatar:String, ownerID:String) {
        self.userName = userName
        self.userAvatar = userAvatar
        self.ownerID = ownerID
    }

    required override init() {
        super.init()
    }
}
