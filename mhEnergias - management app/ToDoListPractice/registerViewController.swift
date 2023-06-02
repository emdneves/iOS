//
//  registerViewController.swift
//  toDoApp
//
//  Created by MultiLab PRT on 19/05/2023.
//

import UIKit
import Firebase
import CoreData

class registerViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
        
    
    @IBAction func registerClicked(_ sender: UIButton) {
        guard let email = usernameTextField.text else {return }
        guard let password = passwordTextField.text else {return }

        Auth.auth().createUser(withEmail: email, password: password) {firebaseResult, error in if let e = error {
            print("error")
            let alert = UIAlertController(title: "ERRO", message: "Email Already Registered", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)

        }
            else {
                self.performSegue(withIdentifier: "toLoginVC", sender: self)
                
            }
            
            
        }
        
    }
}
 
    
    
    

   

