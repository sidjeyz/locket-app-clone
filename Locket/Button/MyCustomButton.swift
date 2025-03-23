//
//  MyButton.swift
//  Locket
//
//  Created by Сулейман on 11.03.2025.
//

import Foundation
import UIKit


class MyCustomImageButton: UIView{
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
    }
    
    @objc private func handleTap(){
        
        
        
    }
    
    required init?(coder: NSCoder) {
        
        super.init(coder: coder)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        highlightedState()
        
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
    
}


class MyCustomTextButton{
    
    
    
}
