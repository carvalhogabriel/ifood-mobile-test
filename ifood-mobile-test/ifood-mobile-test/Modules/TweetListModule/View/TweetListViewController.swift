//
//  ViewController.swift
//  ifood-mobile-test
//
//  Created by Gabriel Guerrero on 11/13/18.
//  Copyright © 2018 Gabriel Guerrero. All rights reserved.
//

import UIKit
import SDWebImage
import TwitterKit

class TweetListViewController: TWTRTimelineViewController {

    // MARK: - Public Var's
    var presentor : ViewToPresenterTweetProtocol?
    
    // MARK: - Private Var's
    private let searchController = UISearchController(searchResultsController: nil)
    private var lastSearchText: String?
    private var searchTimer: Timer?
    private let defaultUsername = "ifood"
    private let segues = (sentiment: "SentimentSegue")
    
    private lazy var twitterClient: TWTRAPIClient = {
        return TWTRAPIClient()
    }()
    
    // MARK: - @IBOutlet's
    @IBOutlet weak var tweetTableView: UITableView!
    
    
    // MARK: - Private Method's
    private func setupTwitterKitDelegate() {
        self.tweetViewDelegate = self
        self.timelineDelegate = self
    }
    
    private func setupSearch() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        
        searchController.searchBar.placeholder = "e.g. 'iFood'"
        searchController.searchBar.text = self.defaultUsername
        
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
    }
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupTwitterKitDelegate()
        self.setupSearch()
        presentor?.startFetchingTweetList(user: self.defaultUsername, twitterClient: self.twitterClient)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

// MARK: - View Protocols
extension TweetListViewController : PresenterToViewTweetProtocol {
    func showTweetList(tweets: TWTRTimelineDataSource) {
        self.dataSource = tweets
        self.tweetTableView.reloadData()
    }
    
    func showError() {
        let alert = UIAlertController(title: "Alert", message: "Problem Fetching Tweet List", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
}

// MARK: - Search Results
extension TweetListViewController : UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = self.searchController.searchBar.text, text.count > 0, text != lastSearchText else { return }
        
        lastSearchText = nil
        
        searchTimer?.invalidate()
        searchTimer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { [weak self] timer in
            self?.presentor?.startFetchingTweetList(user: text, twitterClient: (self?.twitterClient)!)
        }
    }

}

// MARK: - Tweet View Delegate
extension TweetListViewController : TWTRTweetViewDelegate {
    
    func tweetView(tweetView: TWTRTweetView, didSelectTweet tweet: TWTRTweet) {
        self.presentor?.showSentimentalTweetController(tweet: tweet, navigationController: self.navigationController!)
    }
    
    func tweetView(_ tweetView: TWTRTweetView, didTap url: URL) {
        self.presentor?.showSentimentalTweetController(tweet: tweetView.tweet, navigationController: self.navigationController!)
    }
    
    func tweetView(_ tweetView: TWTRTweetView, didTap tweet: TWTRTweet) {
        self.presentor?.showSentimentalTweetController(tweet: tweet, navigationController: self.navigationController!)
    }
    
    func tweetView(_ tweetView: TWTRTweetView, didTap image: UIImage, with imageURL: URL) {
        self.presentor?.showSentimentalTweetController(tweet: tweetView.tweet, navigationController: self.navigationController!)
    }
    
    func tweetView(_ tweetView: TWTRTweetView, didTapVideoWith videoURL: URL) {
        self.presentor?.showSentimentalTweetController(tweet: tweetView.tweet, navigationController: self.navigationController!)
    }
    
    func tweetView(_ tweetView: TWTRTweetView, didTapProfileImageFor user: TWTRUser) {
        self.presentor?.showSentimentalTweetController(tweet: tweetView.tweet, navigationController: self.navigationController!)
    }
    
}

// MARK: - Time Line Delegate
extension TweetListViewController: TWTRTimelineDelegate {
    
    func timelineDidBeginLoading(_ timeline: TWTRTimelineViewController) {
    }
    
    func timeline(_ timeline: TWTRTimelineViewController, didFinishLoadingTweets tweets: [Any]?, error: Error?) {
        self.tweetTableView.reloadData()
    }
    
}
