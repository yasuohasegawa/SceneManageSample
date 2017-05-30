//
//  SceneManager.swift
//  SceneManageSample
//
//  Created by HasegawaYasuo on 2017/05/28.
//  Copyright © 2017年 HasegawaYasuo. All rights reserved.
//

import Foundation
import UIKit

final class SceneManager {
    private init() {}
    static let shared = SceneManager()
    
    private var main:MainViewCtl?
    private var uiview:UIViewController?
    private var currentScene:String?
    private var prevScene:String? = ""
    
    // TODO:history back
    
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
    public func sceneChange(_ className: String, params:Any..., isAnimate:Bool = true) {
        var baseView:BaseViewCtl? = self.uiview as? BaseViewCtl
        baseView!.onExit()
        
        if prevScene != currentScene {
            prevScene = currentScene;
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
}


