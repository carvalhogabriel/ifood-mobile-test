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
    
    // MARK: - Private Var's
    private var sentimentList : Array<SentimentModel> = Array()
    
    // MARK: - @IBOutlet's
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var usernameTweet: UILabel!
    @IBOutlet weak var userTweet: UILabel!
    @IBOutlet weak var sentimentEmoji: UILabel!
    @IBOutlet weak var sentimentLabel: UILabel!
    @IBOutlet weak var sentimentStackView: UIStackView!
    
    // MARK: - Private Method's
    private func setupUI() {
        if (self.sentimentList.isEmpty) {
            self.userImage.isHidden = true
            self.usernameTweet.isHidden = true
            self.userTweet.isHidden = true
            self.sentimentStackView.isHidden = true
        } else {
            self.userImage.isHidden = false
            self.usernameTweet.isHidden = false
            self.userTweet.isHidden = false
            self.sentimentStackView.isHidden = false
        }
    }
    
    private func circleImageView() {
        self.userImage.layer.borderWidth = 0.1
        self.userImage.layer.masksToBounds = false
        self.userImage.layer.borderColor = UIColor.black.cgColor
        self.userImage.layer.cornerRadius = self.userImage.frame.height/2
        self.userImage.clipsToBounds = true
    }
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showProgressIndicator(view: self.view)
        self.sentimentPresenter?.startFetchingSentiment(tweet: tweet?.text ?? "")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setupUI()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension SentimentViewController : PresenterToViewSentimentProtocol {
    
    func showSentimentTweet(sentimentList: Array<SentimentModel>) {
        self.sentimentList = sentimentList
        
        guard let sentiment = self.sentimentList.first else {
            return
        }
        
        self.userImage.sd_setImage(with: URL(string: (self.tweet?.author.profileImageLargeURL)!))
        self.circleImageView()
        
        self.usernameTweet.text = self.tweet?.author.name
        self.userTweet.text = self.tweet?.text
        
        self.sentimentEmoji.text = sentiment.sentiment.emoji
        self.sentimentLabel.text = sentiment.sentiment.text
        self.sentimentLabel.backgroundColor = sentiment.sentiment.backgroundColor
        self.sentimentLabel.textColor = sentiment.sentiment.textColor
        
        self.setupUI()

        hideProgressIndicator(view: self.view)
    }
    
    func showError() {
        self.sentimentStackView.isHidden = false
        self.sentimentEmoji.text = "😞"
        self.sentimentLabel.text = "Error to load sentiment"
    }
    
}
