//
//  LoginService.swift
//  Basic_Note_App
//
//  Created by xmod on 18.07.2022.
//

import Foundation


class LoginService{
    
    
    func Login(email:String,password:String,completion:@escaping(Result<LoginModel?,LoginError>) -> Void ){
      
        // login url tanımlandı, guard let ile hata olup olmadığı denetlendi
        guard let url = URL(string: "https://evening-brook-09377.herokuapp.com/api/auth/login")
        else{
           return completion(.failure(.urlHatali))
        }
        /// json için map hazirladik
        var jsonData = [String:Any]()
        jsonData["email"] = email
        jsonData["password"] = password
        /// mapi json için convert ediyoruz
        let jsonConverter = try? JSONSerialization.data(withJSONObject: jsonData, options: [])
        
        /// reguest için URLRequest değişken tanımlıyoruz ve header,body,method lari veriyoruz
        var request = URLRequest(url: url)
        request.httpMethod="POST"
        request.httpBody=jsonConverter
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        /// URl session ile request gonderiyoruz
        URLSession.shared.dataTask(with: request){data,response,error in
           
            /// guard let ile yine kontrol sağlıyoruz, eğer veri geldiyse ve hata boş ise veri geldi
            guard let data = data , error == nil
            else {
                return completion(.failure(.veriGelmedi))
            }

            // gelen cevabi jsonDecoder ile ceviriyoruz
            guard let dataParse = try? JSONDecoder().decode(LoginModel.self, from: data)
            else{
                return completion(.failure(.veriIslenmedi))
            }
            
            /// işlem basarili ise son olarak completionda datayi model ile parse ederek
            completion(.success(dataParse))
            print(dataParse)
            
        }.resume()
        
    }
    
}





// Login işlemlerinde alabilceğim hatalari enum ile ayıklıyorum
enum LoginError:Error{
    case veriGelmedi
    case veriIslenmedi
    case urlHatali
}
