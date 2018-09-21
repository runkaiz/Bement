//
//  LoginViewController.swift
//  Bement
//
//  Created by Runkai Zhang on 8/7/18.
//  Copyright © 2018 Numeric Design. All rights reserved.
//

import UIKit
import LocalAuthentication

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
    
    @IBOutlet var stackView: UIStackView!
    
    @IBOutlet var logoTop: NSLayoutConstraint!
    
    let dictionary = Locksmith.loadDataForUserAccount(userAccount: "admin")
    let passwords = Locksmith.loadDataForUserAccount(userAccount: "admin-password")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tools.beautifulButton(LoginButton)
        tools.beautifulButton(SupportButton)
        username.delegate = self
        password.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        if dictionary?["username"] != nil {
            
            if globalVariable.firstTimeIndicator == false {
                authenticateUserTouchID()
                globalVariable.firstTimeIndicator = true
            }
        }
    }
    
    @IBAction func done(_ segue: UIStoryboardSegue) {
        //print("Popping back to this view controller!")
        // reset UI elements etc here
    }
    
    @IBAction func support(_ sender: Any) {
        globalVariable.firstTimeIndicator = true
    }
    
    func authenticateUserTouchID() {
        let context : LAContext = LAContext()
        // Declare a NSError variable.
        let message = NSLocalizedString("touchIdMessage", comment: "")
        let accountName = dictionary?["username"] as? String
        let ending = "」"
        let messageFull = message + accountName! + ending
        
        let myLocalizedReasonString = messageFull
        var authError: NSError?
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &authError) {
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: myLocalizedReasonString) { success, evaluateError in
                if success // IF TOUCH ID AUTHENTICATION IS SUCCESSFUL, NAVIGATE TO NEXT VIEW CONTROLLER
                {
                    DispatchQueue.main.async {
                        self.username.text = self.dictionary?["username"] as? String
                        self.password.text = self.passwords?["password"] as? String
                    }
                }
                else // IF TOUCH ID AUTHENTICATION IS FAILED, PRINT ERROR MSG
                {
                    if let error = evaluateError {
                        let message = self.showErrorMessageForLAErrorCode(error._code)
                        print(message)
                    }
                }
            }
        }
    }
    
    
    
    func showErrorMessageForLAErrorCode(_ errorCode:Int ) -> String {
        
        var message = ""
        
        switch errorCode {
            
        case LAError.appCancel.rawValue:
            message = "Authentication was cancelled by application"
            
        case LAError.authenticationFailed.rawValue:
            message = "The user failed to provide valid credentials"
            
        case LAError.invalidContext.rawValue:
            message = "The context is invalid"
            
        case LAError.passcodeNotSet.rawValue:
            message = "Passcode is not set on the device"
            
        case LAError.systemCancel.rawValue:
            message = "Authentication was cancelled by the system"
            
        case LAError.biometryLockout.rawValue:
            message = "Too many failed attempts."
            
        case LAError.biometryNotAvailable.rawValue:
            message = "TouchID is not available on the device"
            
        case LAError.userCancel.rawValue:
            message = "The user did cancel"
            
        case LAError.userFallback.rawValue:
            message = "The user chose to use the fallback"
            
        default:
            message = "Did not find error code on LAError object"
            
        }
        
        return message
        
    }
    
    @objc func keyboardWillShow(notification:NSNotification) {
        
        if let info = notification.userInfo {
            
            let rect:CGRect = info["UIKeyboardFrameEndUserInfoKey"] as! CGRect
            
            self.view.layoutIfNeeded()
            
            UIView.animate(withDuration: 0.25, animations: {
                
                self.view.layoutIfNeeded()
                self.stackView.frame.origin.y = rect.height - 100
                self.logoTop.constant -= 100
            })
            
        }
    }
    
    @objc func keyboardWillHide(notification:NSNotification) {
        
        self.view.layoutIfNeeded()
            
        UIView.animate(withDuration: 0.25, animations: {
                
            self.view.layoutIfNeeded()
            self.stackView.frame.origin.y = 231
            self.logoTop.constant = 0
        })
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == username {
            textField.resignFirstResponder()
            password.becomeFirstResponder()
            self.view.layoutIfNeeded()
            
            UIView.animate(withDuration: 0.25, animations: {
                
                self.view.layoutIfNeeded()
                self.stackView.frame.origin.y = 231
                self.logoTop.constant = 0
            })
        } else if textField == password {
            textField.resignFirstResponder()
        }
        return true
    }
    
    @IBAction func login(_ sender: Any) {
        
        if username.text != "" {
            if username.text == "admin" {
                if password.text == "bementdeerfield" {
                    
                    DispatchQueue.main.async {
                        self.performSegue(withIdentifier: "admin", sender: self)
                    }
                    
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
                    let alert = UIAlertController(title: NSLocalizedString("AD", comment: ""), message: NSLocalizedString("AdminNoPassword", comment: ""), preferredStyle: .alert)
                    let sorry = UIAlertAction(title: NSLocalizedString("sorry", comment: ""), style: .cancel, handler: nil)
                    alert.addAction(sorry)
                    present(alert, animated: true, completion: nil)
                }
            }
            else {
                
                if password.text != "" {
                    
                } else {
                    
                    let alert = UIAlertController(title: NSLocalizedString("noText", comment: ""), message: NSLocalizedString("NoPassword", comment: ""), preferredStyle: .alert)
                    let dismiss = UIAlertAction(title: NSLocalizedString("ok", comment: ""), style: .cancel, handler: nil)
                    alert.addAction(dismiss)
                    present(alert, animated: true, completion: nil)
                }
            }
        }
        else {
            let alert = UIAlertController(title: NSLocalizedString("noText", comment: ""), message: NSLocalizedString("NoUsername", comment: ""), preferredStyle: .alert)
            let dismiss = UIAlertAction(title: NSLocalizedString("ok", comment: ""), style: .cancel, handler: nil)
            alert.addAction(dismiss)
            present(alert, animated: true, completion: nil)
        }
    }
}
