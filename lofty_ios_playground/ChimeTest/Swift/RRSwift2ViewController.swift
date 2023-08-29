//
//  RRSwift2ViewController.swift
//  ChimeTest
//
//  Created by chunlei.sun on 2023/8/25.
//

import UIKit

class RRSwift2ViewController: UIViewController {

    @IBOutlet weak var testLabel: RRInsetLabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.testLabel.backgroundColor = .red
        
        self.testLabel.textInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        
    }


}
