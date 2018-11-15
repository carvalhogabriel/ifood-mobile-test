//
//  SentimentPresenter.swift
//  ifood-mobile-test
//
//  Created by Gabriel Guerrero on 11/15/18.
//  Copyright © 2018 Gabriel Guerrero. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

class SentimentInteractor : PresenterToInteractorSentimentProtocol {
    
    var presenter: InteractorToPresenterSentimentProtocol?
    
    func fetchSentiment(tweet: String) {
        let params : Parameters = [
            "document" : [
                "type": "PLAIN_TEXT",
                "content" : tweet
            ],
            "encodingType" : "UTF8"
        ]
        
        let httpHeaders : HTTPHeaders = [
            "Content-Type" : "application/json"
        ]
        
        Alamofire.request(GOOGLE_API,
                          method: .post,
                          parameters: params,
                          encoding: JSONEncoding.default,
                          headers: httpHeaders).responseJSON { (response) in
                            
                            if (response.response?.statusCode == 200) {
                                if let json = response.result.value as AnyObject? {
                                    var arrayResponse :[NSDictionary] = []
                                    arrayResponse = [json as! NSDictionary]
                                    let arrayObject = Mapper<SentimentModel>().mapArray(JSONArray: arrayResponse as! [[String : Any]])
                                    self.presenter?.sentimentFetchedSuccess(sentimentListModel: arrayObject)
                                }
                            } else {
                                self.presenter?.sentimentFetchFailed()
                            }
                            
        }
    }

}
