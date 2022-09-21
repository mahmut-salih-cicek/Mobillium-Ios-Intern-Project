//
//  KeyboardDone.swift
//  Basic_Note_App
//
//  Created by xmod on 28.07.2022.
//

import Foundation

import Foundation
import UIKit

extension UIViewController{
    func toolBar() -> UIToolbar{
        //Tool bar oluşturuldu
        let toolBar = UIToolbar()
        // size veirldi
        toolBar.sizeToFit()
        // button oluşturuldu
        let button = UIBarButtonItem(title: "Done", style: .plain, target: self,
                                     action: #selector(self.done))
        // sag tarafta dursun diye space verdim
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
       // buton ve spacer eklendi
        toolBar.setItems([space,button], animated: true)
        toolBar.isUserInteractionEnabled = true
        
        return toolBar
    }

    @objc func done() {
       view.endEditing(true)
     }
    
}
