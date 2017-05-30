//
//  SceneManager.swift
//  SceneManageSample
//
//  Created by HasegawaYasuo on 2017/05/28.
//  Copyright © 2017年 HasegawaYasuo. All rights reserved.
//

import Foundation
import UIKit
import Bond
import ReactiveKit

final class SceneManager {
    private init() {}
    static let shared = SceneManager()
    
    private var main:MainViewCtl?
    private var uiview:UIViewController?
    private var currentScene:String?
    private var prevScene:String? = ""
    
    private let HISTORY_STACK_LEVEL = 10
    var history = Observable<[HistoryModel]?>([])
    
    public func setUp(_ className: String, viewCtl:MainViewCtl) {
        main = viewCtl
        uiview = getUIViewCtl(className)
        currentScene = className;
        main?.present(uiview!, animated: false, completion: {
        })
    }
    
    // create class from string
    private func stringClassFromString(_ className: String) -> AnyClass! {
        let namespace = Bundle.main.infoDictionary!["CFBundleExecutable"] as! String;
        let cls: AnyClass = NSClassFromString("\(namespace).\(className)")!;
        return cls;
    }
    
    // get UIViewController from string class
    private func getUIViewCtl(_ className: String) -> UIViewController{
        let aClass = self.stringClassFromString(className) as! UIViewController.Type
        let viewController = aClass.init()
        return viewController
    }
    
    // managing scene change
    public func sceneChange(_ className: String, params:Any..., isAnimate:Bool = true, isHistoryStack:Bool = true) {
        var baseView:BaseViewCtl? = self.uiview as? BaseViewCtl
        baseView!.onExit()
        
        if prevScene != currentScene {
            prevScene = currentScene;
            
            if isHistoryStack {
                let historyNum = (history.value?.count)!
                if historyNum <= HISTORY_STACK_LEVEL {
                    if historyNum == HISTORY_STACK_LEVEL {
                        history.value?.remove(at: historyNum-1)
                    }
                    
                    let historyModel = HistoryModel()
                    historyModel.scene = prevScene
                    historyModel.params = params
                    historyModel.isAnimate = isAnimate
                    history.value?.insert(historyModel, at: 0)
                }
            }
        }
        
        currentScene = className;
        
        main!.dismiss(animated: false, completion: {
            // If you want view leave animation, please customize below code.
            self.uiview?.view.removeFromSuperview()
            self.uiview?.removeFromParentViewController()
            self.uiview?.view = nil
            self.uiview = nil
            
            self.uiview = self.getUIViewCtl(className)
            
            // This is the default transition options that UIViewController has, but you can create your own transition.
            //self.uiview!.modalTransitionStyle = .coverVertical
            //self.uiview!.modalTransitionStyle = .crossDissolve
            //self.uiview!.modalTransitionStyle = .flipHorizontal
            
            self.uiview!.modalTransitionStyle = .crossDissolve
            
            baseView = self.uiview as? BaseViewCtl
            self.main!.present(self.uiview!, animated: isAnimate, completion: {
                baseView!.onEnter(params: params)
            })
            
        })
    }
    
    public func prevScene(params:Any..., isAnimate:Bool = true) {
        sceneChange(prevScene!, params: params, isAnimate)
    }
    
    public func historyBack() {
        let historyModel = history.value?.remove(at: 0)
        sceneChange((historyModel?.scene)!, params: historyModel?.params, historyModel?.isAnimate, isHistoryStack: false)
    }
}


