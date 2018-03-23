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
    @IBOutlet weak var bellButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        setupBellButton()
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
            "https://office-bell.herokuapp.com/api/call",
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
    
    private func setupBellButton() {
        let minSize = [view.frame.width, view.frame.height].min()
        let buttonSize = minSize! * CGFloat(0.6)

        bellButton.frame = CGRect(
            x: (view.frame.width - buttonSize) / 2,
            y: (view.frame.height - buttonSize) / 2,
            width: buttonSize,
            height: buttonSize)
        
        bellButton.layer.cornerRadius = buttonSize / 2
    }
}
