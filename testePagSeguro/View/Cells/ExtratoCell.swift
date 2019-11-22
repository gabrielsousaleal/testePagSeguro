//
//  ExtratoCells.swift
//  testePagSeguro
//
//  Created by Gabriel Sousa on 21/11/19.
//  Copyright © 2019 Gabriel Sousa. All rights reserved.
//

import Foundation
import UIKit

class ExtratoCell: UITableViewCell {
    
    @IBOutlet var imagemVieww: UIImageView!
    
    @IBOutlet var tipoLabel: UILabel!
    
    @IBOutlet var dataLabel: UILabel!
    
    @IBOutlet var totalLabel: UILabel!
    
    
    func configurarCell(extrato: Extrato) {
        
        tipoLabel.text = extrato.type
        
        dataLabel.text  = extrato.date
        
        let totalString = Helper.formatarStringParaMoeda(valor: extrato.value)
        
        totalLabel.text = totalString
        
    }
    
}
