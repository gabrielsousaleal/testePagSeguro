//
//  Segues.swift
//  testePagSeguro
//
//  Created by Gabriel Sousa on 21/11/19.
//  Copyright © 2019 Gabriel Sousa. All rights reserved.
//

import Foundation
import UIKit

class Segues {
    
    static func irParaTabBar(vc: UIViewController){
        
        DispatchQueue.main.async {
            
            let storyboard = UIStoryboard(name: "TabBarControllerStoryboard", bundle: nil)
            
            let tabbarcontroller = storyboard.instantiateViewController(identifier: "tabBarController") as! TabBarController
            
            vc.present(tabbarcontroller, animated: true)
            
        }
    
    }
    
    static func irParaLogin(vc: UIViewController) {
        
        DispatchQueue.main.async {
            
            let storyboard = UIStoryboard(name: "LoginStoryboard", bundle: nil)
            
            let tabbarcontroller = storyboard.instantiateViewController(identifier: "loginStoryboard") as! TabBarController
            
            vc.present(tabbarcontroller, animated: true)
            
        }
        
    }
    
}
