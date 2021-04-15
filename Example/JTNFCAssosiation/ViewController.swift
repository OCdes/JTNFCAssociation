//
//  ViewController.swift
//  JTNFCAssosiation
//
//  Created by OCdes on 04/06/2021.
//  Copyright (c) 2021 OCdes. All rights reserved.
//

import UIKit
import JTNFCAssosiation
class ViewController: UIViewController, NFCToolDelegate {
    func nfcSuccessfullyWrite(msg: String) {
        print(msg)
    }
    
    func nfcSuccessfullyReaded(msg: String) {
        self.contentLal.text = msg
    }
    
    func nfcFailureReaded(msg: String) {
        self.contentLal.text = msg
    }
    
    @IBOutlet weak var contentLal: UILabel!
    @IBOutlet weak var readBtn: UIButton!
    
    @IBOutlet weak var autoReadBtn: UIButton!
    
    @IBOutlet weak var writeBtn: UIButton!
    
    @IBOutlet weak var writeAndLockBtn: UIButton!
    
    var tool: NFCTool = NFCTool.shareTool
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.tool.delegate = self
    }

    
    @IBAction func readDataBtnClicked(_ sender: Any) {
        self.tool.readData()
    }
    
    @IBAction func autoReadBtnClicked(_ sender: Any) {
        
    }
    @IBAction func writeDataBtnClicked(_ sender: Any) {
        self.tool.writeData(contentStr: "")
    }
    
    @IBAction func writeDataLockBtnClicked(_ sender: Any) {
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

