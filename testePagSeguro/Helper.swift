//
//  Helper.swift
//  testePagSeguro
//
//  Created by Gabriel Sousa on 21/11/19.
//  Copyright © 2019 Gabriel Sousa. All rights reserved.
//

import Foundation

class Helper {
    
    static func formatarStringParaMoeda(valor: String) -> String?{
        //FORMATAR O PRECO PARA STRING
        
        var valorMoeda = "R$" + valor
        
        let indexDoUltimoPonto = valorMoeda.lastIndex(of: ".")
        
        valorMoeda.remove(at: indexDoUltimoPonto!)
        
        valorMoeda.insert(",", at: indexDoUltimoPonto!)
        
        return valorMoeda
        
       
    }

}



