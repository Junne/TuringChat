//
//  ChatViewController.swift
//  TuringChat
//
//  Created by Junne on 9/16/15.
//  Copyright (c) 2015 Junne. All rights reserved.
//

import UIKit
import SnapKit
import Parse 
import Alamofire


class ChatViewController: UITableViewController, UITextViewDelegate {
    
    var textView: UITextView!
    let messageFontSize: CGFloat = 17
    let toolBarMinHeight: CGFloat = 44
    var toolBar: UIToolbar!
    var sendButton: UIButton!
    var messages:[[Message]] = [[]]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.registerClass(MessageSentDateTableViewCell.self, forCellReuseIdentifier: NSStringFromClass(MessageSentDateTableViewCell))
        tableView.registerClass(MessageBubbleTableViewCell.self, forCellReuseIdentifier: NSStringFromClass(MessageBubbleTableViewCell))
        
        self.tableView.keyboardDismissMode = .Interactive
        self.tableView.estimatedRowHeight = 44
        self.tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: toolBarMinHeight, right: 0)
        self.tableView.separatorStyle = .None
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        
        initData()
        
        let notificationCenter = NSNotificationCenter.defaultCenter()
        notificationCenter.addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        notificationCenter.addObserver(self, selector: "keyboardDidShow:", name: UIKeyboardDidShowNotification, object: nil)
        
