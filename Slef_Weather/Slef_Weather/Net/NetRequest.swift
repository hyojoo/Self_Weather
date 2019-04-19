//
//  NetRequest.swift
//  MiaoTu-iOS
//
//  Created by 曹宇航 on 2018/9/13.
//  Copyright © 2018年 yunshang. All rights reserved.
//
import Alamofire

class NetRequest{
    
    var url: String
    var parameters: Dictionary<String, Any>
    var headers: Dictionary<String, String>
    
    init(url: String , parameters: Dictionary<String, Any>) {
        self.url = url
        self.parameters = parameters
        
        var headers = [String:String]()
        if let token = UserDefaults.standard.string(forKey: Constants.CACHE_KEY_TOKEN){
            headers["token"] = token
        }
        self.headers = headers
    }
}
