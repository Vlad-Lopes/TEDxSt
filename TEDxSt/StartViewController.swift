//
//  ViewController.swift
//  TEDxSt
//
//  Created by Vlad Lopes on 10/03/21.
//

import UIKit
import Firebase

class StartViewController: UIViewController {

    @IBOutlet weak var vwMainView: UIView!
    
 //   var handle = Auth.auth()
    
  //  var timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        vwMainView.layer.borderColor = CGColor(red: 255, green: 0, blue: 0, alpha: 1)
        vwMainView.layer.borderWidth = 3
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(3000)) {
                    self.performSegue(withIdentifier: "LoginSegue", sender: nil)
                }
        
    }

}

