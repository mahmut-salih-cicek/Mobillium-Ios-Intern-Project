//
//  SignInViewController.swift
//  Basic_Note_App
//
//  Created by xmod on 18.07.2022.
//

import UIKit
import SwiftUI
import MaterialComponents.MaterialTextControls_FilledTextAreas
import MaterialComponents.MaterialTextControls_FilledTextFields
import MaterialComponents.MaterialTextControls_OutlinedTextAreas
import MaterialComponents.MaterialTextControls_OutlinedTextFields
import SkyFloatingLabelTextField;

class SignInViewController: UIViewController {
    

    
    @IBOutlet weak var toastMessageContent: UILabel!
    @IBOutlet weak var toastMessageFrame: UIStackView!
    @IBOutlet weak var passwordInvalidFrame: UIStackView!
    @IBOutlet weak var framePassword: UIStackView!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var loginTextView: UILabel!
    @IBOutlet weak var emailFrame: UIStackView!
    @IBOutlet weak var EmailAddressEditText: FloatLabelTextField!
    @IBOutlet weak var PasswordEditText: FloatLabelTextField!
    @IBOutlet weak var signInNowLabel: UILabel!
    
 
    private var width : Double = UIScreen.main.bounds.width
    private var height : Double = UIScreen.main.bounds.height
    
    
     var email = ""
     var password = ""
     let loginService = LoginService()
     var loginViewModel =  LoginViewModel()

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Password InValid Frame ilk acıldığında görünmez yapıldı
        passwordInvalidFrame.alpha = 0
        
        // toastMessage ilk acıldığında görünmez yapıldı
        toastMessageFrame.alpha = 0
        
        //Login Button Action 
        loginButton.addTarget(nil, action: #selector(self.sendLoginData), for: .touchUpInside)
        
        
        
        // Sign In Now Action
        let tap = UITapGestureRecognizer(target: self, action: #selector(launchScreen))
        signInNowLabel.isUserInteractionEnabled = true
        signInNowLabel.addGestureRecognizer(tap)
        
        
    
        // Email Frame Property
        emailFrame.layer.cornerRadius = 5
        emailFrame.layer.borderWidth = 1
        emailFrame.layer.borderColor = UIColor(red: 0.886, green: 0.902, blue: 0.918, alpha: 1).cgColor
       
        // Password Frame Property
        framePassword.layer.cornerRadius = 5
        framePassword.layer.borderWidth = 1
        framePassword.layer.borderColor = UIColor(red: 0.886, green: 0.902, blue: 0.918, alpha: 1).cgColor
        
        
       // Email Text Field Action & Property
        EmailAddressEditText.addTarget(self, action: #selector(emailTextFieldChanged), for: .editingChanged)
        EmailAddressEditText.inputAccessoryView = toolBar()
    
        // Pasword Text Field Action & Property
        PasswordEditText.addTarget(self, action: #selector(passwordTextFieldChanged), for: .editingChanged)
        PasswordEditText.inputAccessoryView = toolBar()
      
        
        // Login Response Listener
        setupBinder()
        
    }
    
    
    
    @objc private func emailTextFieldChanged(){
        if EmailAddressEditText.text != ""{
            emailFrame.layer.borderColor = UIColor(red: 0.545, green: 0.549, blue: 1, alpha: 1).cgColor
        }else{
            emailFrame.layer.borderColor = UIColor(red: 0.886, green: 0.902, blue: 0.918, alpha: 1).cgColor
        }
    }
    
    @objc private func passwordTextFieldChanged(){
        if PasswordEditText.text != ""{
            framePassword.layer.borderColor = UIColor(red: 0.545, green: 0.549, blue: 1, alpha: 1).cgColor
            passwordInvalidFrame.alpha = 0
        }else{
            framePassword.layer.borderColor = UIColor(red: 0.886, green: 0.902, blue: 0.918, alpha: 1).cgColor
        }
    }
    
    @objc private func launchScreen(sender:UITapGestureRecognizer) {
         performSegue(withIdentifier: "registerSegue", sender: nil)
     }
    
    private func emailValidate() -> Bool{
        var emailbool = false
        if EmailAddressEditText.text != ""{
            if EmailAddressEditText.text!.isValidEmail() {
                self.email = EmailAddressEditText.text!
                emailbool = true
            }else{
             //   registerAlertDialog(title: "Error", message: "E-mail is not validate")
                toastMessageContent.text = "E-mail validations error"
                toastMessageFrame.alpha = 1
                
            }
        }else{
            print("e-mail is empty")
            //registerAlertDialog(title: "Error", message: "E-mail is empty")
            toastMessageContent.text = "The E-mail is empty"
            toastMessageFrame.alpha = 1
        }
        return emailbool
    }
    
    private func passwordValidate() ->Bool{
        var passwordBool = false
        if let password = PasswordEditText.text{
            if password != ""{
              
                if password.count<=255 && password.count>=6{
                    self.password = password
                    passwordBool = true
                    PasswordEditText.layer.borderColor = UIColor(red: 0.886, green: 0.902, blue: 0.918, alpha: 1).cgColor
                    passwordInvalidFrame.alpha = 0
                    
                }else{
                    //registerAlertDialog(title: "Error", message: "Password count is 255 higher or password count is 6
                }
            }else{
                ///registerAlertDialog(title: "Error", message: "Password is empty")
            }
         
        }
        return passwordBool
    }
   
    @objc private func sendLoginData(){
        /// eğer email validate hatalı gelirse true yapicak ve bos return ile func çıkılcak :)
        if !emailValidate(){
            return;
        }
        /// eğer passwordValidate hatalı gelirse true yapicak ve hata mesajı gosterildikten sonra bos return ile func çıkılcak
        if !passwordValidate(){
            passwordInvalidFrame.alpha = 1
            framePassword.layer.borderColor = UIColor(named: "Helper [Error]")?.cgColor
            return;
        }
        // hic biri return donmesse son olarak giriş için data gonderilcek
        self.loginViewModel.getDataFromInternet(email: self.email, password:self.password)
    }
    
    private func setupBinder(){
        loginViewModel.isUserLogin.bind { [weak self] isUserLogin in
            if isUserLogin == "Success"{
                self!.toastMessageFrame.alpha = 0
                self?.performSegue(withIdentifier: "loginSuccessSegue", sender: nil)
            }else{
                DispatchQueue.main.async {
                    if isUserLogin == "invalidUser"{
                        self!.toastMessageFrame.alpha = 1
                        self!.toastMessageContent.text = "The email and password you entered did notmatch our records. Please try again."
                    }
                }
               
            }
        }
    }
    

    
    
    
    
    
    
    
    
    

}







