//
//  ViewController.swift
//  SwiftLogin
//
//  Created by HolyKnight on 2020/07/16.
//  Copyright © 2020 HolyKnight. All rights reserved.
//

import UIKit
import SnapKit

class ViewController: BaseVC, UITextFieldDelegate {

    let colorMain: UIColor = UIColor.init(displayP3Red: 29/255, green: 26/255, blue: 47/255, alpha: 1)
    
    lazy var viewHeader: UIView = {
        let v = UIView()
        v.backgroundColor = colorMain
        
        return v
    }();
    
    lazy var viewSquare: UIView = {
        let v = UIView()
        v.backgroundColor = colorMain
        v.transform = CGAffineTransform(rotationAngle: 45 * (CGFloat.pi / 180))
        
        return v
    }()
    
    lazy var labelTitle: UILabel = {
        let v = UILabel()
        v.text = "Login"
        v.font = .systemFont(ofSize: 30, weight: UIFont.Weight.init(0.4))
        
        return v
    }()
    
    lazy var labelContext: UILabel = {
        let v = UILabel()
        v.text = "Lorem ipsum dolor sit amet, consetetur\nsadipscing elitr, sed diam nonumy eirmod tempor"
        v.font = .systemFont(ofSize: 13)
//        v.backgroundColor = .gray
        v.numberOfLines = 2
        
        return v
    }()
    
    lazy var ivUsername : UIImageView = {
        let v = UIImageView()
        v.image = UIImage(named: "icon_username_19.png")
        v.sizeToFit()
        
        return v
    }()
    
    lazy var ivPassword : UIImageView = {
        let v = UIImageView()
        v.image = UIImage(named: "icon_password_19.png")
        v.sizeToFit()
        
        return v
    }()
    
    lazy var tfUsername : UITextField = {
        let v = UITextField()
        v.delegate = self
        
        v.placeholder = "Username"
        v.attributedPlaceholder = NSAttributedString.init(string: "Username", attributes: [NSAttributedString.Key.foregroundColor: UIColor.init(displayP3Red: 23/255, green: 23/255, blue: 23/255, alpha: 0.3)])
        v.clearButtonMode = .whileEditing
        
        return v
    }()
    
    lazy var tfPassword : UITextField = {
        let v = UITextField()
        v.delegate = self
        v.isSecureTextEntry = true
        
        v.attributedPlaceholder = NSAttributedString.init(string: "Password", attributes: [NSAttributedString.Key.foregroundColor: UIColor.init(displayP3Red: 23/255, green: 23/255, blue: 23/255, alpha: 0.3)])
        v.clearButtonMode = .whileEditing
        return v
    }()
    
    lazy var btnForgot: UIButton = {
        let v = UIButton()
        v.setTitle("Forgot Password", for: .normal)
        v.setTitle("Forgot Password", for: .highlighted)
        v.titleLabel?.font = .systemFont(ofSize: 12)
        v.setTitleColor(hexToRgb(hex: "#2642D3"), for: .normal)
        v.setTitleColor(hexToRgba(hex: "#2642D380"), for: .highlighted)
        
        return v
    }()
    
    lazy var stackBottom: UIStackView = {
        let v = UIStackView()
        v.axis = .horizontal
        v.distribution = .fillEqually
        v.alignment = .fill
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .red
        
        return v
    }()
    
    lazy var viewSignUp: UIView = {
        let v = UIView()
        
        return v
    }()
    
    lazy var viewSignIn: UIView = {
        let v = UIView()
        v.backgroundColor = hexToRgb(hex: "#2642D3")
        
        return v
    }()
    
    lazy var labelSignUpTitle: UILabel = {
        let v = UILabel()
        v.text = "SIGIN UP"
        v.font = .systemFont(ofSize: 16)
        v.textColor = hexToRgb(hex: "#2642D3")
        
        return v
    }()
    
    lazy var labelSignUpContext: UILabel = {
        let v = UILabel()
        v.text = "Don't have an account?"
        v.textColor = hexToRgb(hex: "#8A9EAD")
        v.font = .systemFont(ofSize: 12)
        
        return v
    }()
    
    lazy var labelSignInTitle: UILabel = {
        let v = UILabel()
        v.text = "SIGIN IN"
        v.font = .systemFont(ofSize: 16)
        v.textColor = hexToRgb(hex: "#FAFAFA")
        
        return v
    }()
    
    lazy var labelSignInContext: UILabel = {
        let v = UILabel()
        v.text = "→"
        v.font = .systemFont(ofSize: 16)
        v.textColor = hexToRgb(hex: "#FAFAFA")
        
        return v
    }()
    
    lazy var vHeader: UIView = {
        let v = UIView()
        v.backgroundColor = colorMain
        
        return v
    }()
    
