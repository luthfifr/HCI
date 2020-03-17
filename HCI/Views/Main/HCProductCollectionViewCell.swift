//
//  HCProductCollectionViewCell.swift
//  HCI
//
//  Created by Luthfi Fathur Rahman on 17/03/20.
//  Copyright © 2020 Stand Alone. All rights reserved.
//

import UIKit

class HCProductCollectionViewCell: UICollectionViewCell {
    private var stackView: UIStackView!
    private var imgView: UIImageView!
    private var label: UILabel!

    convenience init() {
        self.init()

        setupViews()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
}

// MARK: - Private methods
extension HCProductCollectionViewCell {
    private func setupViews() {
        setupImgView()
        setupLabel()
        setupStackView()
    }

    private func setupStackView() {
        if stackView == nil {
            stackView = UIStackView(frame: .zero)
            stackView.axis = .vertical
            stackView.distribution = .fill
            stackView.spacing = 4
            stackView.addArrangedSubview(imgView)
            stackView.addArrangedSubview(label)

            if !contentView.subviews.contains(stackView) {
                contentView.addSubview(stackView)
            }

            stackView.snp.makeConstraints({ make in
                make.edges.equalToSuperview()
            })
        }
    }

    private func setupImgView() {
        if imgView == nil {
            imgView = UIImageView(frame: .zero)
            imgView.backgroundColor = .lightGray
            imgView.contentMode = .scaleAspectFit
        }
    }

    private func setupLabel() {
        if label == nil {
            label = UILabel(frame: .zero)
            label.backgroundColor = .clear
            label.numberOfLines = 0
            label.font = UIFont.systemFont(ofSize: 12)
            label.textColor = .black
            label.textAlignment = .center
            label.text = "Product"
        }
    }
}
