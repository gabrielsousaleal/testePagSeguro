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
    
    @IBOutlet var nomeUsuarioLabel: UILabel!
    
    @IBOutlet var saldoLabel: UILabel! 
    
    @IBOutlet var botoesCollectionView: UICollectionView!
    
    //****************************************************************
    //MARK: VARIAVEIS
    //****************************************************************
    
    var usuario: Usuario!
    
    
    
    //****************************************************************
    //MARK: CICLO DE VIDA
    //****************************************************************
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController!.navigationBar.isHidden = true
        
        setarDelegates()
        
        setarLayoutCells()
                
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        pegarUsuarioUserDefaults()
        
        nomeUsuarioLabel.text = usuario.name
        
        pegarSaldo()
        
        recarregarCollectionViewBotoes()
        
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
        
        //SE O USUARIO FOR NIL, VOLTAR PARA A TELA DE LOGIN
        guard let usuario = DAO().pegarUsuarioUserDefaults() else {
            
            Segues.irParaLogin(vc: self)
            
            return
            
        }
        
        self.usuario = usuario
                
    }
    
    func pegarSaldo(){
                
        //SE HOUVER ERRO, MOSTRAR O ERRO,
        //SE NÃO HOUVER, MOSTRAR O SALDO
        DAO().pegarSaldo(usuario: usuario) { saldo, erro in
            
            if erro != nil {
                
                self.mostrarErroSaldo(erro: erro!)
                
            } else {
                
                self.popularSaldo(saldo: saldo!)
                
            }
            
        }
        
    }
    
    
    //****************************************************************
    //MARK: LAYOUT
    //****************************************************************

    
    func popularSaldo(saldo: String){
        
        DispatchQueue.main.async {
        
        var saldoString: String!

        saldoString = Helper.formatarStringParaMoeda(valor: saldo)

        self.saldoLabel.text = saldoString
            
        }
        
    }
    
    func mostrarErroSaldo(erro: String) {
        
        DispatchQueue.main.async {
            
            self.saldoLabel.text = erro
            
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
    
    func recarregarCollectionViewBotoes(){
                
        recarregarCollectionView()
        
    }
    
    //****************************************************************
    //MARK: STORYBOARD ACTIONS
    //****************************************************************
    
    @IBAction func sair(_ sender: Any) {
        
        DAO().deletarUsuarioUserDefaults()
        
        Segues.irParaLogin(vc: self)
        
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
        
        let viewController = botaoObj.viewController!
        
        navigationController?.pushViewController(viewController, animated: true)
        
    }
    
    
}
