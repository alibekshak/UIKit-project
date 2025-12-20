//
//  HomePageViewModel.swift
//  UIKit-project
//
//  Created by Alibek Shakirov on 01.12.2025.
//

import Foundation

final class HomePageViewModel {
    
    weak var view: HomePageInput?
    var router: HomePageRouterInput?
    
    private let homePageService: HomePageServiceProtocol?
    
    init(homePageService: HomePageServiceProtocol?) {
        self.homePageService = homePageService
    }
    
    func getTextInfo() {
        view?.setLoading(true)
        homePageService?.getTextInfo { result in
            self.view?.setLoading(false)
            switch result {
            case .success(let response):
                self.view?.showInfo(content: response.data ?? [])
            case .failure(let error):
                self.view?.showError(error.localizedDescription)
            }
        }
    }
}

extension HomePageViewModel: HomePageOutput {
    func navigateToFavoritePage() {
        router?.routToFavoritePageView()
    }
    
    func tapToDetailInfoView(infoData: TextInfoData) {
        router?.routToDetailInfoView(info: infoData)
    }
    
    func loadInfo() {
        getTextInfo()
    }
}


