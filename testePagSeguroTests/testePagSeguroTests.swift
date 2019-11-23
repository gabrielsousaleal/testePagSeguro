//
//  testePagSeguroTests.swift
//  testePagSeguroTests
//
//  Created by Gabriel Sousa on 21/11/19.
//  Copyright © 2019 Gabriel Sousa. All rights reserved.
//

import XCTest
@testable import testePagSeguro

class testePagSeguroTests: XCTestCase {
    
    var dao: DAO!
    
    var usuarioTeste: Usuario!
    
    var loginTeste: String!
    
    var senhaTeste: String!

    override func setUp() {
       
        dao = DAO()
        
        usuarioTeste = Usuario(name: "Ian Hugo Cauê Galvão",
                               email: "ianhugocauegalvao@teste.com.br",
                               ddd: "11", token: "9djow346-dd33-44e7-a339-9jjdleo9se33",
                               phoneNumber: "*****-6543", document: "3**.***.**8-10",
                               _id: 100,
                               toggles: ["transfer", "payment", "cell_recharge", "loan"])
        
        loginTeste = "sucesso@mail.com"
        
        senhaTeste = "654321"
        
        
    }
    
    //****************************************************************
    //MARK: TESTES DAO
    //****************************************************************
    
    func testePegarExtrato() {
        
        //A FUNCAO FAZ A REQUISICAO DO EXTRATO PARA A API E RETORNA UM ARRAY DO TIPO EXTRATO
        
        let exp = expectation(description: "Pegar Extrato")
        
        var extrato: [Extrato] = []
                        
        dao.pegarExtrato(usuario: usuarioTeste) { resultado, erro in
            
            if erro != nil {
                
                XCTFail(erro!)
                                
            } else {
                
                print(resultado)
                
                extrato = resultado
                
                exp.fulfill()
            }
            
            
            
        }
        
        waitForExpectations(timeout: 10) { error in
            
                   if let error = error {
                       XCTFail("waitForExpectationsWithTimeout errored: \(error)")
                   }
                   print("Total de resultados -> ", extrato.count)
                   XCTAssertLessThan(0, extrato.count)
               }

    }
    
    func testeLogin() {
        
        //A FUNCAO FAZ A REQUISICAO DO USUARIO PARA A API, E SETA O USUARIO NO USERDDEFAULTS, RETORNANDO O USUARIO OU UM ERRO
        
        let exp = expectation(description: "Logar")
             
        var mensagemErro: String?
        
        dao.login(usuario: loginTeste, senha: senhaTeste) { usuario, erro in
            
            mensagemErro = erro
            
            exp.fulfill()
                        
        }
        
        waitForExpectations(timeout: 10) { error in
                   
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }
                    
            //SE RETORNAR ERRO NIL, A FUNCAO OBTEVE SUCESSO
            XCTAssert(mensagemErro == nil)
        }
        
    }
    
    func testePegarSaldo() {
        
        var saldo: String?
                
        let exp = expectation(description: "Pegar Saldo")
        
        dao.pegarSaldo(usuario: usuarioTeste) { resultado, erro in
            
            if erro != nil {
                
                XCTFail(erro!)
                
            } else {
                
                saldo = resultado
                           
                exp.fulfill()
                
            }
 
        }
        
        waitForExpectations(timeout: 10) { error in
                   
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }
                        
            //SE O SALDO FOR DIFERENTE DE NIL, A FUNCAO OBTEVE SUCESSO
            XCTAssert(saldo != nil)
        }
        
    }
    

}
