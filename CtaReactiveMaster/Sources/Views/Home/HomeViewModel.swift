//
//  HomeViewModel.swift
//  CtaReactiveMaster
//
//  Created by Takuma Osada on 2020/12/22.
//

import Foundation
import RxSwift
import RxRelay

struct HomeViewModel {
    struct Dependency {
        let repository: NewsRepository
    }

    struct HomeViewModelOutput {
        let articles = BehaviorRelay<[Article]>(value: [])
    }

    let dependency: Dependency
    let disposeBag = DisposeBag()
    let output = HomeViewModelOutput()

    func fetch() {
        dependency.repository.fetch()
            .asObservable()
            .map(\.articles)
            .bind(to: output.articles)
            .disposed(by: disposeBag)
    }
}
