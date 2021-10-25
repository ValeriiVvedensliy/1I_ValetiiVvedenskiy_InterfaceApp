//
//  UserJson.swift
//  1I_ValetiiVvedenskiy_InterfaceApp
//
//  Created by Valera Vvedenskiy on 17.10.2021.
//

import Foundation

struct UserJson {
    let id: Int
    var name = ""
    var username = ""
    var email = ""
    var address: Address?
    var phone = ""
    var website = ""
    var company: Company?

    init(id: Int) {
        self.id = id
    }

    init(json: [String: Any] ) {
        let id = json["id"] as! Int
        self.init(id: id)

        self.name = json["name"] as! String
        self.username = json["username"] as! String

        self.email = json["email"] as! String
        self.phone = json["phone"] as! String
        self.website = json["website"] as! String

        let addressJson = json["address"] as! [String: Any]
        self.address = Address(json: addressJson)

        let companyJson = json["company"] as! [String: Any]
        self.company = Company(json: companyJson)
    }
}

struct Address {
    struct Geo {
        var lat = ""
        var lng = ""
    }

    var street = ""
    var suite = ""
    var city = ""
    var zipcode = ""
    var geo: Geo?

    init(json: [String: Any] ) {
        self.suite = json["suite"] as! String
        self.city = json["city"] as! String
        self.zipcode = json["zipcode"] as! String
        let geoJson = json["geo"] as! [String: Any]
        let lat = geoJson["lat"] as! String
        let lng = geoJson["lng"] as! String
        self.geo = Geo(lat: lat, lng: lng)
    }
}

struct Company {
    var name = ""
    var catchPhrase = ""
    var bs = ""

    init(json: [String: Any] ) {
        self.name = json["name"] as! String
        self.catchPhrase = json["catchPhrase"] as! String
        self.bs = json["bs"] as! String
    }
}
