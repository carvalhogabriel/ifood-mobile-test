//
//  SentimentProtocols.swift
//  ifood-mobile-test
//
//  Created by Gabriel Guerrero on 11/15/18.
//  Copyright © 2018 Gabriel Guerrero. All rights reserved.
//

import Foundation

protocol ViewToPresenterSentimentProtocol: class{
    
    var view: PresenterToViewSentimentProtocol? {get set}
    var interactor: PresenterToInteractorSentimentProtocol? {get set}
    var router: PresenterToRouterSentimentProtocol? {get set}
    func startFetchingSentiment(tweet: String)
    
}

protocol PresenterToViewSentimentProtocol: class{
    func showSentimentTweet(sentimentList: Array<SentimentModel>)
    func showError()
}

protocol PresenterToRouterSentimentProtocol: class {
    static func createSentimentModule() -> SentimentViewController
}

protocol PresenterToInteractorSentimentProtocol: class {
    var presenter:InteractorToPresenterSentimentProtocol? {get set}
    func fetchSentiment(tweet: String)
}

protocol InteractorToPresenterSentimentProtocol: class {
    func sentimentFetchedSuccess(sentimentListModel: Array<SentimentModel>)
    func sentimentFetchFailed()
}
