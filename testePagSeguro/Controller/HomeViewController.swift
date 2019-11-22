//
//  HomeViewController.swift
//  testePagSeguro
//
//  Created by Gabriel Sousa on 21/11/19.
//  Copyright © 2019 Gabriel Sousa. All rights reserved.
//

import Foundation
import UIKit

class HomeViewController: UIViewController {
    
    //****************************************************************
    //MARK: STORYBOARD OUTLETS
    //****************************************************************
    
    @IBOutlet var saldoLabel: UILabel!
    
    @IBOutlet var botao1: UIButton!
    
    @IBOutlet var botao2: UIButton!
    
    @IBOutlet var botao3: UIButton!
    
    @IBOutlet var botao4: UIButton!
    
    //****************************************************************
    //MARK: VARIAVEIS
    //****************************************************************
    
    var usuario: Usuario!
    
    var saldo: String?
    
    var listaBotoes: [UIButton] = []
    
    var listaToggles: [String] = []
    
    
    
    
    //****************************************************************
    //MARK: CICLO DE VIDA
    //****************************************************************
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pegarUsuarioUserDefaults()
        
        popularBotoes()
        
        pegarSaldo()
                
    }
    
    
    //****************************************************************
    //MARK: REQUISICOES DAO
    //****************************************************************
    
    
    func pegarUsuarioUserDefaults(){
        
        guard let usuario = DAO().pegarUsuarioUserDefaults() else {
            
            Segues.irParaLogin(vc: self)
            
            return
            
        }
        
        self.usuario = usuario
                
    }
    
    func pegarSaldo(){
                
        DAO().pegarSaldo(usuario: usuario) { saldo in
            
            self.saldo = saldo
            
            self.popularSaldo()
            
        }
        
    }
    
    
    //****************************************************************
    //MARK: LAYOUT
    //****************************************************************

    
    func popularSaldo(){
        
         DispatchQueue.main.async {
        
        var saldoString: String!
        
            if self.saldo == nil {
            
            saldoString = "Não foi possível obter saldo."
            
        } else {
            
                saldoString = "R$\(self.saldo!)"
            
        }
        
            self.saldoLabel.text = saldoString
            
        }
        
    }
    
    //****************************************************************
    //MARK: LÓGICA
    //****************************************************************
    
    func pegarToggles(){
        
        listaToggles = usuario.toggles
        
    }
    
    func popularBotoes(){
        
        pegarToggles()
        
        listaBotoes.append(botao4)
        listaBotoes.append(botao3)
        listaBotoes.append(botao2)
        listaBotoes.append(botao1)
     
    }
    
    
}
