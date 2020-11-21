//
//  UIImage+Extension.swift
//  ProfileApp
//
//  Created by Pilar Prospero on 20/11/20.
//  Copyright © 2020 Pilar Prospero. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

extension UIImageView {
    public func getImage(url string: String?) {
        if let picture = string, let _ = URL(string: picture) {
            AF.request( picture, method: .get).response{ response in
                switch response.result {
                case .success(let responseData):
                    self.image = UIImage(data: responseData!, scale:1)
                    
                case .failure(let error):
                    print("ProfileAppError: ",error)
                }
            }
        }
    }
}

