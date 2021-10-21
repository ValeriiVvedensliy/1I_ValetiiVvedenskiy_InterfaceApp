//
//  RGroup.swift
//  1I_ValetiiVvedenskiy_InterfaceApp
//
//  Created by Valera Vvedenskiy on 21.10.2021.
//

import UIKit
import RealmSwift

class RGroup: Object {
    @objc dynamic var groupName: String = ""
    @objc dynamic var groupLogo: String  = ""

    init(groupName: String, groupLogo: String) {
        self.groupName = groupName
        self.groupLogo = groupLogo
    }

    required override init() {
        super.init()
    }
}
