//
//  LoginViewModel.swift
//  Basic_Note_App
//
//  Created by xmod on 19.07.2022.
//

import Foundation
import SwiftUI


class LoginViewModel : ObservableObject{
    
    // Listener ile login mesaji dinlemek için değişken oluşturuldu
    var isUserLogin : ObservableLogin<String> = ObservableLogin(nil)
    // LoginServisten instance oluşturuldu
    let loginService = LoginService()
    
    
    func getDataFromInternet(email:String,password:String){
        
        loginService.Login(email: email, password: password){ (sonuc) in
            switch sonuc{
            case.failure(let hata):
                //Eğer hata alınırsa isUserLogin invalidUser eşitlencek istenirse api gelen mesejada eşitlenebilir
                self.isUserLogin.value = "invalidUser"
                print(hata)
            case.success(let data):
                DispatchQueue.main.async {
                    if let data = data{
                        //eğer kullanıcı varsa isUserLogin değişkeni api gelen succes atanir
                        self.isUserLogin.value = data.message
                        // access token  set edildi
                        UserAccessToken.value(value: data.data.accessToken, forKey: "AccessToken")
                    }
                }
            }
            
            
          
        }
    
    }
    

}




