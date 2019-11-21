//
//  LoginViewController.swift
//  testePagSeguro
//
//  Created by Gabriel Sousa on 21/11/19.
//  Copyright © 2019 Gabriel Sousa. All rights reserved.
//

import Foundation
import UIKit

class LoginViewController: UIViewController {
    
    //****************************************************************
    //MARK: STORYBOARD OUTLETS
    //****************************************************************
    
    @IBOutlet var userTextField: UITextField!
    
    @IBOutlet var senhaTextField: UITextField!
    
    @IBOutlet var erroLabel: UILabel!
    
    
    //****************************************************************
    //MARK: CICLO DE VIDA
    //****************************************************************
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
    }
    
    
    //****************************************************************
    //MARK: LAYOUT
    //****************************************************************
    
    func mostrarMensagemErro(mensagem: String) {
        
        DispatchQueue.main.async {
            
            self.erroLabel.text = mensagem
                  
            self.erroLabel.isHidden = false
        }
  
    }
    
    
    
    //****************************************************************
    //MARK: STORYBOARD ACTIONS
    //****************************************************************
    
    @IBAction func entrarAction(_ sender: Any) {
        
        guard let usuario = userTextField.text else { return }
        
        guard let senha = senhaTextField.text else { return }
        
        DAO().login(usuario: usuario, senha: senha) { mensagem in
            
            if mensagem != "sucesso" {
                
                self.mostrarMensagemErro(mensagem: mensagem)
                
            } else {
                
                Segues.irParaTabBar(vc: self)
                
            }
            
            
            
        }
        
    }
    
}
