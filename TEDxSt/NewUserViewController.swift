//
//  NewUserViewController.swift
//  TEDxSt
//
//  Created by Vlad Lopes on 26/04/21.
//

import UIKit
import Firebase

class CreateUserViewController: UIViewController {

    @IBOutlet weak var vwMainView: UIView!
    
    @IBOutlet weak var txtUser: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassw1: UITextField!
    @IBOutlet weak var txtPassw2: UITextField!
    @IBOutlet weak var lblMessage: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
    
    func validateUserData() -> Bool {
        return true
    }
    
    @IBAction func bttCreate(_ sender: Any) {
        if validateUserData() {
            print(txtEmail.text!, txtPassw1.text!)
            Auth.auth().createUser(withEmail: txtEmail.text!, password: txtPassw1.text!) { authResult, error in
                if (error != nil) {
                    self.lblMessage.text = error?.localizedDescription
                } else {
                    print("adicional: ", authResult?.additionalUserInfo)
                }
            }
        }
        
        
            
    }
    
    @IBAction func bttBack(_ sender: Any) {
            dismiss(animated: true, completion: nil)
    }

}
