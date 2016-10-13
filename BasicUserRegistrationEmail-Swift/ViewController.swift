//
//  ViewController.swift
//  BasicUserRegistrationEmail-Swift
//
//  Created by Ayrton Alves on 12/10/16.
//  Copyright © 2016 back4app. All rights reserved.
//

import UIKit
import Parse

class ViewController: UIViewController {

    @IBOutlet weak var textEmail: UITextField!
    @IBOutlet weak var textPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    func alert(message: NSString, title: NSString) {
        let alert = UIAlertController(title: title as String, message: message as String, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
    }

    @IBAction func login(_ sender: AnyObject) {
        // Retrieving the info from the text fields
        let email = textEmail.text
        let password = textPassword.text
        
        // Defining the user object
        PFUser.logInWithUsername(inBackground: email!, password: password!, block: {(user, error) -> Void in
            if let error = error as NSError? {
                let errorString = error.userInfo["error"] as? NSString
                self.alert(message: errorString!, title: "Error")
            }
            else {
                let emailVerified = user?["emailVerified"];
                if emailVerified as! Bool == true {
                    self.alert(message: "Welcome back!", title: "Login")
                }
                else {
                    self.alert(message: "Please check your email inbox", title: "Login")
                    PFUser.logOut()
                }
            }
        })
    }
    
    @IBAction func register(_ sender: AnyObject) {
        // Retrieving the info from the text fields
        let email = textEmail.text
        let password = textPassword.text
        
        // Defining the user object
        let user = PFUser()
        user.username = email
        user.password = password
        user.email = email
        
        // Signing up using the Parse API
        user.signUpInBackground {
            (success, error) -> Void in
            if let error = error as NSError? {
                let errorString = error.userInfo["error"] as? NSString
                self.alert(message: errorString!, title: "Error")
                
            } else {
                self.alert(message: "Registered successfully! Please check your email inbox.", title: "Register")
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

