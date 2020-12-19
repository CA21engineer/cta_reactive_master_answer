//
//  HomeViewController.swift
//  CtaReactiveMaster
//
//  Created by Takuma Osada on 2020/11/21.
//

import UIKit
import SafariServices

final class HomeViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
            tableView.registerNib(ArticleCell.self)
        }
    }

    private var articles: [Article] = []
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
        repository.fetch { [weak self] result in
            switch result {
            case let .success(model):
                self?.articles = model.articles
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            case let .failure(error):
                switch error {
                case .noResponse:
                    print("Error!! No Response")
                case let .decode(error):
                    print("Error!! Decode: \(error)")
                case let .unknown(error):
                    print("Error!! Unknown: \(error)")
                }
            }
        }
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(ArticleCell.self, for: indexPath)
        cell.setup(article: articles[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let article = articles[indexPath.row]
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
