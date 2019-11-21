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
    
    func login(usuario: String, senha: String, completion: @escaping (String) -> () ){
        
        enum erroLogin: Error {
            case usuarioInválido
            case erroJson
        }
        
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
                        
                        completion("sucesso")
                        
                    } catch {
                        
                        print(error)
                        
                        completion("Erro no sistema, tente mais tarde")
                        
                    }
                     
                   }
                    
                 } else {
                    
                    print(error ?? "Unknown error")
                    
                    completion("Usuário não encontrado")
                   
                   
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
    
}
