//
//  TweetListRoute.swift
//  ifood-mobile-test
//
//  Created by Gabriel Guerrero on 11/14/18.
//  Copyright © 2018 Gabriel Guerrero. All rights reserved.
//

import Foundation
import UIKit
import TwitterKit

class TweetListRouter : PresenterToRouterTweetProtocol{
    
    static func createModule() -> TweetListViewController {
        
        let view = mainstoryboard.instantiateViewController(withIdentifier: "TweetListViewController") as! TweetListViewController
        
        let presenter: ViewToPresenterTweetProtocol & InteractorToPresenterTweetProtocol = TweetListPresenter()
        let interactor: PresenterToInteractorTweetProtocol = TweetListInteractor()
        let router:PresenterToRouterTweetProtocol = TweetListRouter()
        
        view.presentor = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        
        return view
        
    }
    
    static var mainstoryboard: UIStoryboard{
        return UIStoryboard(name:"Main",bundle: Bundle.main)
    }
    
    func pushToSentimentalTweetScreen(tweet: TWTRTweet, navigationController: UINavigationController) {
        let sentimentModule = SentimentRouter.createSentimentModule()
        sentimentModule.tweet = tweet
        navigationController.pushViewController(sentimentModule, animated: true)
    }
    
}
