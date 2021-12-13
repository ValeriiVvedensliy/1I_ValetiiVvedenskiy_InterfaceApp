//
//  VKGroupsDataSource.swift
//  1I_ValetiiVvedenskiy_InterfaceApp
//
//  Created by Valera Vvedenskiy on 21.10.2021.
//

import Foundation
import RealmSwift

class VKGroupsDataSource {
  lazy var operationQueue = OperationQueue()
  
  func getData() {
    let loadedJsonFromVK = LoadJsonData()
    let parsedDataFromJson = ParseJsonData()
    let saveData = SaveDataToRealm()
    
    parsedDataFromJson.addDependency(loadedJsonFromVK)
    saveData.addDependency(parsedDataFromJson)
    
    let operations = [loadedJsonFromVK, parsedDataFromJson, saveData]
    operationQueue.addOperations(operations, waitUntilFinished: false)
  }
  
  class OperationsAsync: Operation {
    
    enum State: String {
      case ready, executing, finished
      fileprivate var keyPath: String {
        return "is" + rawValue.capitalized
      }
    }
    
    var state = State.ready {
      willSet {
        willChangeValue(forKey: state.keyPath)
        willChangeValue(forKey: newValue.keyPath)
      }
      didSet {
        didChangeValue(forKey: state.keyPath)
        didChangeValue(forKey: oldValue.keyPath)
      }
    }
    
    override var isAsynchronous: Bool {
      return true
    }
    
    override var isReady: Bool {
      return super.isReady && state == .ready
    }
    
    override var isExecuting: Bool {
      return state == .executing
    }
    
    override var isFinished: Bool {
      return state == .finished
    }
    
    override func start() {
      if isCancelled {
        state = .finished
      } else {
        main()
        state = .executing
      }
    }
    
    override func cancel() {
      super.cancel()
      state = .finished
    }
  }
  
  
  final class LoadJsonData: OperationsAsync {
    
    var jsonFromVK: Data?
    var errorFromVK: Error?
    
    override func main() {
      let configuration = URLSessionConfiguration.default
      let session =  URLSession(configuration: configuration)
      
      var urlConstructor = URLComponents()
      urlConstructor.scheme = "https"
      urlConstructor.host = "api.vk.com"
      urlConstructor.path = "/method/groups.get"
      urlConstructor.queryItems = [
        URLQueryItem(name: "user_id", value: String(Session.shared.userID)),
        URLQueryItem(name: "extended", value: "1"),
        URLQueryItem(name: "access_token", value: Session.shared.token),
        URLQueryItem(name: "v", value: "5.81")
      ]
      
      let task = session.dataTask(with: urlConstructor.url!) { [weak self] (data, _, error) in
        guard let data = data else { return }
        
        self?.jsonFromVK = data
        self?.errorFromVK = error
        self?.state = .finished
      }
      task.resume()
    }
  }
  
  final class ParseJsonData: Operation {
    var dataFromJson: [RGroup]?
    var errorFromJson: Error?
    
    override func main() {
      
      guard
        let operation = dependencies.first as? LoadJsonData,
        let data = operation.jsonFromVK
      else { return }
      
      do {
        let arrayGroups = try JSONDecoder().decode(ResponseGroups.self, from: data)
        var grougList: [RGroup] = []
        for i in 0...arrayGroups.response.items.count-1 {
          let name = ((arrayGroups.response.items[i].name))
          let logo = arrayGroups.response.items[i].photo_50
          grougList.append(RGroup.init(groupName: name, groupLogo: logo))
        }
        
        dataFromJson = grougList
      } catch let error {
        errorFromJson = error
        print(error.localizedDescription )
      }
    }
  }
  
  final class SaveDataToRealm: Operation {
    override func main() {
      guard
        let operation = dependencies.first as? ParseJsonData,
        let data = operation.dataFromJson
      else { return }
      DispatchQueue.main.async {
        DataSource().saveGroupsToRealm(data)
      }
    }
  }
}
