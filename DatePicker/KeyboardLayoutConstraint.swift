//
//  KeyboardLayoutConstraint.swift
//  KeyboardLayoutConstraint
//
//  Created by Bondar Yaroslav on 14/02/2017.
//  Copyright © 2017 Bondar Yaroslav. All rights reserved.
//

import UIKit

final public class KeyboardLayoutConstraint: NSLayoutConstraint {
    
    @IBInspectable public var keyboardInset: CGFloat = 0
    @IBInspectable public var initialInset: CGFloat = 0
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShowNotification), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHideNotification), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    @objc private func keyboardWillShowNotification(notification: NSNotification) {
        guard
            let userInfo = notification.userInfo,
            let keyboardFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
            else { return }
        constant = keyboardFrame.size.height + keyboardInset
        layoutIfNeededWithAnimation()
    }

    @objc private func keyboardWillHideNotification(notification: NSNotification) {
        constant = initialInset
        layoutIfNeededWithAnimation()
    }
    
    private func layoutIfNeededWithAnimation() {
        /// 1. view.window or view.superview ???
        /// 2. maybe there is a better way to update layout
        if let view = secondItem as? UIView, let superview = view.superview {
            superview.layoutIfNeeded()
        } else if let view = firstItem as? UIView, let superview = view.superview {
            superview.layoutIfNeeded()
        }
    }
}
