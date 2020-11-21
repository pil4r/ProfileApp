//
//  ProfileConnection.swift
//  ProfileApp
//
//  Created by Pilar Prospero on 20/11/20.
//  Copyright © 2020 Pilar Prospero. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import Reachability

typealias DataCompletionHandler = (Result<ProfileModel, ProfilesError>) -> Void
private let urlString = "https://randomuser.me/api/"

public enum ProfilesError: Error {
    case error
    case urlError(String)
}

protocol ProfileConnectionProtocol {
    func getProfiles(completion: @escaping DataCompletionHandler)
}
 
final class ProfileConnection: ProfileConnectionProtocol {
    
    func getProfiles(completion: @escaping DataCompletionHandler) {
        guard let _ = URL(string: urlString) else {
            return completion(.failure(.urlError(ErrorMessages.internalError)))
        }
        let reachability: Reachability
        do {
            reachability = try Reachability()
            if reachability.connection != .unavailable {
                AF.request(urlString).response { response in
                    if let obj = response.data {
                        do {
                            if let jsonData = try? JSONDecoder().decode(ProfileModel.self, from: obj) {
                              completion(.success(jsonData))
                            } else {
                              completion(.failure(.urlError(ErrorMessages.internalError)))
                            }
                            
                        }
                    } else {
                        completion(.failure(.urlError(ErrorMessages.internalError)))
                    }
                }
            } else {
                return completion(.failure(.urlError(ErrorMessages.noInternet)))
            }
        } catch {
            return completion(.failure(.urlError(ErrorMessages.internalError)))
        }
    }
}
