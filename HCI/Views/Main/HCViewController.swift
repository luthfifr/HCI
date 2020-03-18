//
//  ViewController.swift
//  HCI
//
//  Created by Luthfi Fathur Rahman on 17/03/20.
//  Copyright © 2020 Stand Alone. All rights reserved.
//

import UIKit
import RxSwift
import SnapKit

class HCMainViewController: UIViewController {
    typealias Constants = HCConstants.MainVC
    private let disposeBag = DisposeBag()

    typealias ProductTVC = HCProductTableViewCell
    typealias BlogTVC = HCBlogTableViewCell

    private var tableView: UITableView!

    private let prodSectionCellID = String(describing: ProductTVC.self)
    private let blogSectionCellID = String(describing: BlogTVC.self)

    private var viewModel: HCMainViewModel!
    private var dataModel: HCMainDataModel? {
        didSet {
            tableView.reloadData()
        }
    }

    init() {
        super.init(nibName: nil, bundle: nil)
        viewModel = HCMainViewModel()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        viewModel = HCMainViewModel()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let label = UILabel()
        label.textColor = UIColor.white
        label.text = Constants.title
        navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: label)
        view.backgroundColor = Constants.backgroundColor
        setupViews()
        setupEvents()
        viewModel.viewModelEvents.onNext(.getData)
    }
}

// MARK: - Private methods
extension HCMainViewController {
    private func setupEvents() {
        viewModel.uiEvents.subscribe(onNext: { [weak self] event in
            guard let `self` = self else { return }
            switch event {
            case .getDataSuccess:
                self.dataModel = self.viewModel.responseModel
            case .getDataFailure: break
            default: break
            }
        }).disposed(by: disposeBag)
    }

    private func setupViews() {
        setupTableView()
    }

    private func setupTableView() {
        if tableView == nil {
            tableView = UITableView(frame: .zero)
            tableView.backgroundColor = .clear
            tableView.allowsMultipleSelection = false
            tableView.translatesAutoresizingMaskIntoConstraints = false
            tableView.tableFooterView = UIView()
            tableView.separatorStyle = .none
            tableView.dataSource = self
            tableView.delegate = self

            tableView.register(ProductTVC.self, forCellReuseIdentifier: prodSectionCellID)
            tableView.register(BlogTVC.self, forCellReuseIdentifier: blogSectionCellID)

            if !view.subviews.contains(tableView) {
                view.addSubview(tableView)
            }

            tableView.snp.makeConstraints({ make in
                make.edges.equalToSuperview()
            })
        }
    }
}

// MARK: - UITableViewDataSource
extension HCMainViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            guard let dataModel = dataModel,
                let data = dataModel.data,
                let blogSectionData = data.first(where: {
                    guard let section = $0.section else {
                        return false
                    }
                    return section == Constants.articleSectionRawValue
                }), let items = blogSectionData.items else {
                return 0
            }
            return items.count
        default:
            return 0
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 332
        case 1:
            return 200
        default:
            return 0
        }
    }

    func tableView(_ tableView: UITableView,
                   titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return nil
        case 1:
            guard let dataModel = dataModel,
                let data = dataModel.data,
                let blogSectionData = data.first(where: {
                    guard let section = $0.section else {
                        return false
                    }
                    return section == Constants.articleSectionRawValue
                }) else {
                return nil
            }
            return blogSectionData.sectionTitle
        default:
            return nil
        }
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0:
            return 0
        case 1:
            return 25
        default:
            return 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()

        switch indexPath.section {
        case 0:
            guard let cell0 = tableView.dequeueReusableCell(withIdentifier: prodSectionCellID, for: indexPath) as? ProductTVC else { //swiftlint:disable:this line_length
                return UITableViewCell()
            }
            cell0.selectionStyle = .none
            cell0.backgroundColor = .clear
            cell = cell0
        case 1:
            guard let cell1 = tableView.dequeueReusableCell(withIdentifier: blogSectionCellID, for: indexPath) as? BlogTVC else { //swiftlint:disable:this line_length
                return UITableViewCell()
            }
            cell1.selectionStyle = .none
            cell1.backgroundColor = .clear
            cell = cell1
        default:
            break
        }

        return cell
    }
}

// MARK: - UITableViewDelegate
extension HCMainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            guard let cell = cell as? ProductTVC,
                let dataModel = dataModel,
                let data = dataModel.data,
                let productSectionData = data.first(where: {
                    guard let section = $0.section else {
                        return false
                    }
                    return section == Constants.productSectionRawValue
                }) else {
                return
            }
            cell.setData(with: productSectionData)
        case 1:
            guard let cell = cell as? BlogTVC,
                let dataModel = dataModel,
                let data = dataModel.data,
                let blogSectionData = data.first(where: {
                    guard let section = $0.section else {
                        return false
                    }
                    return section == Constants.articleSectionRawValue
                }),
                let items = blogSectionData.items else {
                return
            }
            cell.setData(with: items[indexPath.row])
        default:
            return
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let dataModel = dataModel,
            let data = dataModel.data,
            let blogSectionData = data.first(where: {
                guard let section = $0.section else {
                    return false
                }
                return section == Constants.articleSectionRawValue
            }),
            let items = blogSectionData.items,
            let strURL = items[indexPath.row].link,
            let url = URL(string: strURL) else {
            return
        }
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
