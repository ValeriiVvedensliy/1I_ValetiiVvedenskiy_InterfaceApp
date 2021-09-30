import Foundation


public class User {
    let firstName: String
    let lastName: String
    let info: String
    let images: [String]
    
    init(firstName: String, lastName: String, info: String, images: [String]) {
        self.firstName = firstName
        self.lastName = lastName
        self.info = info
        self.images = images
    }
}
