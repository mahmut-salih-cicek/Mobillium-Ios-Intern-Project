//
//  RegisterService.swift
//  Basic_Note_App
//
//  Created by xmod on 18.07.2022.
//

import Foundation
import SwiftUI


class RegisterService{
    
//path: auth/register
//HTTP Method: POST
//body:
//full_name:Mehmet Salih Aslan
//email:aslanmsalih@gmail.com
//password:password
    
    

    func Register (email:String,password:String,userName:String,completion:@escaping(Result<RegisterModel?,LoginError>) -> Void ){
        

        // login url tanımlandı, guard let ile hata olup olmadığı denetlendi
        guard let url = URL(string: "https://evening-brook-09377.herokuapp.com/api/auth/register")
        else {
            return completion(.failure(.urlHatali))
        }
        
        
        var json = [String:Any]()
        json["full_name"] = userName
        json["email"] = email
        json["password"] = password
        let jsonConverter = try? JSONSerialization.data(withJSONObject: json)
        
        
        /// reguest için URLRequest değişken tanımlıyoruz ve header,body,method lari veriyoruz
        var request = URLRequest(url: url)
        request.httpMethod="POST"
        request.httpBody = jsonConverter
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
            guard let dataParse = try? JSONDecoder().decode(RegisterModel.self, from: data)
            else{
                return completion(.failure(.veriIslenmedi))
            }
            
            /// işlem basarili ise son olarak completion succes olduğunu belirtiyoruz
            completion(.success(dataParse))
            
        }.resume()
        
        
    }
    
    
    
}


// Register işlemlerinde alabilceğim hatalari enum ile ayıklıyorum
enum RegisterError : Error{
    case VeriGelmedi
    case VeriIslenmedi
    case UrlHatali
}
