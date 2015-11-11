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
        

        do {
            let queryObjects = try query.findObjects()
            for object in queryObjects {
                let message = Message(incoming: object["incoming"] as! Bool, text: object["text"] as! String, sentDate: object["sentDate"] as! NSDate)
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
            let message = messages[indexPath.row][0]
//            cell.sentDateLabel.text = "\(message.sentDate)"
            print(message.sentDate)
            cell.sentDateLabel.text = formatDate(message.sentDate)
            return cell
        } else {
            let cellIdentifier = NSStringFromClass(MessageBubbleTableViewCell)
            let cell:MessageBubbleTableViewCell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! MessageBubbleTableViewCell
//            cell = MessageBubbleTableViewCell(style: .Default, reuseIdentifier: cellIdentifier)
            let message = messages[indexPath.section][indexPath.row - 1]
            cell.configureWithMessage(message)
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

//extension ChatViewController: UITableViewDelegate,UITableViewDataSource {
//    
//}

class InputTextView: UITextView {
    
}
