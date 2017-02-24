//
//  ViewController.swift
//  ParseChat
//
//  Created by Sandeep Raghunandhan on 2/23/17.
//  Copyright © 2017 Sandeep Raghunandhan. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func login(_ sender: UIButton) {
        var user = PFUser()
        user.username = email.text
        user.email = email.text
        user.password = password.text
        PFUser.logInWithUsername(inBackground: user.username!, password: user.password!) { (user: PFUser?, error: Error?) in
            if let error = error {
                let alertController = UIAlertController(title: "Title", message: "Logged In Error!", preferredStyle: .alert)
                // create a cancel action
                let cancelAction = UIAlertAction(title: "OK", style: .cancel) { (action) in
                    // handle cancel response here. Doing nothing will dismiss the view.
                }
                // add the cancel action to the alertController
                alertController.addAction(cancelAction)
                
                // create an OK action
                let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
                    // handle response here.
                }
                // add the OK action to the alert controller
                alertController.addAction(OKAction)
                self.present(alertController, animated: true) {
                    
                }

            }
            else {
                self.performSegue(withIdentifier: "login", sender: nil)
                print("logged in")
            }
        }
        

    }

    @IBAction func signUp(_ sender: Any) {
        var user = PFUser()
        user.username = email.text
        user.email = email.text
        user.password = password.text
        
        user.signUpInBackground { (succeed: Bool, error: Error?) in
            if let error = error {
                let alertController = UIAlertController(title: "Title", message: "Signed Up Error!", preferredStyle: .alert)
                // create a cancel action
                let cancelAction = UIAlertAction(title: "OK", style: .cancel) { (action) in
                    // handle cancel response here. Doing nothing will dismiss the view.
                }
                // add the cancel action to the alertController
                alertController.addAction(cancelAction)
                
                // create an OK action
                let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
                    // handle response here.
                }
                // add the OK action to the alert controller
                alertController.addAction(OKAction)
                self.present(alertController, animated: true) {
                
                }
            }
            else {
                self.performSegue(withIdentifier: "login", sender: nil)
                print("sign up succeeds!")
            }
        }
    }
}

