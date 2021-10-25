//
//  RPhoto.swift
//  1I_ValetiiVvedenskiy_InterfaceApp
//
//  Created by Valera Vvedenskiy on 21.10.2021.
//

import UIKit
import RealmSwift

class RPhoto: Object {
    @objc dynamic var photo: String = ""
    @objc dynamic var ownerID: String  = ""

    init(photo: String, ownerID: String) {
        self.photo = photo
        self.ownerID = ownerID
    }

    required override init() {
        super.init()
    }
}
