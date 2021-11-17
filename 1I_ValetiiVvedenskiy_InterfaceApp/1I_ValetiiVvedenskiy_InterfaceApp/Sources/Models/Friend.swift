//
//  Friend.swift
//  1I_ValetiiVvedenskiy_InterfaceApp
//
//  Created by Valera Vvedenskiy on 04.11.2021.
//

import Foundation
import UIKit

class Friend {
var userName: String
var userAvatar: URL
var ownerID: String

    init(userName: String, userAvatar: URL, ownerID: String) {
        self.userName = userName
        self.userAvatar = userAvatar
        self.ownerID = ownerID
    }
}
