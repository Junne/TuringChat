//
//  SignUpViewController.swift
//  TuringChat
//
//  Created by Junne on 12/3/15.
//  Copyright © 2015 Junne. All rights reserved.
//

import UIKit
import ParseUI

class SignUpViewController: PFSignUpViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.signUpView?.logo = UIImageView(image: UIImage(named: "logo"))

        // Do any additional setup after loading the view.
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
