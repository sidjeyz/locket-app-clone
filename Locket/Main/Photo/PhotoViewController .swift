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
    var videoPreviewLayer: AVCaptureVideoPreviewLayer?
    
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
        
        cameraView.layer.cornerRadius = 64
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
        
        //checkCameraAuthorization()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationItem.hidesBackButton = true
        
    }
    
    /*func checkCameraAuthorization() {
            switch AVCaptureDevice.authorizationStatus(for: .video) {
            case .authorized:
                // Разрешение уже предоставлено
                print("Разрешение на использование камеры уже предоставлено.")
                setupCamera()
            case .notDetermined:
                // Разрешение еще не запрашивалось, запрашиваем его
                AVCaptureDevice.requestAccess(for: .video) { granted in
                    if granted {
                        print("Разрешение на использование камеры предоставлено.")
                        // Здесь вы можете начать работу с камерой
                    } else {
                        print("Разрешение на использование камеры отклонено.")
                    }
                }
                
            case .denied:
                // Разрешение было отклонено
                print("Разрешение на использование камеры было отклонено.")
                // Здесь вы можете показать сообщение пользователю о том, как включить разрешение в настройках
                
            case .restricted:
                // Доступ к камере ограничен
                print("Доступ к камере ограничен.")
                
            @unknown default:
                fatalError("Неизвестный статус авторизации.")
            }
        }

    
    func setupCamera() {
            // Создаем сессию захвата
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
            
            let videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession!)
            videoPreviewLayer.frame = view.layer.bounds
            videoPreviewLayer.videoGravity = .resizeAspectFill
            view.layer.addSublayer(videoPreviewLayer)
            
            captureSession?.startRunning()
    }*/
        
        override func viewWillDisappear(_ animated: Bool) {
            super.viewWillDisappear(animated)
            
            if captureSession?.isRunning == true {
                captureSession?.stopRunning()
            }
        }
}
