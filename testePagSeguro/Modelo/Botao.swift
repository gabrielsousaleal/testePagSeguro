//
//  Botao.swift
//  testePagSeguro
//
//  Created by Gabriel Sousa on 22/11/19.
//  Copyright © 2019 Gabriel Sousa. All rights reserved.
//

import Foundation
import UIKit

class Botao {
    
    var imagem: UIImage?
    var nome: String?
    var viewController: UIViewController?
    
    init(botao: String) {
        
        identificarBotao(nomeBotao: botao)
        
    }
    
    
    func identificarBotao(nomeBotao: String) {
                
        switch nomeBotao {
            
        case "transfer":
            
            let imagem = UIImage(named: "transferencia") ?? UIImage()
            
            let storyboard = UIStoryboard(name: "TransferenciaStoryboard", bundle: nil)

            let viewController = storyboard.instantiateViewController(identifier: "transferenciaStoryboard")
            
            self.imagem = imagem
                   
            self.nome = "Transferência"
                   
            self.viewController = viewController
            
        case "payment":
            
            let imagem = UIImage(named: "pagamento") ?? UIImage()
            
            let storyboard = UIStoryboard(name: "PagamentosStoryboard", bundle: nil)

            let viewController = storyboard.instantiateViewController(identifier: "pagamentosStoryboard")
            
            self.imagem = imagem
                   
            self.nome = "Pagamentos"
                   
            self.viewController = viewController
            
        case "cell_recharge":
            
            let imagem = UIImage(named: "celular") ?? UIImage()
            
            let storyboard = UIStoryboard(name: "CelularStoryboard", bundle: nil)

            let viewController = storyboard.instantiateViewController(identifier: "celularStoryboard")
            
            self.imagem = imagem
                   
            self.nome = "Recarregar celular"
                   
            self.viewController = viewController
            
        case "loan":
            
            let imagem = UIImage(named: "emprestimo") ?? UIImage()
            
            let storyboard = UIStoryboard(name: "EmprestimoStoryboard", bundle: nil)

            let viewController = storyboard.instantiateViewController(identifier: "emprestimoStoryboard")
            
            self.imagem = imagem
                   
            self.nome = "Emprestimo"
                   
            self.viewController = viewController
            
        default:
            
            print("erro ao montar botao")
            
        }
                
    }
    
}
