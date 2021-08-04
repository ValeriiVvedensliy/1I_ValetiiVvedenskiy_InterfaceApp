import Foundation


public class MockDataSource {
    
    private static var users: [User]?
    private static var groups: [Group]?
    private static var allGroups: [Group]?
    
    init() {
        setGroups()
        setUsers()
    }
    
    private func setGroups() {
        MockDataSource.allGroups = [
            Group(name: "Cars", image: "group"),
            Group(name: "Sport", image: "group"),
            Group(name: "Foto", image: "group"),
            Group(name: "Life Stile", image: "group"),
            Group(name: "Mafia", image: "group")
        ]
        
        MockDataSource.groups = [
            MockDataSource.allGroups![0], MockDataSource.allGroups![1], MockDataSource.allGroups![2]
        ]
    }
    
    private func setUsers() {
        MockDataSource.users = [
            User(firstName: "Albert", lastName: "Enshteinn", images: ["albert", "albert_2"]),
            User(firstName: "Junior", lastName: "ML", images: ["junior"])
        ]
    }
    
    public func getGroups() -> [Group] {
        MockDataSource.groups ?? []
    }
    
    public func getUsers() -> [User] {
        MockDataSource.users ?? []
    }
    
    public func getAllGroups() -> [Group] {
        MockDataSource.allGroups ?? []
    }
    
    public func deleteGroupByUser(idx: Int) -> [Group] {
        MockDataSource.groups?.remove(at: idx)
        
        return MockDataSource.groups!
    }
    
    public func addGroupByUser(groupName: String) -> Bool {
        let group = MockDataSource.groups?.first(where: {$0.name == groupName})
        guard group != nil else {
            let newGroup = MockDataSource.allGroups?.first(where: {$0.name == groupName})
            MockDataSource.groups?.append(newGroup!)
            return true
        }
        
        return false
    }
}
