//
//  MainViewController.swift
//  office-bell
//
//  Created by akinov on 2018/03/21.
//  Copyright © 2018年 akinov. All rights reserved.
//

import UIKit
import Alamofire

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func onClickBell(_ sender: Any) {
        let headers: HTTPHeaders = [
            "Authorization": UserDefaults.standard.string(forKey: "authentication_token")!
        ]
        Alamofire.request(
            "http://192.168.11.7:3000/api/call",
            headers: headers)
            .responseJSON { response in
                if let json = response.result.value as? [String: AnyObject] {
                    if json["result"] as! Bool {
                        self.showPingSuccessAlert()
                    }
                    else {
                        self.showPingErrorAlert()
                    }
                }
                else {
                    self.showPingErrorAlert()
                }
            
        }
    }
    
    private func showPingErrorAlert() {
        let alertController = UIAlertController(title: "呼び出しに失敗しました", message: "お手数ですが", preferredStyle: UIAlertControllerStyle.alert)
        
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    private func showPingSuccessAlert() {
        let alertController = UIAlertController(title: "呼び出しをしました", message: "少々お待ちください", preferredStyle: UIAlertControllerStyle.alert)
        
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        
        self.present(alertController, animated: true, completion: nil)
    }
}
