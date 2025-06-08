//
//  PhotoViewController .swift
//  Locket
//
//  Created by Сулейман on 26.02.2025.
//

import Foundation
import UIKit
import AVFoundation

class PhotoSceneController: UIViewController, AVCapturePhotoCaptureDelegate{
    
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
    
    var photoOutput: AVCapturePhotoOutput?
    var captureCompletion: ((UIImage) -> Void)?
    
    var frontCameraDeviceInput: AVCaptureDeviceInput?
    var backCameraDeviceInput: AVCaptureDeviceInput?
    
    var currentCameraPosition: AVCaptureDevice.Position = .back{
        didSet {
            updateFlashButtonState()
        }
    }
    
    var router: PhotoSceneRoutingLogic?
    var interactor: PhotoSceneBusinessLogic?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.interactor?.makeState(request: .start)
        
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
        updateFlashButtonState()
        
        takePhotoButton.addTarget(self, action: #selector(takePhoto), for: .touchUpInside)
                
        setupPhotoOutput()
        
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
                        turnOffFlash()
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
        
    
    func turnOffFlash() {
        guard let device = captureDevice, device.hasTorch else { return }
        
        do {
            try device.lockForConfiguration()
            if device.torchMode != .off {
                device.torchMode = .off
                currentFlashMode = .off
                flash.image.image = UIImage(named: "flash")
            }
            device.unlockForConfiguration()
        } catch {
            print("Ошибка при выключении вспышки: \(error.localizedDescription)")
        }
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
    
    func updateFlashButtonState() {
        let isBackCamera = currentCameraPosition == .back
        let hasFlash = captureDevice?.hasTorch ?? false
        
        // Включаем/выключаем взаимодействие и меняем прозрачность
        flash.isUserInteractionEnabled = isBackCamera && hasFlash
        flash.alpha = (isBackCamera && hasFlash) ? 1.0 : 0.5
        
        // Если камера фронтальная или нет вспышки, выключаем ее
        if !isBackCamera || !hasFlash {
            turnOffFlash()
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
    private func setupPhotoOutput() {
            photoOutput = AVCapturePhotoOutput()
            if let photoOutput = photoOutput, let captureSession = captureSession {
                if captureSession.canAddOutput(photoOutput) {
                    captureSession.addOutput(photoOutput)
                }
            }
        }
        
    @objc func takePhoto() {
        guard let photoOutput = photoOutput else { return }
        
        let settings = AVCapturePhotoSettings()
        
        // Настройка вспышки
        if currentCameraPosition == .back && currentFlashMode == .on {
            settings.flashMode = .on
        } else {
            settings.flashMode = .off
        }
        
        // Делаем фото
        photoOutput.capturePhoto(with: settings, delegate: self)
        
        // Анимация для эффекта съемки
        UIView.animate(withDuration: 0.1, animations: {
            self.cameraView.alpha = 0.5
        }) { _ in
            UIView.animate(withDuration: 0.1) {
                self.cameraView.alpha = 1.0
            }
        }
    }
        override func viewDidLayoutSubviews() {
            super.viewDidLayoutSubviews()
            previewLayer?.frame = cameraView.bounds
        }
    }

extension PhotoSceneController {
    func photoOutput(_ output: AVCapturePhotoOutput,
                        didFinishProcessingPhoto photo: AVCapturePhoto,
                        error: Error?) {
            if let error = error {
                print("Ошибка при обработке фото: \(error.localizedDescription)")
                return
            }
            
            if let imageData = photo.fileDataRepresentation(),
               let image = UIImage(data: imageData) {
                
                let orientedImage = fixImageOrientation(image: image)
                
                // Переходим на PhotoTakenViewController и передаем изображение
                DispatchQueue.main.async {
                    self.showPhotoTakenViewController(with: orientedImage)
                }
            }
        }
    
    private func showPhotoTakenViewController(with image: UIImage) {
            let storyboard = UIStoryboard(name: "PhotoTakenViewController", bundle: nil)
            if let photoTakenVC = storyboard.instantiateViewController(withIdentifier: "PhotoTakenViewController") as? PhotoTakenViewController {
                photoTakenVC.capturedImage = image
                navigationController?.pushViewController(photoTakenVC, animated: true)
            }
        }
        
        private func fixImageOrientation(image: UIImage) -> UIImage {
            if currentCameraPosition == .front {
                return UIImage(cgImage: image.cgImage!, scale: image.scale, orientation: .leftMirrored)
            }
            return image
        }
    
}
