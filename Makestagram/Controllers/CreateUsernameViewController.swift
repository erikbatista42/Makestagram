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
                guard let firUser = Auth.auth().currentUser,
        let username = usernameTextField.text,
        !username.isEmpty else { return }

        let userAttrs = ["username": username]

        let ref = Database.database().reference().child("users").child(firUser.uid)


            ref.setValue(userAttrs) { (error, ref) in
                if let error = error {
                    assertionFailure(error.localizedDescription)
                    return
                }

                    ref.observeSingleEvent(of: .value, with: { (snapshot) in
                        let user = User(snapshot: snapshot)

                        // handle newly created user here
                    })
        }
        print(123)
    }
    
    
    
    
    
}
