//
//  Session.swift
//  1I_ValetiiVvedenskiy_InterfaceApp
//
//  Created by Valera Vvedenskiy on 11.10.2021.
//

import Foundation


public class Session: NSObject {
    static var shared: Session = {
        let instance = Session()

        return instance
    }()
    
    public var token: String!
    public var userID: Int!
    
    private override init() {
        super.init()
    }
    
    public func setData(token: String, userID: Int) {
        self.token = token
        self.userID = userID
    }
}
