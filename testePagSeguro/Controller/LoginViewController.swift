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
        
        esconderTeclado()
            
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
        
        if usuario.count == 0 {
            
            mostrarMensagemErro(mensagem: "Digite o seu e-mail")
            
            return
            
        }
        
        if senha.count == 0 {
            
            mostrarMensagemErro(mensagem: "Digite a sua senha")
            
            return
            
        }
        
        DAO().login(usuario: usuario, senha: senha) { usuario, erro in
            
            if erro == nil {
                
                Segues.irParaTabBar(vc: self)
                
            } else {
                
                self.mostrarMensagemErro(mensagem: erro!)
                
            }
   
        }
        
    }
    
}


//MARK: ESCONDER TECLADO

extension LoginViewController {
    
    func esconderTeclado() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dispensarTeclado))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dispensarTeclado() {
        view.endEditing(true)
    }
}
