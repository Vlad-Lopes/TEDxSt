//
//  ScannerViewController.swift
//  TEDxSt
//
//  Created by Vlad Lopes on 11/03/21.
//

import AVFoundation
import UIKit

class ScannerViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    var captureSession: AVCaptureSession!
    var previewLayer: AVCaptureVideoPreviewLayer!

    @IBOutlet weak var vwMainView: UIView!
    @IBOutlet weak var vwScan: UIImageView!
    let myImage = UIImageView()
    var urlString = "" //"https://media-exp1.licdn.com/dms/image/C4D03AQFIakFOAfLGsQ/profile-displayphoto-shrink_800_800/0/1517513996327?e=1620864000&v=beta&t=1pcPsWMWadZN9tYDbE1NaIln3ZEw2Pm7TS-J93-F1lg")!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        vwMainView.layer.borderColor = CGColor(red: 255, green: 0, blue: 0, alpha: 1)
        vwMainView.layer.borderWidth = 3

        
        vwScan.backgroundColor = UIColor.black
        captureSession = AVCaptureSession()
        
//        let screenSize: CGRect = vwMainView.bounds
//        print("tamanho da view", screenSize)
//        let myView = UIView(frame: CGRect(x: 0, y: 0, width: screenSize.width - 10, height: 10))
       // self.view.addSubview(myView)

        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else { return }
        let videoInput: AVCaptureDeviceInput

        do {
            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
        } catch {
            return
        }

        if (captureSession.canAddInput(videoInput)) {
            captureSession.addInput(videoInput)
        } else {
            failed()
            return
        }

        let metadataOutput = AVCaptureMetadataOutput()

        if (captureSession.canAddOutput(metadataOutput)) {
            captureSession.addOutput(metadataOutput)

            metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            metadataOutput.metadataObjectTypes = [.qr]
        } else {
            failed()
            return
        }

        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.frame = vwScan.layer.bounds
        previewLayer.videoGravity = .resizeAspectFill
        vwScan.layer.addSublayer(previewLayer)

        captureSession.startRunning()
    }

    func failed() {
        let ac = UIAlertController(title: "Scanning not supported", message: "Your device does not support scanning a code from an item. Please use a device with a camera.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
        captureSession = nil
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if (captureSession?.isRunning == false) {
            captureSession.startRunning()
            vwScan.layer.addSublayer(previewLayer)
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        if (captureSession?.isRunning == true) {
            captureSession.stopRunning()
        }
    }

    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        captureSession.stopRunning()

        if let metadataObject = metadataObjects.first {
            guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
            guard let stringValue = readableObject.stringValue else { return }
            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))

            found(code: stringValue)
        }
   
//            dismiss(animated: true)

    }

    func found(code: String) {
        if (captureSession?.isRunning == true) {
            captureSession.stopRunning()
        }
       
 //           print(code)
        urlString = code
        
        let url = URL(string: code)!
        myImage.load(url: url)
        DispatchQueue.main.async {
            self.vwScan.layer.borderColor = UIColor.white.cgColor
            self.vwScan.layer.borderWidth = 1.5
            self.vwScan.image = self.myImage.image
        }
        
        previewLayer.removeFromSuperlayer()
        Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(changeScreen), userInfo: nil, repeats: false)

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SegueGrid" {
            let destination = segue.destination as! GridViewController
            destination.url = urlString
        }
    }
    
    @objc func changeScreen() {
        performSegue(withIdentifier: "SegueGrid", sender: nil)
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    @IBAction func bttBack(_ sender: Any) {

        dismiss(animated: true, completion: nil)
    }
   
}

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.main.async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                       
                        self?.image = image
                }
            }
        }
    }
}
