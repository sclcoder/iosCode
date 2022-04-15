//
//  ViewController.swift
//  Swift_Play
//
//  Created by chunlei.sun on 2022/2/17.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // map、flatMap
        testMap();
    }
    
    func testMap(){
        let numbers:[Int] = [1,2,3,4,5];
        let mapedNumbers = numbers.map {Array(repeating: $0, count: $0)}
        print(mapedNumbers)
        
        let flatMapedNumbers = numbers.flatMap { Array(repeating: $0, count: $0)}
        print(flatMapedNumbers)
    }
}

