//
//  HomeViewController.swift
//  CtaReactiveMaster
//
//  Created by Takuma Osada on 2020/11/21.
//

import UIKit
import RxSwift
import RxCocoa
import SafariServices

final class HomeViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            tableView.refreshControl = refreshControl
            tableView.registerNib(ArticleCell.self)
        }
    }

    private let disposeBag = DisposeBag()
    private let refreshControl = UIRefreshControl()
    private let viewModel: HomeViewModelType

    init(viewModel: HomeViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        bindToViewModel()
        viewModel.input.viewDidLoad()
    }

    private func bindToViewModel() {
        refreshControl
            .rx
            .controlEvent(.valueChanged)
            .asDriver()
            .drive { [weak self] _ in
                self?.viewModel.input.pullToRefresh()
            }
            .disposed(by: disposeBag)

        tableView.rx.modelSelected(Article.self)
            .asDriver()
            .drive(Binder(self) { me, article in
                guard let url = article.webURL else { return }
                let viewController = SFSafariViewController(url: url)
                me.present(viewController, animated: true)
            })
            .disposed(by: disposeBag)

        viewModel.output.articles.asObservable()
            .bind(to: tableView.rx.items(cellIdentifier: ArticleCell.className, cellType: ArticleCell.self))  { index, item, cell in
                cell.setup(article: item)
            }
            .disposed(by: disposeBag)

        viewModel.output.articles.asObservable()
            .bind(to: Binder(self) { me, _ in
                if me.refreshControl.isRefreshing {
                    me.refreshControl.endRefreshing()
                }
            })
            .disposed(by: disposeBag)

        viewModel.output.loadingStatus
            .drive(Binder(self) { me, status in
                switch status {
                case .loading:
                    me.showIndicator()
                case .initial, .loadSuccess, .loadFailed:
                    me.hideIndicator()
                }
            })
            .disposed(by: disposeBag)
    }
}

private extension Article {
    var webURL: URL? {
        if let url = url {
            return URL(string: url)
        } else {
            return nil
        }
    }
}
