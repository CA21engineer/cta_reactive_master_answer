//
//  UIRefreshControl+Extension.swift
//  CtaReactiveMaster
//
//  Created by Takuma Osada on 2021/01/06.
//

import RxCocoa
import RxSwift

extension Reactive where Base: UIRefreshControl {
    var endRefreshing: Binder<Void> {
        Binder(self.base) { base, _ in
            if base.isRefreshing {
                base.endRefreshing()
            }
        }
    }
}
