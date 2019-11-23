//
//  DAO.swift
//  testePagSeguro
//
//  Created by Gabriel Sousa on 21/11/19.
//  Copyright © 2019 Gabriel Sousa. All rights reserved.
//

import Foundation


class DAO {
    
    //****************************************************************
    //MARK: API
    //****************************************************************
    
    func login(usuario: String, senha: String, completion: @escaping (Usuario?, String?) -> () ){
        
        let url = URL(string: "https://private-anon-b10352fce4-tqi.apiary-mock.com/auth")!
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        request.httpBody = """
        "{\n  \"userName\": \"\(usuario)",\n  \"password\": \"\(senha)\"\n}"
        """.data(using: .utf8)

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
                
        if response != nil {
                    
            if let data = data {
                    
                do {
                                
                    let json = try JSONDecoder().decode(Usuario.self, from: data)
                         
                    self.salvarUsuarioUserDefaults(usuario: json)
                        
                    completion(json, nil)
                        
                } catch {
                        
                    print(error)
                        
                    completion(nil, "Erro ao decodificar json.")
                        
                  }
                     
            }
                    
        } else {
                    
            print(error ?? "Unknown error")
                    
            completion(nil, "Usuário não encontrado")
                   
           }
            
        }

        task.resume()
               
               
        
    }
    
    func pegarSaldo(usuario: Usuario, completion: @escaping (String?, String?) -> () ) {
        
        let id = usuario._id
        
        let token = usuario.token
        
        let url = URL(string: "https://private-anon-b10352fce4-tqi.apiary-mock.com/balances?id=\(id)")!
        
        var request = URLRequest(url: url)
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        request.addValue("\(token)", forHTTPHeaderField: "Token")

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            if response != nil {
                
            if let data = data {
                
                do {
                    
                    let json = try JSONDecoder().decode(Saldo.self, from: data)
                    
                    completion(json.balance, nil)
                    
                } catch {
                    
                    completion(nil, "Erro ao decodificar json.")
                    
                }
               
            }
                
          } else {
                
            print(error ?? "Unknown error")
            completion(nil, "Erro ao retornar o saldo.")
                
          }
        }

        task.resume()
        
    }
    
    func pegarExtrato(usuario: Usuario, completion: @escaping ([Extrato], String?) -> ()) {
        
        let id = usuario._id
        
        let token = usuario.token
        
        let url = URL(string: "https://private-anon-b10352fce4-tqi.apiary-mock.com/transactions/?id=\(id)")!
        
        var request = URLRequest(url: url)
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        request.addValue("\(token)", forHTTPHeaderField: "Token")

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if response != nil {

                if let data = data {
              
                do {
                    
                    let json = try JSONDecoder().decode([Extrato].self, from: data)
                    
                    completion(json, nil)
                    
                } catch {
                    
                    print(error)
                    
                    completion([], "Erro ao decodificar json.")
                    
                }
                
            }
          } else {
            
            print(error ?? "Unknown error")
            
            completion([], "Erro ao retornar extrato.")
            
          }
        }

        task.resume()
        
    }

    
    //****************************************************************
    //MARK: USER DEFAULTS
    //****************************************************************
    
    func salvarUsuarioUserDefaults(usuario: Usuario){
        
        UserDefaults.standard.set(try? PropertyListEncoder().encode(usuario), forKey:"usuario")
                
    }
    
    func pegarUsuarioUserDefaults() -> Usuario? {
     
        if let data = UserDefaults.standard.value(forKey:"usuario") as? Data {
            
            let usuario = try? PropertyListDecoder().decode(Usuario.self, from: data)
            
            return usuario
        }
        
        return nil
        
    }
    
    func deletarUsuarioUserDefaults(){
        
        UserDefaults.standard.set(nil, forKey:"usuario")
        
    }
    
}
