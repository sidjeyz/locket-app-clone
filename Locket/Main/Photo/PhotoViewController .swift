//
//  PhotoViewController .swift
//  Locket
//
//  Created by Сулейман on 26.02.2025.
//

import Foundation
import UIKit
import AVFoundation

class PhotoViewController: UIViewController{
    
    @IBOutlet weak var messageButton: UIButton!
    
    @IBOutlet weak var takePhotoButton: UIButton!
    
    @IBOutlet weak var cameraView: UIView!
    
    @IBOutlet weak var myCustomButton: MyCustomImageButton!
    
    @IBOutlet weak var flash: MyCustomImageButton!
    
    @IBOutlet weak var cameraRotation: MyCustomImageButton!
    
    @IBOutlet weak var profileButton: UIButton!
    
    @IBOutlet weak var downButton: UIButton!
    
    @IBOutlet weak var storyLabel: UILabel!
    
    @IBOutlet weak var storyButton: UIButton!
    
    @IBOutlet weak var storyView: UIView!
    
    @IBOutlet weak var addFriendButton: UIButton!
    
    var captureSession: AVCaptureSession?
    var captureDevice: AVCaptureDevice?
    var currentFlashMode: AVCaptureDevice.FlashMode = .off
    var previewLayer: AVCaptureVideoPreviewLayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cameraRotation.image.image = UIImage(named: "cameraRotation")
        flash.image.image = UIImage(named: "flash")
        
        cameraRotation.onTap = {
            print("cameraRotation вкл")
        }
        
        flash.onTap = {
            print("flash вкл")
        }
        
        cameraView.layer.cornerRadius = 56
        cameraView.clipsToBounds = true
        
        messageButton.layer.cornerRadius = messageButton.frame.size.width/2
        messageButton.clipsToBounds = true
        messageButton.isEnabled = true
        
        profileButton.layer.cornerRadius = profileButton.frame.size.width/2
        profileButton.clipsToBounds = true
        profileButton.isEnabled = true
        
        takePhotoButton.layer.cornerRadius = takePhotoButton.frame.size.width/2
        takePhotoButton.clipsToBounds = true
        takePhotoButton.layer.borderColor = UIColor.orange.cgColor
        takePhotoButton.layer.borderWidth = 4
        takePhotoButton.isEnabled = true
        
        addFriendButton.layer.cornerRadius = addFriendButton.frame.size.height/2
        addFriendButton.clipsToBounds = true
        addFriendButton.isEnabled = true
        
        storyButton.layer.cornerRadius = storyButton.frame.size.width/2
        storyButton.clipsToBounds = true
        storyButton.isEnabled = false
        
        checkCameraAuthorization()
        setupCamera()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationItem.hidesBackButton = true
        
    }
    
    func checkCameraAuthorization() {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
            
        case .authorized:
            print("Разрешение на использование камеры уже предоставлено.")
            setupCamera()
            
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { granted in
                if granted {
                    print("Разрешение на использование камеры предоставлено.")
                } else {
                    print("Разрешение на использование камеры отклонено.")
                }
            }
            
        case .denied:
            print("Разрешение на использование камеры было отклонено.")
            
        case .restricted:

            print("Доступ к камере ограничен.")
            
        @unknown default:
            fatalError("Неизвестный статус авторизации.")
        }
    }
    
    
    func setupCamera() {

        captureSession = AVCaptureSession()
        
        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else { return }
        let videoInput: AVCaptureDeviceInput
        
        do {
            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
        } catch {
            return
        }
        
        if (captureSession?.canAddInput(videoInput) == true) {
            captureSession?.addInput(videoInput)
        } else {
            return
        }
        
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession! )
        previewLayer?.videoGravity = .resizeAspectFill
        previewLayer?.connection?.videoOrientation = .portrait
        

        previewLayer?.frame = cameraView.bounds
        cameraView.layer.addSublayer(previewLayer!)
        

        DispatchQueue.global(qos: .userInitiated).async { [self] in
            captureSession?.startRunning()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if captureSession?.isRunning == true {
            captureSession?.stopRunning()
        }
    }
    
}
