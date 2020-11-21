//
//  String+Extension.swift
//  ProfileApp
//
//  Created by Pilar Prospero on 20/11/20.
//  Copyright © 2020 Pilar Prospero. All rights reserved.
//

import Foundation

extension String {
    
    mutating func formatDate(text: String, withFormat format: String = "yyyy-MM-dd'T'HH:mm:ss.SSSSx") {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        guard let date = dateFormatter.date(from: text) else {
            preconditionFailure("format error")
        }
        
        dateFormatter.dateFormat = "MMM dd, yyyy - HH:mm"
        let res = dateFormatter.string(from: date)
        
        self = "User since \(res)"
    }
    
}
