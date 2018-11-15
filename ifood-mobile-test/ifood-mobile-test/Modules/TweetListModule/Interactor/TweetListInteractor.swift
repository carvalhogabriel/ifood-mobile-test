//
//  TweetListInteractor.swift
//  ifood-mobile-test
//
//  Created by Gabriel Guerrero on 11/14/18.
//  Copyright © 2018 Gabriel Guerrero. All rights reserved.
//

import Foundation
import TwitterKit

class TweetListInteractor: PresenterToInteractorTweetProtocol {

    var presenter: InteractorToPresenterTweetProtocol?
    
    func fetchTweetList(user: String, twitterClient: TWTRAPIClient) {
        var dataSource : TWTRTimelineDataSource? = nil
        dataSource = TWTRUserTimelineDataSource(screenName: user, apiClient: twitterClient)
        if dataSource != nil {
            self.presenter?.tweetListFetchedSuccess(tweets: dataSource!)
        } else {
            self.presenter?.tweetListFetchFailed()
        }
    }
}
