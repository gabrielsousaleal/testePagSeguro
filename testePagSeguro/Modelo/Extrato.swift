//
//  Extrato.swift
//  testePagSeguro
//
//  Created by Gabriel Sousa on 21/11/19.
//  Copyright © 2019 Gabriel Sousa. All rights reserved.
//

import Foundation

struct Extrato: Decodable {
    
    let type: String
    let date: String
    let value: String
    let code: String
    
}
