//
//  loginViewController.swift
//  toDoApp
//
//  Created by MultiLab PRT on 12/05/2023.
//

import UIKit
import Firebase
import CoreData

class loginViewController: UIViewController {
    

    @IBOutlet weak var usernameTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    
    override func viewDidLoad() {
            super.viewDidLoad()
        }
    
    
    @IBAction func loginCliked(_ sender: UIButton) {
          guard let email = usernameTextField.text, !email.isEmpty else {
              displayAlert(message: "Please enter your email.")
              return
          }
          
          guard let password = passwordTextField.text, !password.isEmpty else {
              displayAlert(message: "Please enter your password.")
              return
          }
          
          Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
              if let error = error {
                  print("Error logging in: \(error.localizedDescription)")
                  self?.displayAlert(message: "Invalid login. Please check your credentials.")
              } else {
                  self?.performSegue(withIdentifier: "goToProgram", sender: email)
              }
          }
      }
      
      override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
          if segue.identifier == "goToProgram",
             let email = sender as? String,
             let programVC = segue.destination as? ToDoListController {
              programVC.receivedName = email
          }
      }
      
      private func displayAlert(message: String) {
          let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
          alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
          present(alert, animated: true, completion: nil)
      }
  }
    
    
    
    
    
    
    


