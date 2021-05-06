//
//  MainViewController.swift
//  TEDxSt
//
//  Created by Vlad Lopes on 10/03/21.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var vwMainView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        vwMainView.layer.borderColor = CGColor(red: 255, green: 0, blue: 0, alpha: 1)
        vwMainView.layer.borderWidth = 3

        // Do any additional setup after loading the view.
    }
    
    @IBAction func bttBack(_ sender: Any) {
            dismiss(animated: true, completion: nil)
    }
    
   
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
