//
//  HomeViewModel.swift
//  CtaReactiveMaster
//
//  Created by 伊藤凌也 on 2020/12/26.
//

import RxCocoa
import RxSwift

protocol HomeViewModelType {
    var input: HomeViewModelInputs { get }
    var output: HomeViewModelOutputs { get }
}

protocol HomeViewModelInputs {
    func viewDidLoad()
    func pullToRefresh()
}

protocol HomeViewModelOutputs {
    var articles: Driver<[Article]> { get }
    var loadingStatus: Driver<LoadingStatus> { get }
}

struct HomeViewModel: HomeViewModelType, HomeViewModelInputs, HomeViewModelOutputs {
    private let disposeBag = DisposeBag()

    struct Dependency {
        let repository: NewsRepository

        init(repository: NewsRepository = NewsRepository()) {
            self.repository = repository
        }
    }

    init(dependency: Dependency) {
        self.articles = articlesRelay.asDriver()
        self.loadingStatus = loadingStatusRelay.asDriver()

        viewDidLoadRelay.asObservable()
            .map { _ in LoadingStatus.loading }
            .bind(to: loadingStatusRelay)
            .disposed(by: disposeBag)

        let fetched = Observable.merge([
            viewDidLoadRelay.asObservable(),
            pullToRefreshRelay.asObservable(),
        ])
        .flatMap { dependency.repository.fetch().asObservable().materialize() }
        .share()

        fetched
            .flatMap { $0.element.map(Observable.just) ?? .empty() }
            .do(onNext: { [self] _ in
                loadingStatusRelay.accept(.loadSuccess)
            })
            .map { $0.articles }
            .bind(to: articlesRelay)
            .disposed(by: disposeBag)

        fetched
            .flatMap { $0.error.map(Observable.just) ?? .empty() }
            .do(onNext: { [self] error in
                loadingStatusRelay.accept(.loadFailed(error))
            })
            .subscribe()
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

    private let loadingStatusRelay = BehaviorRelay<LoadingStatus>(value: .initial)
    let loadingStatus: Driver<LoadingStatus>

    var input: HomeViewModelInputs { self }
    var output: HomeViewModelOutputs { self }
}
