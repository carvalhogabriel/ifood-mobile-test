//
//  TweetListProtocols.swift
//  ifood-mobile-test
//
//  Created by Gabriel Guerrero on 11/14/18.
//  Copyright © 2018 Gabriel Guerrero. All rights reserved.
//

import Foundation
import UIKit
import TwitterKit

protocol ViewToPresenterTweetProtocol: class{
    
    var view: PresenterToViewTweetProtocol? {get set}
    var interactor: PresenterToInteractorTweetProtocol? {get set}
    var router: PresenterToRouterTweetProtocol? {get set}
    func startFetchingTweetList(user: String, twitterClient: TWTRAPIClient)
    func showSentimentalTweetController(tweet: TWTRTweet, navigationController : UINavigationController)
    
}

protocol PresenterToViewTweetProtocol: class{
    func showTweetList(tweets: TWTRTimelineDataSource)
    func showError()
}

protocol PresenterToRouterTweetProtocol: class {
    static func createModule() -> TweetListViewController
    func pushToSentimentalTweetScreen(tweet: TWTRTweet, navigationController : UINavigationController)
}

protocol PresenterToInteractorTweetProtocol: class {
    var presenter:InteractorToPresenterTweetProtocol? {get set}
    func fetchTweetList(user: String, twitterClient: TWTRAPIClient)
}

protocol InteractorToPresenterTweetProtocol: class {
    func tweetListFetchedSuccess(tweets: TWTRTimelineDataSource)
    func tweetListFetchFailed()
}
