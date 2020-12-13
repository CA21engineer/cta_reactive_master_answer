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
            tableView.rowHeight = 128
        }
    }

    private var articles: [NewsSource.Article] = .init()
    private var apiClient = APIClient()

    init(apiClient: APIClient) {
        self.apiClient = apiClient
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let request = NewsAPIRequest(country: .jp, category: .technology)
        apiClient.request(request, completion: { result in
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
                    case let .unknown(error):
                        print("Error!! Unknown: \(error)")
                    default:
                        print("Error!! \(error)")
                }
            }
        })
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleTableViewCell", for: indexPath) as! ArticleTableViewCell
        cell.setup(articles: articles[indexPath.row])
        return cell
    }
}
