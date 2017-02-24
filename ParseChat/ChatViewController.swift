//
//  ChatViewController.swift
//  ParseChat
//
//  Created by Sandeep Raghunandhan on 2/23/17.
//  Copyright © 2017 Sandeep Raghunandhan. All rights reserved.
//

import UIKit
import Parse

class ChatViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var messages: [PFObject]?
    
    @IBOutlet weak var tableView: UITableView!
    
    var isFetching = false
    
    @IBOutlet weak var message: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = tableView.rowHeight
        tableView.rowHeight = UITableViewAutomaticDimension
        Timer.scheduledTimer(timeInterval: 2, target: self, selector: "onTimer", userInfo: nil, repeats: true)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onButtonSend(_ sender: Any) {
        let messageToSend = Message(message: message.text!)
        var parseMessage = PFObject(className: "Message")
        parseMessage["text"] = messageToSend.text
        parseMessage["user"] = PFUser.current()
        parseMessage.saveInBackground { (success: Bool, error: Error?) in
            if(success) {
              print("saved")
              self.message.text = ""
            } else {
                
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MessageCell", for: indexPath) as! MessageCell
        if let content = messages![indexPath.row]["text"] as! String? {
            if let user = messages![indexPath.row]["user"] as? PFUser {

                user.fetchInBackground(block: { (user, error) in
                    if let user = user as? PFUser{
                        DispatchQueue.main.async {
                            cell.setNeedsLayout()
                            cell.layoutIfNeeded()
                            cell.content = "\(user.username!): \(content)"

                        }
                    }
                })
            } else {
                cell.content = "\(content)"
            }
        }
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let messages = messages {
            return messages.count
        }
        else {
            return 0;
        }
    }

    func onTimer() {
        if !self.isFetching{
            self.isFetching = true
        var query = PFQuery(className: "Message")
        query.order(byDescending: "createdAt")
        query.includeKey("user")
        query.findObjectsInBackground { (results: [PFObject]?, error: Error?) in
            
            if let error = error {
                
            }
            else {
                print(results)
                self.messages = results!
                self.tableView.reloadData()
            
            }
            self.isFetching = false
        }
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
