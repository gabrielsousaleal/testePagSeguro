//
//  Usuario.swift
//  testePagSeguro
//
//  Created by Gabriel Sousa on 21/11/19.
//  Copyright © 2019 Gabriel Sousa. All rights reserved.
//

import Foundation
import UIKit

struct Usuario: Codable {
    
    let name: String
    let email: String
    let ddd: String
    let token: String
    let phoneNumber: String
    let document: String
    let _id: Int
    var toggles: [String]
    
}
