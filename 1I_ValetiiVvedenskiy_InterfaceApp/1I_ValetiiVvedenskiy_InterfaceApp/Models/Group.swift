import Foundation
import UIKit

struct Group: Equatable {
    let name: String
    let image: String

    static func == (lhs: Group, rhs: Group) -> Bool {
        return lhs.name == rhs.name
    }
}
