//
//  HomeViewController.swift
//  CtaReactiveMaster
//
//  Created by Takuma Osada on 2020/11/21.
//

import UIKit

final class HomeViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(UINib(nibName: "ArticleTableViewCell", bundle: nil), forCellReuseIdentifier: "ArticleTableViewCell")
            tableView.contentInsetAdjustmentBehavior = .never
        }
    }

    private var articles: [NewsSource.Article] = .init()
    private let apiClient: APIClient

    init(apiClient: APIClient) {
        self.apiClient = apiClient
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let request = NewsAPIRequest(country: .jp, category: .technology)
        let decoder = NewsAPIDecoder()
        apiClient.request(request, decoder) { result in
            switch result {
            case let .success(model):
                self.articles = model.articles ?? .init()
                DispatchQueue.main.async {
                    self.tableView.reloadData()
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleTableViewCell", for: indexPath) as! ArticleTableViewCell
        cell.setup(article: articles[indexPath.row])
        return cell
    }
}
