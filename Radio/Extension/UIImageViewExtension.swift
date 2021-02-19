//
//  UIImageViewExtension.swift
//  Radio
//
//  Created by Андрей Лапин on 20.02.2021.
//

import Foundation
import UIKit

extension UIImageView {
    func addBlurEffect() {
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.bounds
        
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(blurEffectView)
    }
}
