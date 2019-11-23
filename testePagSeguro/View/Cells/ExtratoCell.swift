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
    
    //FUNCAO QUE CONFIGURA E POPULA A CELL
    func configurarCell(extrato: Extrato) {
        
        tipoLabel.text = extrato.type
        
        let data = formatarData(data: extrato.date)
        dataLabel.text  = data
        
        let totalString = Helper.formatarStringParaMoeda(valor: extrato.value)
        totalLabel.text = totalString
        
    }
    
    func formatarData(data: String) -> String {
        
        let ano = data.subString(from: 0, to: 3)
        let mes = data.subString(from: 5, to: 6)
        let dia = data.subString(from: 8, to: 9)
        
        let horario = data.subString(from: 11, to: 15)
        
        let novaData = dia + "/" + mes + "/" + ano + " às " + horario

        return novaData
        
    }
    
}

//FUNCAO QUE FAZ SUBSTRING
extension String {
    func subString(from: Int, to: Int) -> String {
       let startIndex = self.index(self.startIndex, offsetBy: from)
       let endIndex = self.index(self.startIndex, offsetBy: to)
       return String(self[startIndex...endIndex])
    }
}
