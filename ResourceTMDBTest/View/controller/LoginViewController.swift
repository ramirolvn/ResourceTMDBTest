//
//  LoginViewController.swift
//  ResourceTMDBTest
//
//  Created by Ramiro Lima Vale Neto on 22/05/19.
//  Copyright © 2019 Vikram Gupta. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate{
    
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var emailTxt: UITextField!
    
    private var viewmodel = ContactsViewModel(dataService: DataService())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.emailTxt.delegate = self
        self.passwordTxt.delegate = self
    }
    
    func fetchContacts() {
        viewmodel.fetchContacts()
        viewmodel.didFinishFetch = {
            //            self.contacts = self.viewmodel.contacts!
        }
    }
    
    @IBAction func loginAction(_ sender: Any) {
    }
    @IBAction func registerAction(_ sender: Any) {
        
    }
}
