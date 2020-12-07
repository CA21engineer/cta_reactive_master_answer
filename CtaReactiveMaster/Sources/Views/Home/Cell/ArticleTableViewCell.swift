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
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // TODO: articleImageViewのキャッシュ化
    func setup(articles: NewsSource.Article) {
        articleImageView.image = UIImage(url: articles.urlToImage ?? "https://s.yimg.com/os/creatr-uploaded-images/2020-12/5fd62c21-3394-11eb-b66f-89a93d8f8950")
        titleLabel.text = articles.title
        descriptionLabel.text = articles.description
    }
}
