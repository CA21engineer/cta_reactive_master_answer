//
//  ArticleCell.swift
//  CtaReactiveMaster
//
//  Created by 小幡 十矛 on 2020/12/05.
//

import UIKit

final class ArticleCell: UITableViewCell {
    @IBOutlet private weak var articleImageView: UIImageView! {
        didSet {
            articleImageView.contentMode = .scaleAspectFill
            articleImageView.layer.cornerRadius = 4
        }
    }

    @IBOutlet private weak var mainStackView: UIStackView! {
        didSet {
            mainStackView.backgroundColor = .clear
        }
    }

    @IBOutlet private weak var titleLabel: UILabel! {
        didSet {
            titleLabel.font = .systemFont(ofSize: 17, weight: .bold)
        }
    }

    @IBOutlet private weak var descriptionLabel: UILabel! {
        didSet {
            descriptionLabel.font = .systemFont(ofSize: 14)
            descriptionLabel.numberOfLines = 2
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .clear
    }

    func setup(article: Article) {
        articleImageView.loadImage(from: article.urlToImage)
        titleLabel.text = article.title
        descriptionLabel.text = article.description
    }
}
