//
//  RegisterModel.swift
//  Basic_Note_App
//
//  Created by xmod on 3.08.2022.
//

import Foundation



//gelen örnek json
//{
//    "code": "common.success",
//    "data": {
//        "access_token": "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9",
//        "token_type": "Bearer"
//    },
//    "message": "Success"
//}

struct RegisterModel: Codable {
    let code: String
    let data: RegisterDataClass
    let message: String
}


struct RegisterDataClass: Codable {
    let accessToken:String
    let tokenType:String

    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case tokenType = "token_type"
    }
}

