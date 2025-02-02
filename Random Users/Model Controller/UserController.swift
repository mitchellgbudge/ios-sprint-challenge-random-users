//
//  UserController.swift
//  Random Users
//
//  Created by Mitchell Budge on 6/14/19.
//  Copyright © 2019 Erica Sadun. All rights reserved.
//

import Foundation

class UserController {
    
    // MARK: - Properties
    
    var users: [User] = []
    let baseURL = URL(string: "https://randomuser.me/api/?format=json&inc=name,email,phone,picture&results=1000")!
    typealias CompletionHandler = (Error?) -> Void
    
    // MARK: - Networking Methods
    
    func fetchUsers(completion: @escaping CompletionHandler = { _ in }) {
        URLSession.shared.dataTask(with: baseURL) { (data, _, error) in
            if let error = error {
                NSLog("Error fetching users: \(error)")
                completion(error)
                return
            }
            guard let data = data else {
                NSLog("No data returned from data task")
                completion(nil)
                return
            }
                do {
                    let newUser = try JSONDecoder().decode(Users.self, from: data)
                    self.users = newUser.results
                } catch {
                    NSLog("Error decoding user: \(error)")
                    completion(error)
                }
            completion(nil)
            }.resume()
    }
}
