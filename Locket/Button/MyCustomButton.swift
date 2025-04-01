//
//  MyButton.swift
//  Locket
//
//  Created by Сулейман on 11.03.2025.
//

import Foundation
import UIKit


class MyCustomImageButton: UIView{
    
    var image = UIImageView()
    var onTap: (() -> Void)?
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        setupImage()
    }
    
    @objc private func handleTap(){
        
        
        
    }
    
    required init?(coder: NSCoder) {
        
        super.init(coder: coder)
        setupImage()
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        highlightedState()
        onTap?()
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        defaultState()
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        defaultState()
        
    }
    
    private func highlightedState() {
        
        let animator = buttonAnimator { [weak self] in
            self?.alpha = 0.9
            self?.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        }
        animator.startAnimation()
    }
    
    private func defaultState() {
        
        let animator = buttonAnimator { [weak self] in
            self?.alpha = 1
            self?.transform = .identity
        }
        animator.startAnimation()
    }
    
    private func buttonAnimator(with animations: @escaping() -> Void) -> UIViewPropertyAnimator{
        
        let timingParameters = UISpringTimingParameters(dampingRatio: 0.5, initialVelocity: .zero)
        let animator = UIViewPropertyAnimator(duration: 0.35, timingParameters: timingParameters)
        animator.addAnimations(animations)
        return animator
        
    }
    
    
    func setupImage(){
        
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        addSubview(image)
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: topAnchor),
            image.bottomAnchor.constraint(equalTo: bottomAnchor),
            image.leadingAnchor.constraint(equalTo: leadingAnchor),
            image.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])

    }
}


class MyCustomTextButton{
    
    
    
}
