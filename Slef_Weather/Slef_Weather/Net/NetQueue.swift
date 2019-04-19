//
//  NetQueue.swift
//  MiaoTu-iOS
//
//  Created by 曹宇航 on 2018/9/13.
//  Copyright © 2018年 yunshang. All rights reserved.
//

import Alamofire
import HandyJSON

typealias mul = ((MultipartFormData) -> Void)
class NetQueue{
    
    //单例 - 简便写法
    static let inst = NetQueue()
    
    /*
     请求
     注：static func 相当于 class final func，禁止方法被重写。此处未使用
     @discardableResult 不处理返回值
     */
    func request<T:HandyJSON>(url: String, params: [String: Any]?, _ complete: @escaping (_ data: T , _ error: NetError?)->()) -> Void {
        print(url)
        print(params as Any)
        
        var headers: HTTPHeaders = ["Accept": "application/json;text/json;text/javascript;text/html"]
        if let token = UserDefaults.standard.string(forKey: Constants.CACHE_KEY_TOKEN){
//            headers["token"] = token
            headers.updateValue(token, forKey: "token")
        }
        Alamofire
            .request(
                url,
                method: .post,
                parameters: params,
                encoding: URLEncoding.default,
                headers: headers
            )
            .responseString { (response) in
                self.parse(response, complete)
        }
    }
    
    
    /*
     请求
     注：static func 相当于 class final func，禁止方法被重写。此处未使用
     @discardableResult 不处理返回值
     */
    func request<T:HandyJSON>(_ req:NetRequest,_ complete:@escaping (_ data: T , _ error: NetError?)->()) -> Void {
        print(req.url)
        print(req.parameters)
        print(req.headers)
        Alamofire
            .request(
                req.url,
                method:.post,
                parameters:req.parameters,
                encoding:URLEncoding.default,
                headers: req.headers
            )
            .responseString { (response) in
                self.parse(response, complete)
        }
    }
    
    /*
     上传
     */
    func upload<T:HandyJSON>(_ req:NetRequest, fileName: String? = nil, _ complete:@escaping (_ data: T , _ error: NetError?)->()) {
        print(req.url)
        print(req.parameters)
        Alamofire
            .upload(
                multipartFormData: {(multipartFormData) in
                    for (key, value) in req.parameters {
                        if value is URL{
                            multipartFormData.append(value as! URL, withName: key)
                        }else if value is Data{
                            let name = fileName ?? key
                            multipartFormData.append(value as! Data, withName: key, fileName: name, mimeType: "image/*")
                        }else {
                            let encodingData = String(describing: value).data(using: .utf8, allowLossyConversion: false)!
                            multipartFormData.append(encodingData, withName: key)
                        }
                    }
                },
                to: req.url,
                method: .post,
                headers: req.headers
                )
            { (encodingResult) in
                switch encodingResult {
                case .success(let upload, _, _):
                    upload.responseString { (response) in
                        self.parse(response, complete)
                    }
                case .failure(let encodingError):
                    complete(T(),NetError.failureError(encodingError.localizedDescription))
                }
        }
        
    }
    
    func parse<T:HandyJSON>(_ resp:DataResponse<String>, _ complete:@escaping (_ data: T , _ error: NetError?)->()) {
        if resp.result.isSuccess {//请求成功
            //数据为空
            guard let value = resp.value else {
                complete(T(),NetError.voidDataError("无返回内容"))
                return
            }
            print(value)
            //解析数据
            if let result = JSONDeserializer<NetResponse<T>>.deserializeFrom(json: value) {
                //有效数据
                if result.code == 0 {
                    if let data = result.data {
                        complete(data,nil)
                    }else{
                        complete(T(),NetError.voidDataError("没有内容"))
                    }
                }else{
                    complete(T(),NetError.voidDataError(result.message))
                }
                
            }else{
                complete(T(),NetError.parseError("返回解析错误"))
            }
            
        }else{//网络异常
            print("===》请求失败")
            if let error = resp.error {
                let failure = error.localizedDescription
                complete(T(),NetError.failureError(failure))
                print(failure)
                print(resp.result.isSuccess)
            }else{
                complete(T(),NetError.failureError("网络错误"))
            }
        }
    }
    
}
