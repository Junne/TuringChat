//
//  Message.swift
//  TuringChat
//
//  Created by baijf on 9/18/15.
//  Copyright © 2015 Junne. All rights reserved.
//

import UIKit

class Message: NSObject {
    let incoming: Bool
    let text: String
    let sentDate: NSDate
    
    init(incoming: Bool, text: String, sentDate: NSDate) {
        self.incoming = incoming
        self.text = text
        self.sentDate = sentDate
    }

}
