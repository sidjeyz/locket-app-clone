//
//  MyButton.swift
//  Locket
//
//  Created by Сулейман on 11.03.2025.
//

import Foundation
import UIKit


class MyCustomImageButton: UIView{
    
    private var imageView: UIView!
    private var flashImageView: UIImageView!
    
    
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
    }
    
    required init?(coder: NSCoder) {
        
        super.init(coder: coder)
        
        imageView = UIView()
                imageView.translatesAutoresizingMaskIntoConstraints = false
                addSubview(imageView)

                
                flashImageView = UIImageView()
                flashImageView.image = UIImage(named: "flash")
                flashImageView.contentMode = .scaleAspectFit
                flashImageView.translatesAutoresizingMaskIntoConstraints = false
                imageView.addSubview(flashImageView)
                
                NSLayoutConstraint.activate([
                    imageView.widthAnchor.constraint(equalToConstant: 44),
                    imageView.heightAnchor.constraint(equalToConstant: 44),
                    imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
                    imageView.centerYAnchor.constraint(equalTo: self.centerYAnchor)
                ])
                
                NSLayoutConstraint.activate([
                    flashImageView.topAnchor.constraint(equalTo: imageView.topAnchor),
                    flashImageView.bottomAnchor.constraint(equalTo: imageView.bottomAnchor),
                    flashImageView.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
                    flashImageView.trailingAnchor.constraint(equalTo: imageView.trailingAnchor)
                ])
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
}


class MyCustomTextButton{
    
}
