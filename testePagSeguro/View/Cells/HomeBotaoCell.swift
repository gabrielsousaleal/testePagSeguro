//
//  PerfilBotaoCell.swift
//  testePagSeguro
//
//  Created by Gabriel Sousa on 22/11/19.
//  Copyright © 2019 Gabriel Sousa. All rights reserved.
//

import Foundation
import UIKit

class HomeBotaoCell: UICollectionViewCell {
    
    @IBOutlet var botaoView: UIView!
    
    @IBOutlet var imageView: UIImageView!
    
    @IBOutlet var nomeLabel: UILabel!
    
    var viewController: UIViewController?
    
    
    func configurarCell(botao: String) {
        
        let botaoObj = Botao(botao: botao)
        
        imageView.image = botaoObj.imagem
        
        nomeLabel.text = botaoObj.nome ?? "?"
        
        viewController = botaoObj.viewController
        
    }
    
}