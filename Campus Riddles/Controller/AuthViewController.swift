//
//  AuthViewController.swift
//  Campus Riddles
//
//  Created by Chris Carbajal on 7/15/20.
//  Copyright © 2020 Chris Carbajal. All rights reserved.
//

import UIKit

class AuthViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func signInButtonClicked(_ sender: UIButton) {
        
        UserDefaults.standard.set(true, forKey: Constants.kUserDefaults.isSignIn)
        Switcher.updateRootViewController()
        
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    

}
struct Constants {
    struct kUserDefaults {
        static let isSignIn = "isSignIn"
    }
}

class Switcher {

    static func updateRootViewController() {

        let status = UserDefaults.standard.bool(forKey: Constants.kUserDefaults.isSignIn)
       

        #if DEBUG
        print(status)
        #endif

        if (status == true) {
                print("already logged in")
            let story = UIStoryboard(name: "Main", bundle: nil)
            let vc = story.instantiateViewController(withIdentifier: "AuthViewController") as! AuthViewController
            UIApplication.shared.windows.first?.rootViewController = vc
            UIApplication.shared.windows.first?.makeKeyAndVisible()
        } else {
                print("NOT logged in boi")
            let story = UIStoryboard(name: "Main", bundle: nil)
            let vc = story.instantiateViewController(withIdentifier: "AuthViewController") as! AuthViewController
            UIApplication.shared.windows.first?.rootViewController = vc
            UIApplication.shared.windows.first?.makeKeyAndVisible()
        }


    }

}