    lazy var vFooter: UIView = {
        let v = UIView()
        
        return v
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(vHeader)
        view.addSubview(vFooter)
        view.addSubview(safeArea)
        safeArea.addSubview(viewHeader)
        safeArea.addSubview(viewSquare)
        safeArea.addSubview(labelTitle)
        safeArea.addSubview(labelContext)
        safeArea.addSubview(ivUsername)
        safeArea.addSubview(tfUsername)
        safeArea.addSubview(ivPassword)
        safeArea.addSubview(tfPassword)
        safeArea.addSubview(btnForgot)
        safeArea.addSubview(stackBottom)
        stackBottom.addArrangedSubview(viewSignUp)
        stackBottom.addArrangedSubview(viewSignIn)
        viewSignUp.addSubview(labelSignUpTitle)
        viewSignUp.addSubview(labelSignUpContext)
        viewSignIn.addSubview(labelSignInTitle)
        viewSignIn.addSubview(labelSignInContext)
        
        navigationController?.navigationBar.barTintColor = .init(displayP3Red: 10/255, green: 30/255, blue: 20/255, alpha: 1) // 네비 바 컬러주기
        navigationController?.navigationBar.isTranslucent = true    // 네비 바 true = 투명하게/ false = 불투명
        navigationController?.navigationBar.tintColor = .yellow    // 네비 바 틴트컬러
        
        vHeader.snp.makeConstraints({
            $0.width.equalToSuperview()
            $0.top.equalToSuperview()
            $0.bottom.equalTo(viewHeader.snp.top)
        })
        
        vFooter.snp.makeConstraints({
            $0.width.equalToSuperview()
            $0.top.equalTo(safeArea.snp.bottom)
            $0.bottom.equalToSuperview()
        })
        
        viewHeader.snp.makeConstraints({
            $0.top.left.right.equalToSuperview()
            $0.width.equalToSuperview()
            $0.height.equalTo(225)
        })
        
        viewSquare.snp.makeConstraints({
            $0.size.equalTo(30)
            
            $0.bottom.equalTo(viewHeader).offset(15)
            $0.left.equalTo(viewHeader).offset(30)
        })
        
        labelTitle.snp.makeConstraints({
            $0.left.equalToSuperview().offset(30)
            $0.top.equalTo(viewHeader.snp.bottom).offset(70)
        })

        labelContext.snp.makeConstraints({
            $0.left.equalTo(labelTitle)
            $0.right.equalToSuperview()
            
            $0.top.equalTo(labelTitle.snp.bottom).offset(15)
        })
        
        ivUsername.snp.makeConstraints({
            $0.size.equalTo(20)
            
            $0.left.equalTo(labelTitle)
            $0.top.equalTo(labelContext).offset(70)
        })
        
        tfUsername.snp.makeConstraints({
            $0.top.bottom.equalTo(ivUsername)
            $0.left.equalTo(ivUsername.snp.right).offset(25)
            $0.right.equalToSuperview().inset(40)
        })
        
        ivPassword.snp.makeConstraints({
            $0.width.height.left.equalTo(ivUsername)
            $0.top.equalTo(ivUsername.snp.bottom).offset(50)
        })
        
        tfPassword.snp.makeConstraints({
            $0.top.bottom.equalTo(ivPassword)
            $0.left.right.equalTo(tfUsername)
        })
        
        btnForgot.snp.makeConstraints({
            $0.top.equalTo(tfPassword.snp.bottom).offset(30)
            $0.right.equalTo(tfPassword)
        })
        
        stackBottom.snp.makeConstraints({
            $0.width.equalToSuperview()
            $0.height.equalTo(80)
            $0.bottom.equalToSuperview()
        })
        
        viewSignUp.snp.makeConstraints({
            $0.height.equalToSuperview()
            $0.left.top.bottom.equalToSuperview()
        })
        
        viewSignIn.snp.makeConstraints({
            $0.height.equalToSuperview()
            $0.right.top.bottom.equalToSuperview()
        })
        
        labelSignUpTitle.snp.makeConstraints({
            $0.left.equalToSuperview().offset(30)
            $0.right.equalToSuperview()
            
            $0.bottom.equalToSuperview().inset(20)
        })
        
        labelSignUpContext.snp.makeConstraints({
            $0.left.equalTo(labelSignUpTitle)
            $0.bottom.equalTo(labelSignUpTitle.snp.top).offset(-5)
        })
        
        labelSignInTitle.snp.makeConstraints({
            $0.top.bottom.equalToSuperview()
            $0.left.equalToSuperview().offset(30)
        })
        
        labelSignInContext.snp.makeConstraints({
            $0.top.bottom.equalTo(labelSignInTitle)
            $0.right.equalTo(labelSignInTitle).offset(40)
        })
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("textFieldShouldReturn \((textField.text) ?? "Empty")")
        
        // Process of closing the Keyboard when the line feed button is pressed.
        textField.resignFirstResponder()
        
        return true
    }
    
