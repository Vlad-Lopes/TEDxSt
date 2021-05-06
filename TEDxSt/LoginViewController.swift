//
//  LoginViewController.swift
//  TEDxSt
//
//  Created by Vlad Lopes on 26/04/21.
//

import UIKit
import Firebase

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var vwMainView: UIView!
    
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var lblMessage: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        vwMainView.layer.borderColor = CGColor(red: 255, green: 0, blue: 0, alpha: 1)
        vwMainView.layer.borderWidth = 3
        
        // To permit that keyboard be disable
        self.txtEmail.delegate = self
        self.txtPassword.delegate = self
        
        
//        Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(changeScreen), userInfo: nil, repeats: false)
//
//        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(3000)) {
//                    self.performSegue(withIdentifier: "MainSegue", sender: nil)
//                }
        // Do any additional setup after loading the view.
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
    
    
    func validateUser() -> Bool {
    
        if let email = txtEmail.text {
            if email == "" {
                lblMessage.text = "Please, inform your email."
                return false
            } else if !isValidEmail(email) {
                lblMessage.text = "Please inform the email in a valid format."
                return false
            }
        }
        
        if let password = txtPassword.text {
            if password == "" {
                lblMessage.text = "Please, inform the password."
                return false
            } else if password.count < 6 {
                lblMessage.text = "Password must have at least 6 characters."
                return false
            }
        }
       
        return true
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }

    @IBAction func bttLogin(_ sender: UIButton) {
        if validateUser() {
            if let email = txtEmail.text, let password = txtPassword.text {
                print("Email: ", email, "  Password: ", password)
                Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
                  guard let strongSelf = self else { return }
                    if (error != nil) {
                        strongSelf.lblMessage.text = error?.localizedDescription
                    } else {
                        strongSelf.performSegue(withIdentifier: "MainSegue", sender: nil)
                    }
                }
            }
        }
    }
    
    @IBAction func bttNewUser(_ sender: UIButton) {
        performSegue(withIdentifier: "CreateUserSegue", sender: nil)
    }
    
}
