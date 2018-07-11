//
//  LoginViewController.swift
//  Makestagram
//
//  Created by Erik Batista on 7/9/18.
//  Copyright © 2018 Erik Batista. All rights reserved.
//

import Foundation
import UIKit
import FirebaseAuth
import FirebaseUI
import FirebaseDatabase

typealias FIRUser = FirebaseAuth.User

class LoginViewController: UIViewController {
    
    @IBOutlet weak var loginButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        guard let authUI = FUIAuth.defaultAuthUI() else { return }
        authUI.delegate = self
        
        let authViewController = authUI.authViewController()
        present(authViewController, animated: true, completion: nil)
    }
    
}

extension LoginViewController: FUIAuthDelegate {
    func authUI(_ authUI: FUIAuth, didSignInWith user: FIRUser?, error: Error?) {
        
        if let err = error {
            assertionFailure("Failed to sign in : \(err.localizedDescription)")
            return
        }
        
        guard let user = user else { return }
        
        let userRef = Database.database().reference().child("users").child(user.uid)
        
        userRef.observeSingleEvent(of: .value, with: { (snapshot) in
            
            // retrive user data from snapshot
            if let user = User(snapshot: snapshot) {
                 print("Welcome back, \(user.username).")
            } else {
                print("New user has been created!")
            }
            
        })
        
    }
}








