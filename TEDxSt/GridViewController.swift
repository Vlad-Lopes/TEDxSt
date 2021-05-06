//
//  GridViewController.swift
//  TEDxSt
//
//  Created by Vlad Lopes on 11/03/21.
//

import UIKit

class GridViewController: UIViewController {

    @IBOutlet weak var vwMainView: UIView!
    @IBOutlet var imgPicture: [UIImageView]!
    
    @IBOutlet weak var lblMessage: UILabel!
    
    var url = ""
    
    var urlImages: [String] = []
    var storedImages = UserDefaults.standard
    var myImage = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        vwMainView.layer.borderColor = CGColor(red: 255, green: 0, blue: 0, alpha: 1)
        vwMainView.layer.borderWidth = 3
        // Do any additional setup after loading the view.
        
        urlImages = storedImages.array(forKey: "ImageUrl") as? [String] ?? [String]()
       
        setImage(urlString: url)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        storedImages.set(urlImages, forKey: "ImageUrl")
    }
    

    func setImage(urlString: String) {
        
        let ind = urlImages.count
        
        if urlString != "" && ind <= 8 {
            urlImages.append(urlString)
        }
           
        for i in 0..<urlImages.count {
            if urlImages[i] != "" {
                myImage.load(url: URL(string: urlImages[i])!)
                DispatchQueue.main.async {
                    self.imgPicture[i].image = self.myImage.image
                    self.imgPicture[i].alpha = 1
                    self.imgPicture[i].layer.borderWidth = 1
                    self.imgPicture[i].layer.borderColor = UIColor.white.cgColor
                }
            }
            
        }
        
        if ind >= 7 {
            lblMessage.text = "\"Don't let Yesterday take up Too Much of Today.\"\nWill Rogers"
        }
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func bttClean(_ sender: Any) {
        urlImages = []
 
        storedImages.set(urlImages, forKey: "ImageUrl")
    }
    
    @IBAction func bttBack(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
