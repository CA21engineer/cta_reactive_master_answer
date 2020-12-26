//
//  HomeViewModel.swift
//  CtaReactiveMaster
//
//  Created by 伊藤凌也 on 2020/12/26.
//

import RxSwift
import RxCocoa

protocol HomeViewModelType {
    var input: HomeViewModelInputs { get }
    var output: HomeViewModelOutputs { get }

    init(dependency: HomeViewModelDependency)
}

protocol HomeViewModelInputs {
    func viewDidLoad()
    func pullToRefresh()
}

protocol HomeViewModelOutputs {
    var articles: Driver<[Article]> { get }
}

struct HomeViewModelDependency {
    let repository: NewsRepository
}

struct HomeViewModel: HomeViewModelType, HomeViewModelInputs, HomeViewModelOutputs {
    private let disposeBag = DisposeBag()

    init(dependency: HomeViewModelDependency) {
        self.articles = articlesRelay.asDriver()

        Observable.merge([
            viewDidLoadRelay.asObservable(),
            pullToRefreshRelay.asObservable(),
        ])
        .flatMap { dependency.repository.fetch().asObservable() }
        .map { $0.articles }
        .bind(to: articlesRelay)
        .disposed(by: disposeBag)
    }

    private let viewDidLoadRelay = PublishRelay<Void>()
    func viewDidLoad() {
        viewDidLoadRelay.accept(())
    }

    private let pullToRefreshRelay = PublishRelay<Void>()
    func pullToRefresh() {
        pullToRefreshRelay.accept(())
    }

    private let articlesRelay = BehaviorRelay<[Article]>(value: [])
    let articles: Driver<[Article]>

    var input: HomeViewModelInputs { self }
    var output: HomeViewModelOutputs { self }
}
