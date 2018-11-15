//
//  SentimentViewController.swift
//  ifood-mobile-test
//
//  Created by Gabriel Guerrero on 11/15/18.
//  Copyright © 2018 Gabriel Guerrero. All rights reserved.
//

import Foundation
import UIKit
import TwitterKit
import SDWebImage

class SentimentViewController : UIViewController {
    
    // MARK: - Public Var's
    var sentimentPresenter : ViewToPresenterSentimentProtocol?
    var tweet: TWTRTweet?
    
    // MARK: - @IBOutlet's
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var usernameTweet: UILabel!
    @IBOutlet weak var userTweet: UILabel!
    @IBOutlet weak var sentimentEmoji: UILabel!
    @IBOutlet weak var sentimentLabel: UILabel!
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showProgressIndicator(view: self.view)
        self.sentimentPresenter?.startFetchingSentiment(tweet: tweet?.text ?? "")
    }
}

extension SentimentViewController : PresenterToViewSentimentProtocol {
    
    func showSentimentTweet(sentimentList: Array<SentimentModel>) {
        
        guard let sentiment = sentimentList.first else {
            return
        }
        
        self.userImage.sd_setImage(with: URL(string: (self.tweet?.author.profileImageLargeURL)!))
        self.usernameTweet.text = self.tweet?.author.name
        self.userTweet.text = self.tweet?.text
        
        self.sentimentEmoji.text = sentiment.sentiment.emoji
        self.sentimentLabel.text = sentiment.sentiment.text
        
        hideProgressIndicator(view: self.view)
    }
    
    func showError() {
        
    }
    
}