    func hexToRgb(hex: String) -> UIColor {
        var hex: String = hex
//        var startIndex:String.Index = hex.index(hex.startIndex, offsetBy: 1)
//        var endIndex:String.Index = hex.index(before: hex.endIndex)
//
//        if(hex.hasPrefix("#")) {
//            hex = String(hex[startIndex...])
//        }
//
//        print(hex)
//
//        startIndex = hex.index(hex.startIndex, offsetBy: 0)
//        endIndex = hex.index(startIndex, offsetBy: 1)
//
//        let r = hex[startIndex...endIndex]
//
//        startIndex = hex.index(hex.startIndex, offsetBy: 2)
//        endIndex = hex.index(startIndex, offsetBy: 1)
//
//        let g = hex[startIndex...endIndex]
//
//        startIndex = hex.index(hex.startIndex, offsetBy: 4)
//        endIndex = hex.index(startIndex, offsetBy: 1)
//
//        let b = hex[startIndex...endIndex]
//
//        print("R: \(r)")
//        print("G: \(g)")
//        print("B: \(b)")
        
        var strR: String = ""
        var strG: String = ""
        var strB: String = ""
        
        if(hex.hasPrefix("#")) {
            hex = String(hex[hex.index(hex.startIndex, offsetBy: 1)...])
        }
        
        var i = 0
        for char in hex {
            if(i < 2) {
                strR.append(char)
            }
            else if(i < 4) {
                strG.append(char)
            }
            else if(i < 6) {
                strB.append(char)
            }
            
            i += 1
        }
        
        print("R: \(strR) | G: \(strG) | B: \(strB)")
        
        var r: CGFloat = 0.0
        var g: CGFloat = 0.0
        var b: CGFloat = 0.0
        
        if let value = Int(strR, radix: 16) {
            r = CGFloat(value) / 255
        }
        
        if let value = Int(strG, radix: 16) {
            g = CGFloat(value) / 255
        }
        
        if let value = Int(strB, radix: 16) {
            b = CGFloat(value) / 255
        }
        
        print("R: \(r) | G: \(g) | B: \(b)")
        
        let color: UIColor = UIColor.init(displayP3Red: r, green: g, blue: b, alpha: 1)
        
        return color
    }
    
    func hexToRgba(hex: String) -> UIColor {
            var hex: String = hex
    //        var startIndex:String.Index = hex.index(hex.startIndex, offsetBy: 1)
    //        var endIndex:String.Index = hex.index(before: hex.endIndex)
    //
    //        if(hex.hasPrefix("#")) {
    //            hex = String(hex[startIndex...])
    //        }
    //
    //        print(hex)
    //
    //        startIndex = hex.index(hex.startIndex, offsetBy: 0)
    //        endIndex = hex.index(startIndex, offsetBy: 1)
    //
    //        let r = hex[startIndex...endIndex]
    //
    //        startIndex = hex.index(hex.startIndex, offsetBy: 2)
    //        endIndex = hex.index(startIndex, offsetBy: 1)
    //
    //        let g = hex[startIndex...endIndex]
    //
    //        startIndex = hex.index(hex.startIndex, offsetBy: 4)
    //        endIndex = hex.index(startIndex, offsetBy: 1)
    //
    //        let b = hex[startIndex...endIndex]
    //
    //        print("R: \(r)")
    //        print("G: \(g)")
    //        print("B: \(b)")
            
            var strR: String = ""
            var strG: String = ""
            var strB: String = ""
            var strA: String = ""
            
            if(hex.hasPrefix("#")) {
                hex = String(hex[hex.index(hex.startIndex, offsetBy: 1)...])
            }
            
            var i = 0
            for char in hex {
                if(i < 2) {
                    strR.append(char)
                }
                else if(i < 4) {
                    strG.append(char)
                }
                else if(i < 6) {
                    strB.append(char)
                }
                else if(i < 8) {
                    strA.append(char)
                }
                
                i += 1
            }
            
            print("R: \(strR) | G: \(strG) | B: \(strB)")
            
            var r: CGFloat = 0.0
            var g: CGFloat = 0.0
            var b: CGFloat = 0.0
            var a: CGFloat = 0.0
            
            if let value = Int(strR, radix: 16) {
                r = CGFloat(value) / 255
            }
            
            if let value = Int(strG, radix: 16) {
                g = CGFloat(value) / 255
            }
            
            if let value = Int(strB, radix: 16) {
                b = CGFloat(value) / 255
            }
        
            if let value = Int(strA, radix: 16) {
                a = CGFloat(value) / 255
            }
            
            print("R: \(r) | G: \(g) | B: \(b)")
            
            let color: UIColor = UIColor.init(displayP3Red: r, green: g, blue: b, alpha: a)
            
            return color
        }
}
