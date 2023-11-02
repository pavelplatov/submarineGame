//
//  RestartViewController.swift
//  submarineGame
//
//  Created by Павел Платов on 31.10.2023.
//

import UIKit

class RestartViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()


    }
    
    @IBAction func restartButtonPressed(_ sender: Any) {
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "GameViewController") as! GameViewController
        self.navigationController?.pushViewController(controller, animated: true)
        
    }
    

}
