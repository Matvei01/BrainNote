//
//  ReuseTextField.swift
//  AuthorisationApp
//
//  Created by Matvei Khlestov on 29.05.2024.
//

import UIKit

final class ReuseTextField: UITextField {
    // MARK: - Private Properties
    private let padding  = UIEdgeInsets(
        top: 15,
        left: 15,
        bottom: 15,
        right: 15
    )
    
    // MARK: - UI Elements
    private lazy var eyeButton = UIButton(type: .custom)
    
    // MARK: - Initializer
    init(placeholder: String,
         isSecureTextEntry: Bool? = nil,
         returnKeyType: UIReturnKeyType? = nil) {
        
        super.init(frame: .zero)
        setupTextField(
            placeholder,
            isSecureTextEntry ?? false,
            returnKeyType ?? .done
        )
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Override Methods
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: padding)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: padding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: padding)
    }
}

// MARK: - Private methods
private extension ReuseTextField {
    func setupTextField(_ placeholder: String,
                        _ isSecureTextEntry: Bool,
                        _ returnKeyType: UIReturnKeyType) {
        
        self.layer.cornerRadius = 11.47
        self.backgroundColor = .appClear
        self.placeholder = placeholder
        self.font = .systemFont(ofSize: 16)
        self.isSecureTextEntry = isSecureTextEntry
        self.returnKeyType = returnKeyType
        
        if isSecureTextEntry {
            self.textContentType = .oneTimeCode
            setupEyeButton()
        }
    }
    
    func setupEyeButton() {
        eyeButton.setImage(UIImage(systemName: "eye"), for: .selected)
        eyeButton.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        eyeButton.addTarget(self, action: #selector(eyeButtonTapped), for: .touchUpInside)
        eyeButton.imageView?.tintColor = .appGray
        
        let containerView = UIView(
            frame: CGRect(
                x: 0,
                y: 0,
                width: eyeButton.intrinsicContentSize.width + 47,
                height: eyeButton.intrinsicContentSize.height
            )
        )
        
        eyeButton.frame = CGRect(
            x: 27,
            y: 0,
            width: eyeButton.intrinsicContentSize.width,
            height: eyeButton.intrinsicContentSize.height
        )
        
        containerView.addSubview(eyeButton)
        
        rightView = containerView
        rightViewMode = .always
    }
    
    @objc func eyeButtonTapped() {
        isSecureTextEntry.toggle()
        eyeButton.isSelected.toggle()
    }
}
