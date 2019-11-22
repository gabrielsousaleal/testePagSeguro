//
//  ExtratoViewController.swift
//  testePagSeguro
//
//  Created by Gabriel Sousa on 21/11/19.
//  Copyright © 2019 Gabriel Sousa. All rights reserved.
//

import Foundation
import UIKit

class ExtratoViewController: UIViewController {
    
    //****************************************************************
    //MARK: STORYBOARD OUTLETS
    //****************************************************************
    
    @IBOutlet var extratoTableView: UITableView!
    
    //****************************************************************
    //MARK: VARIAVEIS
    //****************************************************************
    
    var usuario: Usuario?
    
    var extrato: [Extrato] = []
    
    var refresh: UIRefreshControl = UIRefreshControl()
    
    
    //****************************************************************
    //MARK: CICLO DE VIDA
    //****************************************************************
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setarDelegates()
        
        pegarUsuarioUserDefaults()
        
        pegarExtrato()
        
    }
    
    //****************************************************************
    //MARK: DELEGATES
    //****************************************************************
    
    func setarDelegates() {
        
        extratoTableView.delegate = self
        
        extratoTableView.dataSource = self
        
        configurarTableViewRefresh()
        
    }
    
    //****************************************************************
    //MARK: REFRESH CONTROL
    //****************************************************************
    
    func configurarTableViewRefresh() {
        
        refresh.addTarget(self, action: #selector(pegarExtrato), for: .valueChanged)
        
        refresh.tintColor = #colorLiteral(red: 1, green: 0.262745098, blue: 0.5921568627, alpha: 1)
        
        extratoTableView.refreshControl = refresh
        
    }
    
    
    //****************************************************************
    //MARK: REQUISICOES DAO
    //****************************************************************
    
    func pegarUsuarioUserDefaults() {
        
     guard let usuario = DAO().pegarUsuarioUserDefaults() else {
         
         Segues.irParaLogin(vc: self)
         
         return
         
     }
     
     self.usuario = usuario
        
    }
    
    func recarregarTableView(extratoNovo: [Extrato]) {
        
        DispatchQueue.main.async {
            
            self.extrato = extratoNovo
            
            self.extratoTableView.refreshControl?.endRefreshing()
            
            self.extratoTableView.reloadData()
            
        }
        
    }
    
    @objc func pegarExtrato() {
        
        guard let usuario = usuario else { return }
        
        DAO().pegarExtrato(usuario: usuario) { extrato in
        
            self.recarregarTableView(extratoNovo: extrato)
            
        }
        
    }
    
    
}

   //****************************************************************
   //MARK: TABLE VIEW DELEGATE
   //****************************************************************
   

extension ExtratoViewController: UITableViewDelegate {
    
    
}

   //****************************************************************
   //MARK: TABLE VIEW DATA SOURCE
   //****************************************************************
   

extension ExtratoViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return extrato.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "extratoCell") as! ExtratoCell
        
        let row = indexPath.row
        
        let gasto = extrato[row]
        
        cell.configurarCell(extrato: gasto)
        
        return cell
        
    }
    
}
