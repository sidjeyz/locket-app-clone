//
//  PhotoTakenViewController.swift
//  Locket
//
//  Created by sulik on 03.06.2025.
//

import Foundation
import UIKit


class PhotoTakenViewController: UIViewController {
    
    
    @IBAction func backButton(_ sender: Any) {
        
        navigationController?.popViewController(animated: true)
        
    }
    @IBOutlet weak var photoImageView: UIImageView!
    
    
    
    var capturedImage: UIImage?
        
        override func viewDidLoad() {
            super.viewDidLoad()
            photoImageView.image = capturedImage
            photoImageView.contentMode = .scaleAspectFill
            photoImageView.clipsToBounds = true
            photoImageView.layer.cornerRadius = 56
        }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationItem.hidesBackButton = true
    }

}
