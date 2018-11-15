//
//  SentientRouter.swift
//  ifood-mobile-test
//
//  Created by Gabriel Guerrero on 11/15/18.
//  Copyright © 2018 Gabriel Guerrero. All rights reserved.
//

import Foundation
import UIKit

class SentimentRouter : PresenterToRouterSentimentProtocol{
    
    static func createSentimentModule() -> SentimentViewController {
        
        let view = SentimentRouter.mainstoryboard.instantiateViewController(withIdentifier: "SentimentViewController") as! SentimentViewController
        
        let presenter : ViewToPresenterSentimentProtocol & InteractorToPresenterSentimentProtocol = SentimentPresenter()
        let interactor : PresenterToInteractorSentimentProtocol = SentimentInteractor()
        let router : PresenterToRouterSentimentProtocol = SentimentRouter()
        
        view.sentimentPresenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        
        return view
        
    }
    
    static var mainstoryboard: UIStoryboard {
        return UIStoryboard(name:"Main", bundle: Bundle.main)
    }
    
}
