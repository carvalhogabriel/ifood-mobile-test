//
//  SentimentModel.swift
//  ifood-mobile-test
//
//  Created by Gabriel Guerrero on 11/15/18.
//  Copyright © 2018 Gabriel Guerrero. All rights reserved.
//

import Foundation
import ObjectMapper

private let DOCUMENT_SENTIMENT = "documentSentiment"
private let DOCUMENT_MAGNITUDE = "magnitude"
private let DOCUMENT_SCORE = "score"

private let LANGUAGE = "language"

private let SENTENCES = "sentences"
private let SENTENCES_TEXT = "text"
private let SENTENCES_TEXT_CONTENT = "content"
private let SENTENCES_TEXT_BEGIN_OFFSET = "beginOffset"
private let SENTENCES_SENTIMENT = "sentiment"
private let SENTENCES_SENTIMENT_MAGNITUDE = "magnitude"
private let SENTENCES_SENTIMENT_SCORE = "score"

class SentimentModel : Mappable {
    
    var sentiment : Sentiment {
        if let score = documentScore {
            if score < -0.25 {
                return .sad
            } else if score > 0.25 {
                return .happy
            }
        }
        return .neutral
    }
    
    internal var documentSentiment: NSDictionary?
    internal var documentMagnitude : Double?
    internal var documentScore : Double?
    
    internal var language: String?
    
    internal var sentences: [NSDictionary]?
    internal var sentencesText : NSDictionary?
    internal var sentencesTextContent : String?
    internal var sentencesTextbeginOffset : Int?
    internal var sentencesSentiment : NSDictionary?
    internal var sentencesSentimentMagnitude : Double?
    internal var sentencesSentimentScore : Double?
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        documentSentiment <- map[DOCUMENT_SENTIMENT]
        documentMagnitude = documentSentiment?[DOCUMENT_MAGNITUDE] as? Double
        documentScore = documentSentiment?[DOCUMENT_SCORE] as? Double
        
        language <- map[LANGUAGE]
        
        sentences <- map[SENTENCES]
        sentencesText = sentences?.first![SENTENCES_TEXT] as? NSDictionary
        sentencesTextContent = sentencesText?[SENTENCES_TEXT_CONTENT] as? String
        sentencesTextbeginOffset = sentencesText?[SENTENCES_TEXT_BEGIN_OFFSET] as? Int
        sentencesSentiment = sentences?.first![SENTENCES_SENTIMENT] as? NSDictionary
        sentencesSentimentMagnitude = sentencesSentiment?[SENTENCES_SENTIMENT_MAGNITUDE] as? Double
        sentencesSentimentScore = sentencesSentiment?[SENTENCES_SENTIMENT_SCORE] as? Double
    }
    
}

enum Sentiment {
    
    case happy
    case neutral
    case sad
    
    var emoji: String {
        switch self {
        case .happy:
            return "😃"
        case .sad:
            return "😔"
        default:
            return "😐"
        }
    }
    
    var backgroundColor: UIColor {
        switch self {
        case .happy:
            return UIColor.yellow
        case .sad:
            return UIColor.gray
        default:
            return UIColor.blue
        }
    }
    
    var textColor: UIColor {
        switch self {
        case .sad:
            return .white
        default:
            return .black
        }
    }
    
    var text: String {
        switch self {
        case .happy:
            return "Happy Tweet!"
        case .sad:
            return "Sad Tweet..."
        default:
            return "Neutral Tweet."
        }
    }
    
}
