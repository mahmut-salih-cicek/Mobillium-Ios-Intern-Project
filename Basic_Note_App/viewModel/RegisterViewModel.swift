//
//  RegisterViewModel.swift
//  Basic_Note_App
//
//  Created by xmod on 24.07.2022.
//

import Foundation
import SwiftUI
class RegisterViewModel{
    
    // RegisterService sınıfından instance oluşturuluyor
    let registerServices = RegisterService()
    
    //  Listener ile register mesajini dinlemek için değişken oluşturuldu
    var isUserRegister : ObservableRegister<String> = ObservableRegister(nil)
    
    
    func postRegister(userName:String,email:String,password:String){
        
        registerServices.Register(email: email, password: password, userName: userName) { (sonuc) in
            
            switch sonuc{
            case.failure(let hata):
                print(hata)
                // Eğer işlem başarısız olursa isUserRegister değişkeni already been taken yapılır apiden gelen mesaj da eşitlenebilir!!
                        self.isUserRegister.value = "The E-email has already been taken."
            case.success(let data):
                DispatchQueue.main.async {
                    if let data = data{
                        print(data)
                        // işlem başarılı ise apiden gelen mesaj succes olucaktır
                        self.isUserRegister.value = data.message
                        // access token set edildi
                        UserAccessToken.value(value: data.data.accessToken, forKey: "AccessToken")
                        
                    }
                }
            }
            
        }
   

        
    }


    
}
