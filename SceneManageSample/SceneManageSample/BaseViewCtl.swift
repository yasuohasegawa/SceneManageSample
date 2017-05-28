//
//  BaseViewCtl.swift
//  SceneManageSample
//
//  Created by HasegawaYasuo on 2017/05/28.
//  Copyright © 2017年 HasegawaYasuo. All rights reserved.
//

import UIKit
import Foundation

class BaseViewCtl: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    public func onEnter(params:Any...) { }
    
    public func onExit() { }
    
    // release memory and make sure "deinit" is called.
    deinit {
        print("deinit baseView")
    }
}
