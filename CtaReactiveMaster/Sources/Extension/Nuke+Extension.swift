//
//  Nuke+Extension.swift
//  CtaReactiveMaster
//
//  Created by Takuma Osada on 2020/12/19.
//

import Nuke

extension UIImageView {
    func loadImage(from urlString: String?) {
        guard let urlString = urlString, let url = URL(string: urlString) else {
            self.image = #imageLiteral(resourceName: "default")
            return
        }
        let options = ImageLoadingOptions(
            placeholder: #imageLiteral(resourceName: "default"),
            transition: .fadeIn(duration: 0.33),
            failureImage: #imageLiteral(resourceName: "default"),
            failureImageTransition: .fadeIn(duration: 0.33),
            contentModes: .init(success: .scaleAspectFill, failure: .scaleAspectFill, placeholder: .scaleAspectFill)
        )
        Nuke.loadImage(with: url, options: options, into: self)
    }
}
