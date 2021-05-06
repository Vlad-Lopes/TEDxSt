//
//  AboutViewController.swift
//  TEDxSt
//
//  Created by Vlad Lopes on 13/03/21.
//

import UIKit

class AboutViewController: UIViewController {

    @IBOutlet weak var vwMainView: UIView!
    @IBOutlet weak var lblAbout: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        vwMainView.layer.borderColor = CGColor(red: 255, green: 0, blue: 0, alpha: 1)
        vwMainView.layer.borderWidth = 3
        
        lblAbout.text = "TEDx Stockholm\n\n\n This is the 'About' screen of this app.\n When we must include all the information we believe important or necessary about this app, how it's work and who made it.\n Must be used to show another information too."

        // Do any additional setup after loutoading the view.
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
