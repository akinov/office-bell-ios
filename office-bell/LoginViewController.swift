//
//  LoginViewController.swift
//  office-bell
//
//  Created by akinov on 2018/03/21.
//  Copyright © 2018年 akinov. All rights reserved.
//

import UIKit
import Alamofire

class LoginViewController: UIViewController {
    // MARK: Propaties
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onClickLogin(_ sender: Any) {
        Alamofire.request(
            "https://office-bell.herokuapp.com/api/sign_in",
            method: .post,
            parameters: [
                "email": emailField.text!,
                "password": passwordField.text!
            ])
            .responseJSON { response in
                if let json = response.result.value as? [String: AnyObject] {
                    // authentication_tokenを保存
                    UserDefaults.standard.set(json["authentication_token"], forKey: "authentication_token")

                    // MainViewに遷移
                    let storyboard: UIStoryboard = self.storyboard!
                    let nextView = storyboard.instantiateViewController(withIdentifier: "mainViewController")
                    self.present(nextView, animated: true, completion: nil)
                }
                else {
                    // ログイン失敗アラートを表示
                    let alertController = UIAlertController(title: "ログインに失敗しました", message: "正しいメールアドレス、パスワードをご入力ください", preferredStyle: UIAlertControllerStyle.alert)
                    
                    alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                    
                    self.present(alertController, animated: true, completion: nil)
                }
        }
    }
    
}

