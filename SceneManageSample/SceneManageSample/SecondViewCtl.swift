//
//  SecondViewCtl.swift
//  SceneManageSample
//
//  Created by HasegawaYasuo on 2017/05/28.
//  Copyright © 2017年 HasegawaYasuo. All rights reserved.
//

import UIKit
import Foundation

class SecondViewCtl: BaseViewCtl {
    private var btn: UIButton!
    private var btn2: UIButton!
    private var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let bWidth: CGFloat = view.bounds.width
        let bHeight: CGFloat = 50
        
        let posX: CGFloat = self.view.bounds.width/2 - bWidth/2
        let posY: CGFloat = 100
        
        label = UILabel(frame: CGRect(x: posX, y: posY, width: bWidth, height: bHeight))
        
        label.textColor = UIColor.black
        label.text = "SecondViewCtl"
        label.textAlignment = NSTextAlignment.center
        view.backgroundColor = UIColor.white
        view.addSubview(label)
        
        
        btn = UIButton()
        
        let btnW: CGFloat = 300
        let btnH: CGFloat = 50
        
        let bposX: CGFloat = self.view.frame.width/2 - btnW/2
        let bposY: CGFloat = self.view.frame.height/2 - btnH/2
        
        btn.frame = CGRect(x: bposX, y: bposY, width: btnW, height: btnH)
        btn.tag = 0
        btn.backgroundColor = UIColor.red
        btn.setTitle("TO THIRD VIEW", for: .normal)
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.addTarget(self, action: #selector(SecondViewCtl.onTouch(sender:)), for: .touchUpInside)
        
        self.view.addSubview(btn)
        
        btn2 = UIButton()
        btn2.frame = CGRect(x: bposX, y: bposY+100, width: btnW, height: btnH)
        btn2.tag = 1
        btn2.backgroundColor = UIColor.red
        btn2.setTitle("BACK TO TOP", for: .normal)
        btn2.setTitleColor(UIColor.white, for: .normal)
        btn2.addTarget(self, action: #selector(SecondViewCtl.onTouch(sender:)), for: .touchUpInside)
        
        self.view.addSubview(btn2)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    internal func onTouch(sender: UIButton) {
        var target:String = Scene.ThirdViewCtl.rawValue
        if sender.tag ==  1 {
            target = Scene.TopViewCtl.rawValue
        }
        
        SceneManager.shared.sceneChange(target)
    }
    
    override func onEnter(params:Any...) {
        // add any additional code for view enter animation
        print("\(#function) : \(#file)");
        for key in params {
            print("\(key)")
        }
    }
    
    override func onExit() {
        // add any additional code for view leave animation
        print("\(#function) : \(#file)");
    }
    
    // release memory and make sure "deinit" is called.
    deinit {
        print(">>>>> deinit SecondViewCtl");
        
        btn.removeTarget(self, action: #selector(SecondViewCtl.onTouch(sender:)), for: .touchUpInside)
        btn.removeFromSuperview()
        btn = nil
        btn2.removeTarget(self, action: #selector(SecondViewCtl.onTouch(sender:)), for: .touchUpInside)
        btn2.removeFromSuperview()
        btn2 = nil
        
        label.removeFromSuperview()
        label = nil
    }
}
