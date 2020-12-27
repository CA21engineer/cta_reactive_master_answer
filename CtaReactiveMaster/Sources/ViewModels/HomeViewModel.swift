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
    var showLoading: Signal<Void> { get }
    var hideLoading: Signal<Void> { get }
}

struct HomeViewModelDependency {
    let repository: NewsRepository
}

struct HomeViewModel: HomeViewModelType, HomeViewModelInputs, HomeViewModelOutputs {
    private let disposeBag = DisposeBag()

    private let loadingStatus = BehaviorRelay<LoadingStatus>(value: .initial)

    init(dependency: HomeViewModelDependency) {
        self.articles = articlesRelay.asDriver()
        self.showLoading = showLoadingRelay.asSignal()
        self.hideLoading = hideLoadingRelay.asSignal()

        let fetched = Observable.merge([
            viewDidLoadRelay.asObservable(),
            pullToRefreshRelay.asObservable(),
        ])
        .do(onNext: { [self] _ in
            loadingStatus.accept(.loading)
        })
        .flatMap { dependency.repository.fetch().asObservable().materialize() }
        .share()

        fetched
            .flatMap { $0.element.map(Observable.just) ?? .empty() }
            .do(onNext: { [self] _ in
                loadingStatus.accept(.loadSuccess)
            })
            .map { $0.articles }
            .bind(to: articlesRelay)
            .disposed(by: disposeBag)

        fetched
            .flatMap { $0.error.map(Observable.just) ?? .empty() }
            .do(onNext: { [self] error in
                loadingStatus.accept(.loadFailed)
            })
            .subscribe()
            .disposed(by: disposeBag)

        loadingStatus.asObservable()
            .filter { $0 == .loading }
            .map { _ in () }
            .bind(to: showLoadingRelay)
            .disposed(by: disposeBag)

        loadingStatus.asObservable()
            .filter { $0 == .loadSuccess || $0 == .loadFailed }
            .map { _ in () }
            .bind(to: hideLoadingRelay)
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

    private let showLoadingRelay = PublishRelay<Void>()
    let showLoading: Signal<Void>

    private let hideLoadingRelay = PublishRelay<Void>()
    let hideLoading: Signal<Void>

    var input: HomeViewModelInputs { self }
    var output: HomeViewModelOutputs { self }
}
