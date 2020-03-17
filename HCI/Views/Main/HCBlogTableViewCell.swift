//
//  HCBlogTableViewCell.swift
//  HCI
//
//  Created by Luthfi Fathur Rahman on 17/03/20.
//  Copyright © 2020 Stand Alone. All rights reserved.
//

import UIKit
import SnapKit
import SDWebImage

class HCBlogTableViewCell: UITableViewCell {

    private var titleView: UIView!
    private var titleLabel: UILabel!

    // MARK: - Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    // MARK: - Setup methods
    private func setupViews() {
        setupTitleView()
        setupTitleLabel()
    }
    
    private func setupTitleView() {
        if titleView == nil {
            titleView = UIView(frame: .zero)
            titleView.translatesAutoresizingMaskIntoConstraints = false
            titleView.backgroundColor = .white

            if !contentView.subviews.contains(titleView) {
                contentView.addSubview(titleView)
            }

            titleView.snp.makeConstraints({ make in
                make.leading.trailing.bottom.equalToSuperview()
                make.height.equalTo(45)
            })
        }
    }

    private func setupTitleLabel() {
        if titleLabel == nil {
            titleLabel = UILabel(frame: .zero)
            titleLabel.backgroundColor = .clear
            titleLabel.textColor = .black
            titleLabel.font = UIFont.systemFont(ofSize: 15)
            titleLabel.numberOfLines = 0
            titleLabel.textAlignment = .left
            titleLabel.translatesAutoresizingMaskIntoConstraints = false

            if !titleView.subviews.contains(titleLabel) {
                titleView.addSubview(titleLabel)
            }

            titleLabel.snp.makeConstraints({ make in
                make.top.bottom.equalToSuperview()
                make.leading.equalTo(titleView.snp.leading).offset(16)
                make.trailing.equalTo(titleView.snp.trailing).offset(16)
            })
        }
    }
}

// MARK: - Public methods
extension HCBlogTableViewCell {
    func setData() {
        imageView?.sd_setHighlightedImage(with: nil, options: [.highPriority, .waitStoreCache, .continueInBackground], completed: nil)
        titleLabel.text = String()
    }
}
