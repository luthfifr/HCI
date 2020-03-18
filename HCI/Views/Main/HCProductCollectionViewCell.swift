//
//  HCProductCollectionViewCell.swift
//  HCI
//
//  Created by Luthfi Fathur Rahman on 17/03/20.
//  Copyright © 2020 Stand Alone. All rights reserved.
//

import UIKit
import SDWebImage

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

// MARK: - Public methods
extension HCProductCollectionViewCell {
    func setData(with data: HCMainDataModel.HCItemsDataModel) {
        let productName = data.productName ?? "Product Name"
        label.text = productName.replacingOccurrences(of: " ", with: "\n")
        imgView.sd_setImage(with: URL(string: data.productImage ?? String())) { [weak self] image, error, _, _ in
            guard let `self` = self else { return }
            if let error = error {
                #if DEBUG
                print("download product image error: \(error.localizedDescription)")
                #endif
            }

            if image == nil {
                var iconImage: UIImage?
                switch productName {
                case "Pembiayaan Handphone":
                    iconImage = UIImage(named: "icon-hp")
                case "Pembiayaan Kamera":
                    iconImage = UIImage(named: "icon-camera")
                case "Pembiayaan TV":
                    iconImage = UIImage(named: "icon-tv")
                case "Pembiayaan Laptop":
                    iconImage = UIImage(named: "icon-laptop")
                case "Pembiayaan Elektronik":
                    iconImage = UIImage(named: "icon-refrigerator")
                case "Pembiayaan Furnitur":
                    iconImage = UIImage(named: "icon-sofa")
                default:
                    iconImage = UIImage(named: "icon-hci")
                }
                self.imgView.image = iconImage
            }
        }
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
            imgView.contentMode = .center
            imgView.tintColor = .black
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
