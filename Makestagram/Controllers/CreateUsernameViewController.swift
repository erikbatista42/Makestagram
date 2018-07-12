//
//  CreateUsernameViewController.swift
//  Makestagram
//
//  Created by Erik Batista on 7/11/18.
//  Copyright © 2018 Erik Batista. All rights reserved.
//

import Foundation
import UIKit
import FirebaseAuth
import FirebaseDatabase

class CreateUsernameViewController: UIViewController {
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nextButton.layer.cornerRadius = 6
    }
    
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        guard let firUser = Auth.auth().currentUser, let username = usernameTextField.text, !username.isEmpty else { return }
        
            UserService.create(firUser, username: username) { (user) in
                guard let user = user else { return }
                
            print("Created new user: \(user.username)")
        }
    }

    
}
