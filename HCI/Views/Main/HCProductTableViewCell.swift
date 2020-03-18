//
//  HCProductTableViewCell.swift
//  HCI
//
//  Created by Luthfi Fathur Rahman on 17/03/20.
//  Copyright © 2020 Stand Alone. All rights reserved.
//

import UIKit
import SnapKit

class HCProductTableViewCell: UITableViewCell {
    typealias ProductCVC = HCProductCollectionViewCell

    private var containerView: UIView!
    private var collectionView: UICollectionView!

    private let cellID = String(describing: ProductCVC.self)
    private var productData: HCMainDataModel.HCSectionDataModel? {
        didSet {
            collectionView.reloadData()
        }
    }

    convenience init() {
        self.init()
        setupViews()
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupViews()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
}

// MARK: - Public methods
extension HCProductTableViewCell {
    func setData(with data: HCMainDataModel.HCSectionDataModel) {
        productData = data
    }
}

// MARK: - Private methods
extension HCProductTableViewCell {
    private func setupViews() {
        setupContainerView()
        setupCollectionView()
    }

    private func setupContainerView() {
        if containerView == nil {
            containerView = UIView(frame: .zero)
            containerView.backgroundColor = .white
            containerView.layer.shadowColor = UIColor.black.cgColor
            containerView.layer.shadowOpacity = 0.5
            containerView.layer.shadowOffset = CGSize(width: 0, height: 8)
            containerView.layer.shadowRadius = 5

            if !contentView.subviews.contains(containerView) {
                contentView.addSubview(containerView)
            }

            containerView.snp.makeConstraints({ make in
                make.leading
                    .equalTo(contentView.snp.leading).offset(16)
                make.trailing
                    .equalTo(contentView.snp.trailing).offset(-16)
                make.top
                    .equalTo(contentView.snp.top).offset(16)
                make.bottom
                    .equalTo(contentView.snp.bottom).offset(-16)
            })
        }
    }

    private func setupCollectionView() {
        if collectionView == nil {
            let layout = UICollectionViewFlowLayout()
            layout.minimumLineSpacing = 0
            layout.minimumInteritemSpacing = 0
            layout.itemSize = CGSize(width: contentView.frame.width/3,
                                     height: contentView.frame.height/2)
            collectionView = UICollectionView(frame: .zero,
                                              collectionViewLayout: layout)
            collectionView.backgroundColor = .clear
            collectionView.delegate = self
            collectionView.dataSource = self

            collectionView.register(ProductCVC.self, forCellWithReuseIdentifier: cellID)

            if !containerView.subviews.contains(collectionView) {
                containerView.addSubview(collectionView)
            }

            collectionView.snp.makeConstraints({ make in
                make.edges.equalToSuperview()
            })
        }
    }
}

// MARK: - UICollectionViewDataSource
extension HCProductTableViewCell: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let data = productData,
            let items = data.items else {
            return 0
        }
        return items.count
    }
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView
            .dequeueReusableCell(withReuseIdentifier: cellID,
                                                            for: indexPath) as? ProductCVC else {
            return UICollectionViewCell()
        }
        cell.backgroundColor = .clear
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension HCProductTableViewCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView,
                        willDisplay cell: UICollectionViewCell,
                        forItemAt indexPath: IndexPath) {
        guard let cell = cell as? ProductCVC,
            let data = productData?.items?[indexPath.item] else { return }
        cell.setData(with: data)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let data = productData?.items?[indexPath.item],
            let strURL = data.link,
            let url = URL(string: strURL) else { return }
        #if DEBUG
        print("selected URL: \(strURL)")
        #endif
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url,
                                      options: [:],
                                      completionHandler: nil)
        }
    }
}

extension HCProductTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: containerView.frame.width/3, height: containerView.frame.height/2)
    }
}
