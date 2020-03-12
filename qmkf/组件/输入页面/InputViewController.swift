//
//  InputViewController.swift
//  qmkf
//
//  Created by Mac on 2020/2/24.
//  Copyright © 2020 Mac. All rights reserved.
//

import UIKit

class InputViewController: HideNavibarViewController {
    @IBOutlet weak var textfield: UITextField!
    
    typealias baseBlock = (String) -> () //或者 () -> Void
    
    override func viewDidLoad() {
        super.viewDidLoad()

        textfield.becomeFirstResponder()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        textfield.resignFirstResponder()
    }
    
    @IBAction func cancel(_ sender: Any) {
        self.dismiss()
    }
    
    @IBAction func down(_ sender: Any) {
        self.baseBlock(textfield.text ?? "")
        self.dismiss()
    }
    
    @IBAction func textfield(_ sender: Any) {
        
    }
    
}
