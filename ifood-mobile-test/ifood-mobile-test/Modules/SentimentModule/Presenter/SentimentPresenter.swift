//
//  SentimentPresenter.swift
//  ifood-mobile-test
//
//  Created by Gabriel Guerrero on 11/15/18.
//  Copyright © 2018 Gabriel Guerrero. All rights reserved.
//

import Foundation

class SentimentPresenter : ViewToPresenterSentimentProtocol {
    
    var view: PresenterToViewSentimentProtocol?
    
    var interactor: PresenterToInteractorSentimentProtocol?
    
    var router: PresenterToRouterSentimentProtocol?
    
    func startFetchingSentiment(tweet: String) {
        interactor?.fetchSentiment(tweet: tweet)
    }
    
}

extension SentimentPresenter : InteractorToPresenterSentimentProtocol {
    
    func sentimentFetchedSuccess(sentimentListModel: Array<SentimentModel>) {
        view?.showSentimentTweet(sentimentList: sentimentListModel)
    }
    
    func sentimentFetchFailed() {
        view?.showError()
    }
    
}
