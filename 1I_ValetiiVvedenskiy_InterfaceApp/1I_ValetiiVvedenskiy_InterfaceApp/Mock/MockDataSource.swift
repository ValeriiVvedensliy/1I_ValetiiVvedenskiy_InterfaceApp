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
            Group(name: "Cars", image: "carss"),
            Group(name: "Sport", image: "sport"),
            Group(name: "Photo", image: "photo"),
            Group(name: "Life Stile", image: "life"),
            Group(name: "Mafia", image: "mafia")
        ]
        
        MockDataSource.groups = [
            MockDataSource.allGroups![0], MockDataSource.allGroups![1], MockDataSource.allGroups![2]
        ]
    }
    
    private func setUsers() {
        MockDataSource.users = [
            User(
                firstName: "Albert",
                 lastName: "Enshteinn",
                 info: "родился 14 марта 1879 года",
                 images: ["albert", "albert_2"]),
            User(
                firstName: "Robert",
                lastName: "Downey",
                info: "родился 4 апреля 1965 года",
                images: ["junior"])
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
