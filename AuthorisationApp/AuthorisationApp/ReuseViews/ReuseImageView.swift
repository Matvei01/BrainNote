//
//  ReuseImageView.swift
//  AuthorisationApp
//
//  Created by Matvei Khlestov on 15.06.2024.
//

import UIKit

final class ReuseImageView: UIImageView {
    
    init(tapGestureRecognizer: UITapGestureRecognizer) {
        super.init(frame: .zero)
        setupImageView(tapGestureRecognizer)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupImageView(_ tapGestureRecognizer: UITapGestureRecognizer) {
        self.image = UIImage(systemName: "person.circle.fill")
        self.tintColor = .appRed
        self.contentMode = .scaleAspectFill
        self.clipsToBounds = true
        self.layer.cornerRadius = 74
        self.addGestureRecognizer(tapGestureRecognizer)
        self.isUserInteractionEnabled = true
        self.translatesAutoresizingMaskIntoConstraints = false
        self.widthAnchor.constraint(equalToConstant: 148).isActive = true
        self.heightAnchor.constraint(equalToConstant: 148).isActive = true
    }
}