//        messages = [
//            [
//                Message(incoming: true, text: "你叫什么名字？", sentDate: NSDate(timeIntervalSinceNow: -12*60*60*24)),
//                Message(incoming: false, text: "我叫灵灵，聪明又可爱的灵灵", sentDate: NSDate(timeIntervalSinceNow:-12*60*60*24))
//            ],
//            [
//                Message(incoming: true, text: "你爱不爱我？", sentDate: NSDate(timeIntervalSinceNow: -6*60*60*24 - 200)),
//                Message(incoming: false, text: "爱你么么哒", sentDate: NSDate(timeIntervalSinceNow: -6*60*60*24 - 100))
//            ],
//            [
//                Message(incoming: true, text: "北京今天天气", sentDate: NSDate(timeIntervalSinceNow: -60*60*18)),
//                Message(incoming: false, text: "北京:08/30 周日,19-27° 21° 雷阵雨转小雨-中雨 微风小于3级;08/31 周一,18-26° 中雨 微风小于3级;09/01 周二,18-25° 阵雨 微风小于3级;09/02 周三,20-30° 多云 微风小于3级", sentDate: NSDate(timeIntervalSinceNow: -60*60*18))
//            ],
//            [
//                Message(incoming: true, text: "你在干嘛", sentDate: NSDate(timeIntervalSinceNow: -60)),
//                Message(incoming: false, text: "我会逗你开心啊", sentDate: NSDate(timeIntervalSinceNow: -65))
//            ],
//        ]
        

    }
    
    
    func initData() {
        var index = 0
        var section = 0
        var currentDate:NSDate?
        
        let query = PFQuery(className: "Messages")
        query.orderByAscending("sentDate")
        
//        query.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
//            for object in objects! {
//                let message = Message(incoming: object["incoming"] as! Bool, text: object["text"] as! String, sentDate: object["sentDate"] as! NSDate)
//                if index == 0 {
//                    currentDate = message.sentDate
//                }
//                let timeIntervel = message.sentDate.timeIntervalSinceDate(currentDate!)
//                
//                if timeIntervel < 120 {
//                    self.messages[section].append(message)
//                } else {
//                    section++
//                    self.messages.append([message])
//                }
//                currentDate = message.sentDate
//                index++
//            }
//        }
        
//        query.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
//            
//            if error == nil {
//                if objects!.count > 0 {
//                    
//                    do {
//                        let queryObjects = try query.findObjects()
//                        for object in queryObjects {
//                            
//
//                            
//                            let message = Message(incoming: object["incoming"] as! Bool, text: object["text"] as! String, sentDate: object["sentDate"] as! NSDate)
//                            if let url = object["url"] as? String {
//                                message.url = url
//                            }
//                            if index == 0 {
//                                currentDate = message.sentDate
//                            }
//                            let timeIntervel = message.sentDate.timeIntervalSinceDate(currentDate!)
//                            
//                            if timeIntervel < 120 {
//                                self.messages[section].append(message)
//                            } else {
//                                section++
//                                self.messages.append([message])
//                            }
//                            
//                            currentDate = message.sentDate
//                            if index == objects!.count - 1 {
//                                dispatch_async(dispatch_get_main_queue(), { () -> Void in
//                                    self.tableView.reloadData()
//                                })
//                            }
//                            index++
//                        }
//                    } catch _ {
//                        
//                    }
//                    
//                }
//            }
//        }

        do {
            let queryObjects = try query.findObjects()
            for object in queryObjects {
                let message = Message(incoming: object["incoming"] as! Bool, text: object["text"] as! String, sentDate: object["sentDate"] as! NSDate)
                if let url = object["url"] as? String {
                    message.url = url
                }
                if index == 0 {
                    currentDate = message.sentDate
                }
                let timeIntervel = message.sentDate.timeIntervalSinceDate(currentDate!)
                
                if timeIntervel < 120 {
                    messages[section].append(message)
                } else {
                    section++
                    messages.append([message])
                }

                currentDate = message.sentDate
                index++
               }
        } catch _ {
            
        }
        
//        query.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
//            if error == nil {
//                
//                if objects!.count > 0 {
//                    
//                    for object in objects as! [PFObject] {
//                        
//                        if index == objects!.count - 1{
//                            
//                            dispatch_async(dispatch_get_main_queue(), { () -> Void in
//                                
//                                self.tableView.reloadData()
//                                
//                            })
//                            
//                        }
//                        
//                        let message = Message(incoming: object["incoming"] as! Bool, text: object["text"] as! String, sentDate: object["sentDate"] as! NSDate)
//                        
//                        if let url = object["url"] as? String{
//                            
//                            message.url = url
//                            
//                        }
//                        if index == 0{
//                            
//                            currentDate = message.sentDate
//                            
//                        }
//                        let timeInterval = message.sentDate.timeIntervalSinceDate(currentDate!)
//                        
//                        
//                        if timeInterval < 120{
//                            
//                            self.messages[section].append(message)
//                            
//                            
//                        }else{
//                            
//                            section++
//                            
//                            self.messages.append([message])
//                            
//                        }
//                        currentDate = message.sentDate
//                        
//                        index++
//                        
//                    }
//                }
//                
//            }else{
//                println("error \(error?.userInfo)")
//            }
//        }
        
//        for object in query.findObjects() {
//            
//            let message = Message(incoming: object["incoming"] as! Bool, text: object["text"] as! String, sentDate: object["sentDate"] as! NSDate)
//            if index == 0 {
//                currentDate = message.sentDate
//            }
//            let timeIntervel = message.sentDate.timeIntervalSinceDate(currentDate!)
//            
//            if timeIntervel < 120 {
//                messages[section].append(message)
//            } else {
//                section++
//                messages.append([message])
//            }
//            currentDate = message.sentDate
//            index++
//        
//         }
    }
    
    func keyboardWillShow(notification: NSNotification) {
        
        let userInfo = notification.userInfo as NSDictionary!
        let frameNew = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue()
        let insetNewBottom = tableView.convertRect(frameNew, fromView: nil).height
        let insetOld = tableView.contentInset
        let insetChange = insetNewBottom - insetOld.bottom
        let overflow = tableView.contentSize.height - (tableView.frame.height-insetOld.top-insetOld.bottom)
        
        let duration = (userInfo[UIKeyboardAnimationDurationUserInfoKey] as! NSNumber).doubleValue
        let animations: (() -> Void) = {
            if !(self.tableView.tracking || self.tableView.decelerating) {
                // 根据键盘位置调整Inset
                if overflow > 0 {
                    self.tableView.contentOffset.y += insetChange
                    if self.tableView.contentOffset.y < -insetOld.top {
                        self.tableView.contentOffset.y = -insetOld.top
                    }
                } else if insetChange > -overflow {
                    self.tableView.contentOffset.y += insetChange + overflow
                }
            }
        }
        if duration > 0 {
            let options = UIViewAnimationOptions(rawValue: UInt((userInfo[UIKeyboardAnimationCurveUserInfoKey] as! NSNumber).integerValue << 16)) // http://stackoverflow.com/a/18873820/242933
            UIView.animateWithDuration(duration, delay: 0, options: options, animations: animations, completion: nil)
        } else {
            animations()
        }
    }
    
    func keyboardDidShow(notification: NSNotification) {
        let userInfo = notification.userInfo as NSDictionary!
        let frameNew = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue()
        let insetNewBottom = tableView.convertRect(frameNew, fromView: nil).height
        
        //根据键盘高度设置Inset
        let contentOffsetY = tableView.contentOffset.y
        tableView.contentInset.bottom = insetNewBottom
        tableView.scrollIndicatorInsets.bottom = insetNewBottom
        // 优化，防止键盘消失后tableview有跳跃
        if self.tableView.tracking || self.tableView.decelerating {
            tableView.contentOffset.y = contentOffsetY
        }
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
                
                sendButton = UIButton(type:.System) 
                sendButton.enabled = false
                sendButton.titleLabel?.font = UIFont.boldSystemFontOfSize(17)
                sendButton.setTitle("发送", forState: .Normal)
                sendButton.setTitleColor(UIColor(red: 142/255, green: 142/255, blue: 147/255, alpha: 1), forState: .Disabled)
                sendButton.setTitleColor(UIColor(red: 0.05, green: 0.47, blue: 0.91, alpha: 1.0), forState: .Normal)
                sendButton.contentEdgeInsets = UIEdgeInsets(top: 6, left: 6, bottom: 6, right: 6)
                sendButton.addTarget(self, action: "sendAction", forControlEvents: UIControlEvents.TouchUpInside)
                toolBar.addSubview(sendButton)
                
                // 对组件进行Autolayout设置

                textView.translatesAutoresizingMaskIntoConstraints = false
                sendButton.translatesAutoresizingMaskIntoConstraints = false
                
                textView.snp_makeConstraints(closure: { (make) -> Void in
                    make.left.equalTo(toolBar.snp_left).offset(8)
                    make.top.equalTo(toolBar.snp_top).offset(7.5)
                    make.right.equalTo(sendButton.snp_left).offset(-2)
                    make.bottom.equalTo(toolBar.snp_bottom).offset(-8)
                })

                sendButton.snp_makeConstraints(closure: { (make) -> Void in
                    make.right.equalTo(toolBar.snp_right)
                    make.bottom.equalTo(toolBar.snp_bottom).offset(-4.5)
                    
                })

            }
            return toolBar
        }
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cellIdentifier = NSStringFromClass(MessageSentDateTableViewCell)
            let cell:MessageSentDateTableViewCell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! MessageSentDateTableViewCell
