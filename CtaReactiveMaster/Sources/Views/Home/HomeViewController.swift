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
            tableView.delegate = self
            tableView.dataSource = self
            tableView.refreshControl = refreshControl
            tableView.registerNib(ArticleCell.self)
        }
    }

    private let disposeBag = DisposeBag()
    private let refreshControl = UIRefreshControl()
    private let viewModel: HomeViewModel

    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.fetch()

        viewModel.output.articles
            .subscribeOn(SerialDispatchQueueScheduler(qos: .background))
            .observeOn(MainScheduler.instance)
            .subscribe { [weak self] response in
                guard let self = self else { return }
                self.tableView.reloadData()
                if self.refreshControl.isRefreshing {
                    self.refreshControl.endRefreshing()
                }
            } onError: { error in
                print(error)
            }
            .disposed(by: disposeBag)

        refreshControl
            .rx
            .controlEvent(.valueChanged)
            .asDriver()
            .drive { [weak self] _ in
                self?.viewModel.fetch()
            }
            .disposed(by: disposeBag)
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.output.articles.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(ArticleCell.self, for: indexPath)
        cell.setup(article: viewModel.output.articles.value[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let article = viewModel.output.articles.value[indexPath.row]
        guard let url = article.webURL else { return }
        let viewController = SFSafariViewController(url: url)
        present(viewController, animated: true)
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
