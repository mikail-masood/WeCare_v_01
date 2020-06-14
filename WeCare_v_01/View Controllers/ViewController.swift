//
//  ViewController.swift
//  WeCare_v_01
//
//  Created by Mikail Masood on 2020-05-04.
//  Copyright © 2020 Mikail Masood. All rights reserved.
//

import UIKit
import FirebaseAuth

class ViewController: UIViewController {

    @IBOutlet weak var email_text: UITextField!
    
    @IBOutlet weak var password_text: UITextField!
    
    @IBOutlet weak var login: UIButton!
    
    @IBOutlet weak var error_label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        navigationController?.navigationBar.isHidden = true
        if Auth.auth().currentUser == nil{
            self.transition_to_login_page()
        }
        else{
            self.transitionToHome()
        }
        set_up_elements() 
    }
    
    func set_up_elements(){
        error_label.alpha = 0
        Utilities.styleFilledButton(login)
        Utilities.styleTextField(email_text)
        Utilities.styleTextField(password_text)
    }

    @IBAction func login_tapped(_ sender: Any) {
        // Validate the text field
        
        //creating cleaned data
        let email = email_text.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = password_text.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            
            if error != nil {
                self.error_label.text = error!.localizedDescription
                self.error_label.alpha = 1
            }
            else {
                /*
                self.navigationController?.pushViewController(Home_ViewController(), animated: true)
                self.dismiss(animated: true, completion: nil)
                */
                self.transitionToHome()
                print("successfully logged in")
            }
        }
    }
    
    func transitionToHome(){
        let homeViewController =
            storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeviewcontroller) as? Home_ViewController
        view.window?.rootViewController = homeViewController
        view.window?.makeKeyAndVisible()
    }
    
    func transition_to_login_page() {
        let loginViewController =
            storyboard?.instantiateViewController(identifier: Constants.Storyboard.loginviewcontroller) as? ViewController
        view.window?.rootViewController = loginViewController
        view.window?.makeKeyAndVisible()
    }
}

