//
//  TweetListPresenter.swift
//  ifood-mobile-test
//
//  Created by Gabriel Guerrero on 11/14/18.
//  Copyright © 2018 Gabriel Guerrero. All rights reserved.
//

import Foundation
import UIKit
import TwitterKit

class TweetListPresenter : ViewToPresenterTweetProtocol {
    
    var view: PresenterToViewTweetProtocol?
    
    var interactor: PresenterToInteractorTweetProtocol?
    
    var router: PresenterToRouterTweetProtocol?
    
    func startFetchingTweetList(user: String, twitterClient: TWTRAPIClient) {
        interactor?.fetchTweetList(user: user, twitterClient: twitterClient)
    }
    
    func showSentimentalTweetController(tweet: TWTRTweet, navigationController: UINavigationController) {
        router?.pushToSentimentalTweetScreen(tweet: tweet, navigationController:navigationController)
    }
}

extension TweetListPresenter: InteractorToPresenterTweetProtocol {
    func tweetListFetchedSuccess(tweets: TWTRTimelineDataSource) {
        view?.showTweetList(tweets: tweets)
    }
    
    func tweetListFetchFailed() {
        view?.showError()
    }
}
