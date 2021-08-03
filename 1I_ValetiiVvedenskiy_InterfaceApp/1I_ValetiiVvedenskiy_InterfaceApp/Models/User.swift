import Foundation


public class User {
    let firstName: String
    let lastName: String
    let images: [String]
    
    init(firstName: String, lastName: String, images: [String]) {
        self.firstName = firstName
        self.lastName = lastName
        self.images = images
    }
}
