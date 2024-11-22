//
//  MovableView.swift
//  HumanAppsTask
//
//  Created by MAC on 11/14/24.
//

import UIKit

class MovableView: UIView {
    
    //MARK: - Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupGestures()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Public methods
    
    ///If you need to add or remove gestures override this method.
    func setupGestures() {
        setPanGesture()
        setRotateGesture()
        setPinGesture()
    }
    
    func setPanGesture() {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panGesture))
        panGesture.maximumNumberOfTouches = 1
        addGestureRecognizer(panGesture)
    }
    
    func setRotateGesture() {
        let rotateGesture = UIRotationGestureRecognizer(target: self, action: #selector(rotateGesture))
        rotateGesture.delegate = self
        addGestureRecognizer(rotateGesture)
    }
    
    func setPinGesture() {
        let pinGesture = UIPinchGestureRecognizer(target: self, action: #selector(pinGesture))
        pinGesture.delegate = self
        addGestureRecognizer(pinGesture)
    }
    
    @objc func panGesture(_ sender: UIPanGestureRecognizer) {
        guard let senderView = sender.view else { return }
        
        if sender.state == .began || sender.state == .changed {
            let translation = sender.translation(in: senderView.superview)
            
            senderView.center = CGPoint(
                x: senderView.center.x + translation.x,
                y: senderView.center.y + translation.y
            )
            
            sender.setTranslation(.zero, in: senderView.superview)
        }
    }
    
    @objc func rotateGesture(_ sender: UIRotationGestureRecognizer) {
        sender.view?.transform = (sender.view?.transform)!.rotated(by: sender.rotation)
        sender.rotation = 0
    }
    
    @objc func pinGesture(_ sender: UIPinchGestureRecognizer) {
        sender.view?.transform = (sender.view?.transform)!.scaledBy(x: sender.scale, y: sender.scale)
        sender.scale = 1
    }
}

//MARK: UIGestureRecognizerDelegate
extension MovableView: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        true
    }
}
