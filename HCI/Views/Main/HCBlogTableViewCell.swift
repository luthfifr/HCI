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
    private var bannerImgView: UIImageView!
    private var containerView: UIView!
    private var roundedCornerView: UIView!

    // MARK: - Initialization
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

    // MARK: - Setup methods
    private func setupViews() {
        setupContainerView()
        setupRoundedCornerView()
        setupBannerImgView()
        setupTitleView()
        setupTitleLabel()
    }

    private func setupContainerView() {
        if containerView == nil {
            containerView = UIView(frame: .zero)
            containerView.backgroundColor = .white
            containerView.layer.cornerRadius = 5
            containerView.layer.shadowColor = UIColor.black.cgColor
            containerView.layer.shadowOpacity = 0.3
            containerView.layer.shadowOffset = CGSize(width: 0, height: 8)
            containerView.layer.shadowRadius = 2.5

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

    private func setupRoundedCornerView() {
        if roundedCornerView == nil {
            roundedCornerView = UIView(frame: .zero)
            roundedCornerView.backgroundColor = .white
            roundedCornerView.layer.cornerRadius = 5
            roundedCornerView.layer.masksToBounds = true

            if !containerView.subviews.contains(roundedCornerView) {
                containerView.addSubview(roundedCornerView)
            }

            roundedCornerView.snp.makeConstraints({ make in
                make.edges.equalToSuperview()
            })
        }
    }

    private func setupBannerImgView() {
        if bannerImgView == nil {
            bannerImgView = UIImageView(frame: .zero)
            bannerImgView.contentMode = .scaleAspectFit
            bannerImgView.backgroundColor = .green

            if !roundedCornerView.subviews.contains(bannerImgView) {
                roundedCornerView.addSubview(bannerImgView)
            }

            bannerImgView.snp.makeConstraints({ make in
                make.edges.equalToSuperview()
            })
        }
    }

    private func setupTitleView() {
        if titleView == nil {
            titleView = UIView(frame: .zero)
            titleView.translatesAutoresizingMaskIntoConstraints = false
            titleView.backgroundColor = .white

            if !roundedCornerView.subviews.contains(titleView) {
                roundedCornerView.addSubview(titleView)
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
    func setData(with data: HCMainDataModel.HCItemsDataModel) {
        bannerImgView.sd_setImage(with: URL(string: data.image ?? String()),
                               placeholderImage: nil,
                               options: [.highPriority, .waitStoreCache, .continueInBackground],
                               context: nil)
        titleLabel.text = data.name ?? "Article title"
    }
}
