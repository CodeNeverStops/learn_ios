//
//  AccountsViewController.swift
//  SocialApp
//
//  Created by Wayne on 15/8/24.
//  Copyright (c) 2015年 Wayne. All rights reserved.
//

import UIKit
import Accounts

class AccountsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var accounts:[AnyObject]?

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.retrieveAccounts(ACAccountTypeIdentifierTwitter, options: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.

    }
    
    func retrieveAccounts(identifier: String, options: [NSObject:AnyObject]?) {
        println("retrieve accounts")
        var accountStore = ACAccountStore()
        var accountType = accountStore.accountTypeWithAccountTypeIdentifier(identifier)
        accountStore.requestAccessToAccountsWithType(accountType, options: options, completion: {
            (granted, error) in
            if granted {
                self.accounts = accountStore.accountsWithAccountType(accountType)
                if self.accounts != nil {
                    if self.accounts?.count == 0 {
                        println("在设置应用程序中没有配置Twitter帐号，你可以增加或者创建一个。")
                    } else {
                        dispatch_async(dispatch_get_main_queue(), {
                            self.tableView.reloadData()
                        })
                    }
                }
            }
        })
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        println("table view number of rows in section")
        if let accounts = self.accounts {
            return accounts.count
        }
        return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        println("table view cell for row at index path")
        let CellIdentifier = "accountCell"
        let cell = self.tableView.dequeueReusableCellWithIdentifier(CellIdentifier) as! UITableViewCell
        
        if let accounts = self.accounts {
            var account = accounts[indexPath.row] as! ACAccount
            cell.textLabel?.text = account.accountDescription
        }
        return cell
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
