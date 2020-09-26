//
//  CustomClass.swift
//  NumtoString
//
//  Created by imran shaik on 26/09/20.
//  Copyright © 2020 imran shaik. All rights reserved.
//

import Foundation
import UIKit
@IBDesignable
class view : UIView {
    @IBInspectable var borderColor: UIColor? {
        didSet {
            layer.borderColor = borderColor?.cgColor
        }
    }
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    @IBInspectable open var cornerRadius: CGFloat = 0.0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }
}
@IBDesignable
class label : UILabel {
    
    @IBInspectable var borderColor: UIColor? {
        didSet {
            layer.borderColor = borderColor?.cgColor
        }
    }
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    @IBInspectable open var cornerRadius: CGFloat = 0.0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }
}
@IBDesignable
class button : UIButton {
    @IBInspectable var borderColor: UIColor? {
        didSet {
            layer.borderColor = borderColor?.cgColor
        }
    }
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    @IBInspectable open var cornerRadius: CGFloat = 0.0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }
}
@IBDesignable
open class TextView: UITextView {
    private struct Constants {
        static let defaultiOSPlaceholderColor = UIColor(red: 0.0, green: 0.0, blue: 0.0980392, alpha: 0.22)
    }
    public let placeholderLabel: UILabel = UILabel()
    private var placeholderLabelConstraints = [NSLayoutConstraint]()
    //MARK: ====: IBInspectable Property can access into storyboard :=====
    @IBInspectable open var leftMargin: CGFloat = 8.0 {
        didSet {
            self.textContainerInset = UIEdgeInsets(top: self.frame.height/4, left: leftMargin, bottom: 0, right: 20)
        }
    }
    @IBInspectable open var placeholder: String = "" {
        didSet {
            placeholderLabel.text = placeholder
        }
    }
    @IBInspectable open var cornerRadius: CGFloat = 0.0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }
    @IBInspectable open var borderWidth: CGFloat = 0.0 {
        didSet {
            self.layer.borderWidth = borderWidth
        }
    }
    @IBInspectable open var borderColor: UIColor = UIColor.clear {
        didSet {
            self.layer.borderColor = borderColor.cgColor
        }
    }
    @IBInspectable open var placeholderColor: UIColor = TextView.Constants.defaultiOSPlaceholderColor {
        didSet {
            placeholderLabel.textColor = placeholderColor
        }
    }
    
    override open var font: UIFont! {
        didSet {
            if placeholderFont == nil {
                placeholderLabel.font = font
            }
        }
    }
    open var placeholderFont: UIFont? {
        didSet {
            let font = (placeholderFont != nil) ? placeholderFont : self.font
            placeholderLabel.font = font
        }
    }
    override open var textAlignment: NSTextAlignment {
        didSet {
            placeholderLabel.textAlignment = textAlignment
        }
    }
    override open var text: String! {
        didSet {
            textDidChange()
        }
    }
    override open var attributedText: NSAttributedString! {
        didSet {
            textDidChange()
        }
    }
    override open var textContainerInset: UIEdgeInsets {
        didSet {
            updateConstraintsForPlaceholderLabel()
        }
    }
    override public init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        commonInit()
    }
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    let te = UITextView()
    private func commonInit() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(textDidChange),
                                               name: UITextView.textDidChangeNotification,
                                               object: nil)
        placeholderLabel.font = font
        placeholderLabel.textColor = placeholderColor
        placeholderLabel.textAlignment = textAlignment
        placeholderLabel.text = placeholder
        placeholderLabel.numberOfLines = 0
        placeholderLabel.backgroundColor = UIColor.clear
        placeholderLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(placeholderLabel)
        updateConstraintsForPlaceholderLabel()
    }
    private func updateConstraintsForPlaceholderLabel() {
        var newConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|-(\(textContainerInset.left + textContainer.lineFragmentPadding))-[placeholder]",
            options: [],
            metrics: nil,
            views: ["placeholder": placeholderLabel])
        newConstraints += NSLayoutConstraint.constraints(withVisualFormat: "V:|-(\(textContainerInset.top))-[placeholder]",
            options: [],
            metrics: nil,
            views: ["placeholder": placeholderLabel])
        newConstraints.append(NSLayoutConstraint(
            item: placeholderLabel,
            attribute: .width,
            relatedBy: .equal,
            toItem: self,
            attribute: .width,
            multiplier: 1.0,
            constant: -(textContainerInset.left + textContainerInset.right + textContainer.lineFragmentPadding * 2.0)))
        removeConstraints(placeholderLabelConstraints)
        addConstraints(newConstraints)
        placeholderLabelConstraints = newConstraints
    }
    @objc private func textDidChange() {
        placeholderLabel.isHidden = !text.isEmpty
    }
    open override func layoutSubviews() {
        super.layoutSubviews()
        placeholderLabel.preferredMaxLayoutWidth = textContainer.size.width - textContainer.lineFragmentPadding * 2.0
    }
    deinit {
        NotificationCenter.default.removeObserver(self,
                                                  name: UITextView.textDidChangeNotification,
                                                  object: nil)
    }
}
