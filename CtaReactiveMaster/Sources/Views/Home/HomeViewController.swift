//
//  HomeViewController.swift
//  CtaReactiveMaster
//
//  Created by Takuma Osada on 2020/11/21.
//

import UIKit
import RxSwift
import RxCocoa

final class HomeViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
            tableView.registerNib(ArticleTableViewCell.self)
            tableView.refreshControl = refreshControl
        }
    }

    private var articles: [NewsSource.Article] = []
    private let disposeBag = DisposeBag()
    private let refreshControl = UIRefreshControl()
    private let repository: NewsRepository

    init(repository: NewsRepository) {
        self.repository = repository
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchNewsAPI()

        refreshControl
            .rx
            .controlEvent(.valueChanged)
            .asDriver()
            .drive { [weak self] _ in
                self?.fetchNewsAPI()
            }
            .disposed(by: disposeBag)
    }

    private func fetchNewsAPI() {
        repository.fetch()
            .subscribeOn(SerialDispatchQueueScheduler(qos: .background))
            .observeOn(MainScheduler.instance)
            .subscribe { [weak self] response in
                guard let self = self else { return }
                self.articles = response.articles
                self.tableView.reloadData()
                if self.refreshControl.isRefreshing {
                    self.refreshControl.endRefreshing()
                }
            } onError: { error in
                print(error)
            }
            .disposed(by: disposeBag)
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(ArticleTableViewCell.self, for: indexPath)
        cell.setup(article: articles[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let ArticleTableViewCellHeigth: CGFloat = 128
        return ArticleTableViewCellHeigth
    }
}
