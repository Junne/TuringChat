//
//  ChatViewController.swift
//  TuringChat
//
//  Created by baijf on 9/16/15.
//  Copyright (c) 2015 Junne. All rights reserved.
//

import UIKit
import SnapKit
let messageFontSize: CGFloat = 17
let toolBarMinHeight: CGFloat = 44
var toolBar: UIToolbar!
var textView: UITextView!
var sendButton: UIButton!

class ChatViewController: UITableViewController, UITextViewDelegate {
    

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.keyboardDismissMode = .Interactive

    }
    
    override var inputAccessoryView: UIView! {
        get {
            if toolBar == nil {
                
                toolBar = UIToolbar(frame: CGRectMake(0, 0, 0, toolBarMinHeight-0.5))
                
                textView = InputTextView(frame: CGRectZero)
                textView.backgroundColor = UIColor(white: 250/255, alpha: 1)
                textView.delegate = self
                textView.font = UIFont.systemFontOfSize(messageFontSize)
                textView.layer.borderColor = UIColor(red: 200/255, green: 200/255, blue: 205/255, alpha:1).CGColor
                textView.layer.borderWidth = 0.5
                textView.layer.cornerRadius = 5
                //            textView.placeholder = "Message"
                textView.scrollsToTop = false
                textView.textContainerInset = UIEdgeInsetsMake(4, 3, 3, 3)
                toolBar.addSubview(textView)
                
                sendButton = UIButton.buttonWithType(.System) as! UIButton
                sendButton.enabled = false
                sendButton.titleLabel?.font = UIFont.boldSystemFontOfSize(17)
                sendButton.setTitle("发送", forState: .Normal)
                sendButton.setTitleColor(UIColor(red: 142/255, green: 142/255, blue: 147/255, alpha: 1), forState: .Disabled)
                sendButton.setTitleColor(UIColor(red: 0.05, green: 0.47, blue: 0.91, alpha: 1.0), forState: .Normal)
                sendButton.contentEdgeInsets = UIEdgeInsets(top: 6, left: 6, bottom: 6, right: 6)
                sendButton.addTarget(self, action: "sendAction", forControlEvents: UIControlEvents.TouchUpInside)
                toolBar.addSubview(sendButton)
                
                // 对组件进行Autolayout设置
                textView.setTranslatesAutoresizingMaskIntoConstraints(false)
                sendButton.setTranslatesAutoresizingMaskIntoConstraints(false)
                
                textView.snp_makeConstraints({ (make) -> Void in
                    
                    make.left.equalTo(toolBar.snp_left).offset(8)
                    make.top.equalTo(toolBar.snp_top).offset(7.5)
                    make.right.equalTo(sendButton.snp_left).offset(-2)
                    make.bottom.equalTo(toolBar.snp_bottom).offset(-8)
                    
                    
                })
                sendButton.snp_makeConstraints({ (make) -> Void in
                    make.right.equalTo(toolBar.snp_right)
                    make.bottom.equalTo(toolBar.snp_bottom).offset(-4.5)
                    
                })

            }
            return toolBar
        }
    }
    
    override func canBecomeFirstResponder() -> Bool {
        return true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

class InputTextView: UITextView {
    
}
