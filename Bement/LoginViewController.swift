//
//  LoginViewController.swift
//  Bement
//
//  Created by Runkai Zhang on 8/7/18.
//  Copyright © 2018 Numeric Design. All rights reserved.
//

import UIKit

struct Credentials {
    var username: String
    var password: String
}

enum KeychainError: Error {
    case noPassword
    case unexpectedPasswordData
    case unhandledError(status: OSStatus)
}

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var LoginButton: UIButton!
    
    @IBOutlet var SupportButton: UIButton!
    
    @IBOutlet var username: UITextField!
    
    @IBOutlet var password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tools.beautifulButton(LoginButton)
        tools.beautifulButton(SupportButton)
        username.delegate = self
        username.delegate = self
        
        let dictionary = Locksmith.loadDataForUserAccount(userAccount: "admin")
        let passwords = Locksmith.loadDataForUserAccount(userAccount: "admin-password")
        
        if dictionary != nil {
            print(dictionary!)
            print(passwords!)
            username.text = dictionary?["username"] as? String
            password.text = passwords?["password"] as? String
        }
        else {
            print("haahhahahahahah")
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == username {
            textField.resignFirstResponder()
            password.becomeFirstResponder()
        } else if textField == password {
            textField.resignFirstResponder()
            print("Done")
        }
        return true
    }
    
    @IBAction func login(_ sender: Any) {
        
        if username.text != "" {
            if username.text == "admin" {
                if password.text == "bementdeerfield" {
                    performSegue(withIdentifier: "admin", sender: self)
                    
                    if Locksmith.loadDataForUserAccount(userAccount: "admin") == nil {
                        do {
                            
                            try Locksmith.saveData(data: ["username": "admin"], forUserAccount: "admin")
                            try Locksmith.saveData(data: ["password": "bementdeerfield"], forUserAccount: "admin-password")
                            print("saved")
                        } catch {
                            print("A error appeared")
                            print("First: \(error)")
                        }
                    } else {
                        do {
                            try Locksmith.updateData(data: ["username": "admin"], forUserAccount: "admin", inService: "error fixing")
                            try Locksmith.updateData(data: ["password": "bementdeerfield"], forUserAccount: "admin-password", inService: "error fixing")
                        } catch {
                            print(error)
                        }
                    }
                }
                else {
                    let alert = UIAlertController(title: "Access Denied", message: "A admin need a password", preferredStyle: .alert)
                    let sorry = UIAlertAction(title: "Sorry", style: .cancel, handler: nil)
                    alert.addAction(sorry)
                    present(alert, animated: true, completion: nil)
                }
            }
            else {
                
            }
        }
        else {
            let alert = UIAlertController(title: "I can't see!", message: "The Username field can't be empty!", preferredStyle: .alert)
            let dismiss = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
            alert.addAction(dismiss)
            present(alert, animated: true, completion: nil)
        }
    }
}
