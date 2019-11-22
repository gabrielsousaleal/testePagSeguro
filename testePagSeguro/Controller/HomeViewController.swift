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
    
    @IBOutlet var botoesCollectionView: UICollectionView!
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
        
        navigationController!.navigationBar.isHidden = true
        
        pegarUsuarioUserDefaults()
        
        setarDelegates()
        
        setarLayoutCells()
            
        pegarSaldo()
        
        pegarToggles()
                
    }
    
    //****************************************************************
    //MARK: DELEGATES
    //****************************************************************
    
    func setarDelegates(){
        
        botoesCollectionView.delegate = self
        
        botoesCollectionView.dataSource = self
        
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
    
    func recarregarCollectionView() {
        
        DispatchQueue.main.async {
            
            self.botoesCollectionView.reloadData()
            
        }
        
    }
    
    func setarLayoutCells(){
        
        let screen = UIScreen.main.bounds
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 20, bottom: 10, right: 20)
        layout.itemSize = CGSize(width: screen.width/2.6, height: screen.width/2.6)
        layout.minimumInteritemSpacing = 1
        layout.minimumLineSpacing = 40
        
        
        botoesCollectionView.collectionViewLayout = layout
        
    }
    
    //****************************************************************
    //MARK: LÓGICA
    //****************************************************************
    
    func pegarToggles(){
        
        listaToggles = usuario.toggles
        
        recarregarCollectionView()
        
    }
    
    
}


//****************************************************************
//MARK: COLLECTION VIEW DELEGATE
//****************************************************************

extension HomeViewController: UICollectionViewDelegate {
    
}


//****************************************************************
//MARK: COLLECTION VIEW DATA SOURCE
//****************************************************************

extension HomeViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return usuario.toggles.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
                
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "homeBotaoCell", for: indexPath) as! HomeBotaoCell
        
        let row = indexPath.row
        
        let botao = usuario.toggles[row]
        
        cell.configurarCell(botao: botao)
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let row = indexPath.row
        
        let botao = usuario.toggles[row]
        
        let botaoObj = Botao(botao: botao)
        
        let viewController = botaoObj.viewController
        
        //CHAMAR AQUI A VIEW CONTROLLER
        
        
    }
    
    
}
