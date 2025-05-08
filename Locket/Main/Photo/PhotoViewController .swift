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
    
    var frontCameraDeviceInput: AVCaptureDeviceInput?
    var backCameraDeviceInput: AVCaptureDeviceInput?
    
    var currentCameraPosition: AVCaptureDevice.Position = .back
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cameraRotation.image.image = UIImage(named: "cameraRotation")
        flash.image.image = UIImage(named: "flash")
        
        cameraRotation.onTap = {
            self.switchCamera()
            print("cameraRotation вкл")
        }
        
        flash.onTap = {
            self.toggleFlash()
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
    
    
    
    /// Переключает камеры (фронталка / задняя)
    func switchCamera() {
        
        
            guard let captureSession = captureSession else { return }
            
            captureSession.beginConfiguration()
            

            if let currentInput = captureSession.inputs.first as? AVCaptureDeviceInput {
                captureSession.removeInput(currentInput)
            }
            

            if currentCameraPosition == .back {
                if let frontInput = frontCameraDeviceInput {
                    if captureSession.canAddInput(frontInput) {
                        captureSession.addInput(frontInput)
                        currentCameraPosition = .front
                    }
                }
            } else {
                if let backInput = backCameraDeviceInput {
                    if captureSession.canAddInput(backInput) {
                        captureSession.addInput(backInput)
                        currentCameraPosition = .back
                    }
                }
            }
            
            captureSession.commitConfiguration()
        }
        
    
    
    
    
    func toggleFlash() {

        guard let device = AVCaptureDevice.default(for: .video) else {
                print("Камера не доступна")
                return
            }
        
        do {
            try device.lockForConfiguration()
            
            if device.torchMode == .off {
                try device.setTorchModeOn(level: 1.0)
                currentFlashMode = .on
                flash.image.image = UIImage(named: "flash")
            } else {
                device.torchMode = .off
                currentFlashMode = .off
                flash.image.image = UIImage(named: "flash")
            }
            
            device.unlockForConfiguration()
        } catch {
            print("Ошибка вспышки: \(error.localizedDescription)")
        }
    }
    
    
    func setupCamera() {
            captureSession = AVCaptureSession()
            
            let discoverySession = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera],
                                                                    mediaType: .video,
                                                                 position: .unspecified)
            
            for device in discoverySession.devices {
                if device.position == .back {
                    backCameraDeviceInput = try? AVCaptureDeviceInput(device: device)
                    captureDevice = device
                } else if device.position == .front {
                    frontCameraDeviceInput = try? AVCaptureDeviceInput(device: device)
                }
            }
            
            guard let backInput = backCameraDeviceInput else { return }
            
            if captureSession?.canAddInput(backInput) == true {
                captureSession?.addInput(backInput)
                currentCameraPosition = .back
            }
            
            previewLayer = AVCaptureVideoPreviewLayer(session: captureSession!)
            previewLayer?.videoGravity = .resizeAspectFill
            previewLayer?.connection?.videoOrientation = .portrait
            previewLayer?.frame = cameraView.bounds
            
            if let previewLayer = previewLayer {
                cameraView.layer.insertSublayer(previewLayer, at: 0)
            }
            
            DispatchQueue.main.async {
                self.flash.isHidden = !(self.captureDevice?.hasFlash ?? false)
            }
            DispatchQueue.global(qos: .userInitiated).async { [weak self] in
                self?.captureSession?.startRunning()
            }
        }
        
        override func viewDidLayoutSubviews() {
            super.viewDidLayoutSubviews()
            previewLayer?.frame = cameraView.bounds
        }
    }
