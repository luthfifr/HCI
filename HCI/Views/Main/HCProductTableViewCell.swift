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

    private var collectionView: UICollectionView!

    private let cellID = String(describing: ProductCVC.self)

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
    func setData() {
        //codes here
    }
}

// MARK: - Private methods
extension HCProductTableViewCell {
    private func setupViews() {
        setupCollectionView()
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
            collectionView.backgroundColor = .white
            collectionView.delegate = self
            collectionView.dataSource = self

            collectionView.register(ProductCVC.self, forCellWithReuseIdentifier: cellID)

            if !contentView.subviews.contains(collectionView) {
                contentView.addSubview(collectionView)
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
        return 0
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
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        //codes here
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //codes here
    }
}

extension HCProductTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: contentView.frame.width/3, height: contentView.frame.height/2)
    }
}
