//
//  TedxViewController.swift
//  TEDxSt
//
//  Created by Vlad Lopes on 13/03/21.
//

import UIKit

class TedxViewController: UIViewController {

    @IBOutlet weak var vwMainView: UIView!
    @IBOutlet weak var lblTedx: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        vwMainView.layer.borderColor = CGColor(red: 255, green: 0, blue: 0, alpha: 1)
        vwMainView.layer.borderWidth = 3
        
        lblTedx.text = "TEDx Stockholm\n\n\n This is the 'TEDx' screen of this app.\n When we must include all the information about the TEDx, programimng, sponsors, speachers, next events or something else.\n Must be used to show another information too."

    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func bttBack(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
