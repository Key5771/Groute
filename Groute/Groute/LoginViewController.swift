//
//  LoginViewController.swift
//  Groute
//
//  Created by 김기현 on 2020/04/27.
//  Copyright © 2020 김기현. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn

class LoginViewController: UIViewController {
    @IBOutlet weak var googleLogin: GIDSignInButton!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var idTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
        GIDSignIn.sharedInstance().delegate = self
        
        idTextfield.delegate = self
        passwordTextfield.delegate = self

        // Do any additional setup after loading the view.
    }
    
    @IBAction func loginButtonClick(_ sender: Any) {
        Auth.auth().signIn(withEmail: idTextfield.text!, password: passwordTextfield.text!) { (user, error) in
            if user != nil {
                let viewController: UIViewController = self.storyboard!.instantiateViewController(withIdentifier: "navigation")
                viewController.modalPresentationStyle = .overFullScreen
                self.present(viewController, animated: true, completion: nil)
            } else {
                let alertController = UIAlertController(title: "로그인 실패", message: "아이디 또는 패스워드를 확인하여주세요.", preferredStyle: .alert)
                let okButton = UIAlertAction(title: "확인", style: .default, handler: nil)
                
                alertController.addAction(okButton)
                self.present(alertController, animated: true, completion: nil)
                
                self.idTextfield.text = ""
                self.passwordTextfield.text = ""
            }
        }
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

extension LoginViewController: GIDSignInDelegate {
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let error = error {
            print(error)
            return
        }
        
        guard let authentication = user.authentication else { return }
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken, accessToken: authentication.accessToken)
        
        Auth.auth().signIn(with: credential) { (authResult, error) in
            if user != nil {
                print("Login Success")
                let viewController: UIViewController = self.storyboard!.instantiateViewController(withIdentifier: "navigation")
                viewController.modalPresentationStyle = .overFullScreen
                self.present(viewController, animated: true, completion: nil)
            } else {
                let alertController = UIAlertController(title: "로그인 실패", message: "로그인에 실패하였습니다", preferredStyle: .alert)
                let okButton = UIAlertAction(title: "확인", style: .default, handler: nil)
                
                alertController.addAction(okButton)
                self.present(alertController, animated: true, completion: nil)
            }
        }
    }
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
