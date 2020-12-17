//
//  ArticleTableViewCell.swift
//  CtaReactiveMaster
//
//  Created by 小幡 十矛 on 2020/12/05.
//

import UIKit
import Nuke

final class ArticleTableViewCell: UITableViewCell {
    @IBOutlet private weak var articleImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    
    // Todo: articleImageViewのキャッシュ化
    func setup(article: NewsSource.Article) {
        guard let imageUrl = article.urlToImage else {
            articleImageView.image = UIImage(named: "default")
            return
        }
        articleImageView.image = UIImage(url: imageUrl)
        titleLabel.text = article.title
        descriptionLabel.text = article.description
    }
}
