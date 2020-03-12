//
//  PlaceholderTextView.swift
//  qmkf
//
//  Created by Mac on 2019/12/7.
//  Copyright © 2019 Mac. All rights reserved.
//

import Foundation
import UIKit

class PlaceholderTextView: UITextView , UITextViewDelegate{

    var placeholder : NSString?
    var placeholderFont : UIFont?
    var placeholderColor : UIColor?

    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.addSubview(placeholderLabel)

        NotificationCenter.default.addObserver(self, selector: #selector(textDidBeginEditing), name: UITextView.textDidBeginEditingNotification, object: nil)

        //文本框编辑结束时，触发
        NotificationCenter.default.addObserver(self, selector: #selector(textDidEndEditing), name: UITextView.textDidEndEditingNotification, object: nil)


        //文本框内容改变时，触发
        NotificationCenter.default.addObserver(self, selector: #selector(textDidChange), name: UITextView.textDidChangeNotification, object: nil)


        if placeholder == nil{

            placeholder = "请输入内容"

        }

        if placeholderFont == nil {

            placeholderFont = UIFont.systemFont(ofSize: 15)

        }

        if placeholderColor == nil {

            placeholderColor = zHEX(hexValue: 0xa0a0a0)

        }


        let fontSize = CGSize(width: placeholder!.length*13/10*15, height: 15)
        
        let placeSize:CGSize = placeholder!.boundingRect(with: fontSize, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: placeholderFont!], context: nil).size;


        placeholderLabel.frame = CGRect(x:8, y:7, width:placeSize.width ,height:placeSize.height + 1)
        placeholderLabel.text = placeholder! as String
        placeholderLabel.font = placeholderFont!
        placeholderLabel.textColor = placeholderColor!

    }

    @objc func textDidBeginEditing(){

      //print("textDidBeginEditing")

    }

    @objc func textDidEndEditing(){
        //print("textDidEndEditing")
    }


    @objc func textDidChange(){

        if self.text.isEmpty {

            placeholderLabel.isHidden = false
        }else{
            placeholderLabel.isHidden = true
        }

    }


    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

    }



    lazy var  placeholderLabel:UILabel = {
        let placeholderLabel = UILabel()
        placeholderLabel.numberOfLines = 0
        return placeholderLabel
    }()

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
