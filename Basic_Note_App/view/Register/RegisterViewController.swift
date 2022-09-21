//
//  RegisterViewController.swift
//  Basic_Note_App
//
//  Created by xmod on 18.07.2022.
//

import UIKit
import SwiftUI

class RegisterViewController:UIViewController {

    

    @IBOutlet weak var alertMessageFrame: UIStackView!
    @IBOutlet weak var alertMessageContent: UILabel!
    
    @IBOutlet weak var fuulNameEditText: FloatLabelTextField!
    @IBOutlet weak var emailAddressEditText: FloatLabelTextField!
    @IBOutlet weak var passwordEdittext: FloatLabelTextField!
    
    @IBOutlet weak var fullNameFrame: UIStackView!
    @IBOutlet weak var emailFrame: UIStackView!
    @IBOutlet weak var passwordFrame: UIStackView!
    
    @IBOutlet weak var signUp: UIButton!
    @IBOutlet weak var signInNowLabel: UILabel!
    
    private var width : Double = UIScreen.main.bounds.width
    private var height : Double = UIScreen.main.bounds.height
    
    @State var isButtonActive = false

   
    private var full_name = ""
    private var email = ""
    private var password = ""
    private var checkvalidate = false
  
    
    private let registerViewModel = RegisterViewModel()
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        // Alert mesajı ilk acılısta gizle
        alertMessageFrame.alpha = 0
        
        
        // Sign In Now Event
        let tap = UITapGestureRecognizer(target: self, action: #selector(launchScreen))
        signInNowLabel.isUserInteractionEnabled = true
        signInNowLabel.addGestureRecognizer(tap)
        
        // Sign Up Button Action & Property
        signUp.addTarget(self, action: #selector(self.sendRegisterData), for: .touchUpInside)
        self.signUp.backgroundColor = UIColor(red: 0.863, green: 0.863, blue: 1, alpha: 1)
      
        
        
        
        // Full Name Frame Property
        fullNameFrame.layer.cornerRadius = 5
        fullNameFrame.layer.borderWidth = 1
        fullNameFrame.layer.borderColor = UIColor(red: 0.886, green: 0.902, blue: 0.918, alpha: 1).cgColor
        
        // E-mail Frame Property
        emailFrame.layer.cornerRadius = 5
        emailFrame.layer.borderWidth = 1
        emailFrame.layer.borderColor = UIColor(red: 0.886, green: 0.902, blue: 0.918, alpha: 1).cgColor
        
        // Password Frame Property
        passwordFrame.layer.cornerRadius = 5
        passwordFrame.layer.borderWidth = 1
        passwordFrame.layer.borderColor = UIColor(red: 0.886, green: 0.902, blue: 0.918, alpha: 1).cgColor
        
        
        // FullName Text Field Action & Property
        fuulNameEditText.addTarget(self, action: #selector(fuulNameEditTextChanged), for: .editingChanged)
        fuulNameEditText.inputAccessoryView = toolBar()
        
        // E-mail Text Field Action & Property
        emailAddressEditText.addTarget(self, action: #selector(emailEditTextChanged), for: .editingChanged)
        emailAddressEditText.inputAccessoryView = toolBar()
        
        // Password Text Field Action & Property
        passwordEdittext.addTarget(self, action: #selector(passwordEditTextChanged), for: .editingChanged)
        passwordEdittext.inputAccessoryView = toolBar()
        
        
        // Text fieldlere yazı yazıldıysa button rengi koyu olsun
          DispatchQueue.global(qos: .userInteractive).async {
          // Yeni thread'de çalıştırdım ui thread takılmasin diye
           while true{
               sleep(1)
             DispatchQueue.main.async {
                 
                 /// eger text fieldlara yazı yazıldıysa buton renklerini ve title değiştir
                if self.fuulNameEditText.text != "" && self.emailAddressEditText.text != "" && self.passwordEdittext.text != ""{
                        
                    self.signUp.backgroundColor = UIColor(red: 0.545, green: 0.549, blue: 1, alpha: 1)
                    
                    self.signUp.titleLabel?.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
                        
                } else{
                    /// eger text fieldlara yazı yoksa  buton renklerini ve title degistir değiştir
                    self.signUp.backgroundColor = UIColor(red: 0.863, green: 0.863, blue: 1, alpha: 1)
                    
                    self.signUp.titleLabel?.textColor = UIColor(red: 0.545, green: 0.549, blue: 1, alpha: 1)
                }
                 
                 
               }
   
            }
        }
        
       
        
        setupBinder()
        
    }
    
    

    
    

    @objc func fuulNameEditTextChanged(){
        if fuulNameEditText.text != ""{
            fullNameFrame.layer.borderColor = UIColor(red: 0.545, green: 0.549, blue: 1, alpha: 1).cgColor
            isButtonActive = true
        }else{
            fullNameFrame.layer.borderColor = UIColor(red: 0.886, green: 0.902, blue: 0.918, alpha: 1).cgColor
            isButtonActive = false
        }
    }
    
    @objc func emailEditTextChanged(){
        if emailAddressEditText.text != ""{
            emailFrame.layer.borderColor = UIColor(red: 0.545, green: 0.549, blue: 1, alpha: 1).cgColor
            isButtonActive = true
        }else{
            emailFrame.layer.borderColor = UIColor(red: 0.886, green: 0.902, blue: 0.918, alpha: 1).cgColor
            isButtonActive = false
        }
    }
    
    @objc func passwordEditTextChanged(){
        if passwordEdittext.text != ""{
            passwordFrame.layer.borderColor = UIColor(red: 0.545, green: 0.549, blue: 1, alpha: 1).cgColor
            isButtonActive = true
        }else{
            passwordFrame.layer.borderColor = UIColor(red: 0.886, green: 0.902, blue: 0.918, alpha: 1).cgColor
            isButtonActive = false
        }
    }
    
    @objc func launchScreen(sender:UITapGestureRecognizer) {
         performSegue(withIdentifier: "loginSegue", sender: nil)
     }
    
    private func emailValidate() -> Bool{
        var emailbool = false
        if emailAddressEditText.text != ""{
            if emailAddressEditText.text!.isValidEmail() {
                self.email = emailAddressEditText.text!
                emailbool = true
                alertMessageFrame.alpha = 0
            }else{
              //  print("e-mail validations not supported")
              //  registerAlertDialog(title: "Error", message: "E-mail is not validate")
                alertMessageFrame.alpha = 1
                alertMessageContent.text = "E-mail validations error"
            }
        }else{
        //    registerAlertDialog(title: "Error", message: "E-mail is empty")
            alertMessageFrame.alpha = 1
            alertMessageContent.text = "E-mail is empty"
        }
        return emailbool
    }
    
    private func userNameValidate() -> Bool {
        var userNameBool = false
        if let userName = fuulNameEditText.text{
            if userName != "" && userName.count <= 255  {
                self.full_name = userName
                alertMessageFrame.alpha = 0
                userNameBool = true
            }else{
           //     registerAlertDialog(title: "Error", message: "User name is empty or user name count is hight")
                alertMessageFrame.alpha = 1
                alertMessageContent.text = "User name is empty or user name count is hight"
            }
        }
        return userNameBool
    }
    
    private func passwordValidate() ->Bool{
        var passwordBool = false
        if let password = passwordEdittext.text{
            if password != ""{
                if password.count<=255 && password.count>=6{
                    self.password = password
                    passwordBool = true
                    alertMessageFrame.alpha = 0
                }else{
               //     registerAlertDialog(title: "Error", message: "Password count is 255 higher or password count is 6 lower")
                    alertMessageFrame.alpha = 1
                    alertMessageContent.text = "Password count is 255 higher or password count is 6 lower"
                }
            }else{
            //    registerAlertDialog(title: "Error", message: "Password is empty")
                alertMessageFrame.alpha = 1
                alertMessageContent.text = "Password is empty"
            }
         
        }
        return passwordBool
    }
    
    @objc private func sendRegisterData(){
        // eğer email validate hatalı gelirse true yapicak ve bos return ile func çıkılcak :)
        if !userNameValidate(){
            return;
        }
        // eğer userNameValidate hatalı gelirse true yapicak ve bos return ile func çıkılcak
        if !emailValidate(){
            return;
        }
        // eğer passwordValidate hatalı gelirse true yapicak ve bos return ile func çıkılcak
        if !passwordValidate(){
            return;
        }
        // hic biri return donmesse son olarak kayıt için data gonderilcek
        self.registerViewModel.postRegister(userName: full_name, email: email, password: password)
    }
    
    private func registerAlertDialog(title:String,message:String){
           // alert değişkeni oluşturuldu
           let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)

           // Continue button eklendi
        alert.addAction(UIAlertAction(title: "Continue", style: UIAlertAction.Style.default, handler: { action in
            
        }))
           
          // Cancel button eklendi
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: { action in
            //Kullanıcı hata mesajı butonunda cancel basarsa edit textler sıfırlancak
            self.emailAddressEditText.text = ""
            self.fuulNameEditText.text = ""
            self.passwordEdittext.text = ""
        }))

           // show alert
           self.present(alert, animated: true, completion: nil)
    }
    
    @objc private func backButton(){
        performSegue(withIdentifier: "registerBack", sender: nil)
    }
    
    private func setupBinder(){
        registerViewModel.isUserRegister.bind { [weak self] error in
            if error == "Success"{
                self?.fullNameFrame.alpha = 0
                self?.performSegue(withIdentifier: "registerSuccessSegue", sender: nil)
            }else{
                if error ==  "The E-email has already been taken."{
                    // alert messajı göster
                    DispatchQueue.main.async {
                        self!.alertMessageFrame.alpha = 1
                        self!.alertMessageContent.text = "The E-email has already been taken."
                    }
        
                }
            }
        }
    }
    

    
    
    
}