//            cell = MessageSentDateTableViewCell(style: .Default, reuseIdentifier: cellIdentifier)
            if messages.count > 0 {
                let message = messages[indexPath.row][0]
                //            cell.sentDateLabel.text = "\(message.sentDate)"
                print(message.sentDate)
                cell.sentDateLabel.text = formatDate(message.sentDate)
            }

            return cell
        } else {
            let cellIdentifier = NSStringFromClass(MessageBubbleTableViewCell)
            let cell:MessageBubbleTableViewCell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! MessageBubbleTableViewCell
//            cell = MessageBubbleTableViewCell(style: .Default, reuseIdentifier: cellIdentifier)
            if messages.count > 0 {
                let message = messages[indexPath.section][indexPath.row - 1]
                cell.configureWithMessage(message)
            }
            return cell
        }
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return messages.count
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages[section].count + 1
    }
    
    override func canBecomeFirstResponder() -> Bool {
        return true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    func formatDate(date: NSDate) -> String {
//        let calendar = NSCalendar.currentCalendar()
//        let dateFormatter = NSDateFormatter()
//        dateFormatter.locale = NSLocale(localeIdentifier: "zh_CN")
//        
//        let last18hours = (-18*60*60 < date.timeIntervalSinceNow)
//        let isToday = calendar.isDateInToday(date)
//        let isLast7Days = (calendar.compareDate(NSDate(timeIntervalSinceNow: -70*4*60*60), toDate: date, toUnitGranularity: .Day) == NSComparisonResult.OrderedAscending)
//        
//        if last18hours || isToday {
//            dateFormatter.dateFormat = "a HH:mm"
//        } else if isLast7Days {
//            dateFormatter.dateFormat = "MM月dd日 a HH:mm EEEE"
//        } else {
//            dateFormatter.dateFormat = "YYYY年MM月dd日 a HH:mm"
//        }
//        return dateFormatter.stringFromDate(date)
//    }
    
    func formatDate(date: NSDate) -> String {
        let calendar = NSCalendar.currentCalendar()
        let dateFormatter = NSDateFormatter()
        dateFormatter.locale = NSLocale(localeIdentifier: "zh_CN")
        
        let last18hours = (-18*60*60 < date.timeIntervalSinceNow)
        let isToday = calendar.isDateInToday(date)
        let isLast7Days = (calendar.compareDate(NSDate(timeIntervalSinceNow: -7*24*60*60), toDate: date, toUnitGranularity: .Day) == NSComparisonResult.OrderedAscending)
        
        if last18hours || isToday {
            dateFormatter.dateFormat = "a HH:mm"
        } else if isLast7Days {
            dateFormatter.dateFormat = "MM月dd日 a HH:mm EEEE"
        } else {
            dateFormatter.dateFormat = "YYYY年MM月dd日 a HH:mm"
            
        }
        return dateFormatter.stringFromDate(date)
    }


}

extension ChatViewController {
    func sendAction() {
        let inputMessage = Message(incoming: false, text: textView.text, sentDate: NSDate())
        saveMessage(inputMessage)
        messages.append([inputMessage])
        let question = textView.text
        textView.text = nil
        updateTextViewHeight()
        sendButton.enabled = false
        
        let lastSection = tableView.numberOfSections
        tableView.beginUpdates()
        tableView.insertSections(NSIndexSet(index: lastSection), withRowAnimation: .Automatic)
        tableView.insertRowsAtIndexPaths([NSIndexPath(forRow: 0, inSection: lastSection),NSIndexPath(forRow: 1, inSection: lastSection)], withRowAnimation: .Automatic)
        tableView.endUpdates()
        tableViewScrollToBottomAnimated(true)

        
        Alamofire.request(.GET, NSURL(string: api_url)!, parameters: ["key":api_key,"info":question,"userid":userId]).responseJSON(options: NSJSONReadingOptions.MutableContainers) { (_,_,data) -> Void in
          
        if let text = data.value!.objectForKey("text") as? String{
            if let url = data.value!.objectForKey("url") as? String {
                let message = Message(incoming: true, text: text+"\n(点击该消息打开查看", sentDate: NSDate())
                message.url = url
                self.saveMessage(message)
                self.messages[lastSection].append(message)
            } else {
                let message = Message(incoming: true, text:text, sentDate: NSDate())
                self.saveMessage(message)
                self.messages[lastSection].append(message)
            }
            self.tableView.beginUpdates()
            self.tableView.insertRowsAtIndexPaths([
                NSIndexPath(forRow: 2, inSection: lastSection)
                ], withRowAnimation: .Automatic)
            self.tableView.endUpdates()
            self.tableViewScrollToBottomAnimated(true)
        }
            
//            if error == nil {
//                if let text = data!.objectForKey("text") as? String{
//                    self.messages[lastSection].append(Message(incoming: true, text:text, sentDate: NSDate()))
//                    self.tableView.beginUpdates()
//                    self.tableView.insertRowsAtIndexPaths([
//                        NSIndexPath(forRow: 2, inSection: lastSection)
//                        ], withRowAnimation: .Automatic)
//                    self.tableView.endUpdates()
//                    self.tableViewScrollToBottomAnimated(true)
//                }
//            }else{
//                println("Error occured! \(error?.userInfo)")
//            }
        }
        
    }
    
    func tableViewScrollToBottomAnimated(animated:Bool) {
        let numberOfSections = messages.count
        let numberOfRows = messages[numberOfSections - 1].count
        if numberOfRows > 0 {
            tableView.scrollToRowAtIndexPath(NSIndexPath(forRow: numberOfRows, inSection: numberOfSections - 1), atScrollPosition: .Bottom, animated: animated)
        }
    }
    
    func updateTextViewHeight() {
//        let oldHeight = textView.frame.height
//        let maxHeight = UIInterfaceOrientationIsPortrait(interfaceOrientation) ? textViewMaxHeight.portrait : textViewMaxHeight.landscape
//        textView.
//        var newHeight = min(textView.sizeThatFits(CGSize(width: textView.frame.width, height: CGFloat.max)).height, maxHeight)
//        #if arch(x86_64) || arch(arm64)
//            newHeight = ceil(newHeight)
//        #else
//            newHeight = CGFloat(ceilf(newHeight.native))
//        #endif
//        if newHeight != oldHeight {
//            toolBar.frame.size.height = newHeight+8*2-0.5
//        }
    }
    
    func textViewDidChange(textView: UITextView) {
        updateTextViewHeight()
        sendButton.enabled = textView.hasText()
    }
    
    
    func saveMessage(message:Message) {
        let saveObject = PFObject(className: "Messages")
        saveObject["incoming"] = message.incoming
        saveObject["text"] = message.text
        saveObject["sentDate"] = message.sentDate
        saveObject["url"] = message.url
        saveObject.saveEventually { (success, error) -> Void in
            if success{
                print("消息保存成功!")
            }else{
                print("消息保存失败! \(error)")
            }
        }
    }
    
    
    override func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        let selectedCell = tableView.cellForRowAtIndexPath(indexPath) as! MessageBubbleTableViewCell
        if selectedCell.url != "" {
            let url = NSURL(string: selectedCell.url)
            UIApplication.sharedApplication().openURL(url!)
        }
        return nil
    }
}

class InputTextView: UITextView {
    
}
