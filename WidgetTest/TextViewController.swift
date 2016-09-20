//
//  TextViewController.swift
//  WidgetTest
//
//  Created by YueWen on 16/9/18.
//  Copyright © 2016年 YueWen. All rights reserved.
//

import UIKit

class TextViewController: UIViewController {
    
    var headTitle:String?
    

    @IBOutlet private weak var textLabel: UILabel!
    
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
    }
    

    convenience init(title:String)
    {
        self.init()
        self.textLabel.text = title
    }
    
    required init?(coder aDecoder: NSCoder) {

        super.init(coder: aDecoder);
        
    }
    

    internal override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        textLabel.text = headTitle;
    }

    internal override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction private func backButtonDidTap(_ sender: AnyObject) {
        
        //模态弹回
        self.dismiss(animated: true) { 
            
        }
        
    }
}
