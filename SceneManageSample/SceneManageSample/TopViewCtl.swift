//
//  TopViewCtl.swift
//  SceneManageSample
//
//  Created by HasegawaYasuo on 2017/05/28.
//  Copyright © 2017年 HasegawaYasuo. All rights reserved.
//

import UIKit
import Foundation

class TopViewCtl: BaseViewCtl {
    private var btn: UIButton!
    private var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let bWidth: CGFloat = self.view.bounds.width
        let bHeight: CGFloat = 50
        
        let posX: CGFloat = self.view.bounds.width/2 - bWidth/2
        let posY: CGFloat = 100
        
        label = UILabel(frame: CGRect(x: posX, y: posY, width: bWidth, height: bHeight))
        
        label.textColor = UIColor.black
        label.text = "TopViewCtl"
        label.textAlignment = NSTextAlignment.center
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(label)
        
        
        btn = UIButton()
        
        let btnW: CGFloat = 300
        let btnH: CGFloat = 50
        
        let bposX: CGFloat = self.view.frame.width/2 - btnW/2
        let bposY: CGFloat = self.view.frame.height/2 - btnH/2
        
        btn.frame = CGRect(x: bposX, y: bposY, width: btnW, height: btnH)
        
        btn.backgroundColor = UIColor.red
        btn.setTitle("TO SECOND VIEW", for: .normal)
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.addTarget(self, action: #selector(TopViewCtl.onTouch(sender:)), for: .touchUpInside)
        
        self.view.addSubview(btn)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    internal func onTouch(sender: UIButton) {
        SceneManager.shared.sceneChange(Scene.SecondViewCtl.rawValue)
    }
    
    override func onEnter(params:Any...) {
        // add any additional code for view enter animation
        print("\(#function) : \(#file)");
    }
    
    override func onExit() {
        // add any additional code for view leave animation
        print("\(#function) : \(#file)");
    }
    
    // release memory and make sure "deinit" is called.
    deinit {
        print(">>>>> TopViewCtl deinit call");
        btn.removeTarget(self, action: #selector(TopViewCtl.onTouch(sender:)), for: .touchUpInside)
        btn.removeFromSuperview()
        btn = nil
        
        label.removeFromSuperview()
        label = nil
    }
}
