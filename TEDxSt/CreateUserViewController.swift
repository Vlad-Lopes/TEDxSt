//
//  NewUserViewController.swift
//  TEDxSt
//
//  Created by Vlad Lopes on 26/04/21.
//

import UIKit
import Firebase

class CreateUserViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var vwMainView: UIView!
    
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassw1: UITextField!
    @IBOutlet weak var txtPassw2: UITextField!
    @IBOutlet weak var lblMessage: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // To permit the keyboar to de disabled
        self.txtEmail.delegate = self
        self.txtPassw1.delegate = self
        self.txtPassw2.delegate = self
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    // To disable the keyboard whith Return or touching on the screen
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func validateUserData() -> Bool {
    
        if let email = txtEmail.text {
            if email == "" {
                lblMessage.text = "The email is required to create a new user."
                return false
            } else if !isValidEmail(email) {
                lblMessage.text = "Please inform the email in a valid format."
                return false
            }
        }
        
        if let password = txtPassw1.text {
            if password == "" {
                lblMessage.text = "Password is required to create a new user."
                return false
            } else if password.count < 6 {
                lblMessage.text = "Password must have at least 6 characters."
                return false
            } else {
                if txtPassw2.text == ""{
                    lblMessage.text = "Please, confirm the password."
                    return false
                } else {
                    if txtPassw1.text != txtPassw2.text {
                        lblMessage.text = "Confirmed password doesn't match with the password."
                        return false
                    }
                }
            }
        }
       
        return true
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    @IBAction func bttCreate(_ sender: Any) {
        if validateUserData() {
            lblMessage.text = ""
            Auth.auth().createUser(withEmail: txtEmail.text!, password: txtPassw1.text!) { authResult, error in
                if (error != nil) {
                    self.lblMessage.text = error?.localizedDescription
                } else {
                    self.lblMessage.text = "New user was created, return and do the login"
                }
            }
        }
        
        
            
    }
    
    @IBAction func bttBack(_ sender: Any) {
            dismiss(animated: true, completion: nil)
    }

}
