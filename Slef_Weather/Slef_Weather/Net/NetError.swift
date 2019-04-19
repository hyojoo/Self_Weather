//
//  NetError.swift
//  MiaoTu-iOS
//
//  Created by 曹宇航 on 2018/9/14.
//  Copyright © 2018年 yunshang. All rights reserved.
//

struct NetError: Error {
    
    var desc = ""
    var localizedDescription: String {
        return desc
    }
    
    init(_ desc: String?) {
        if let s = desc {
            self.desc = s
        }
    }
    
    static func failureError(_ desc: String?) -> NetError{
        return NetError(desc)
    }
    static func parseError(_ desc: String?) -> NetError{
        return NetError(desc)
    }
    static func voidDataError(_ desc: String?) -> NetError{
        return NetError(desc)
    }
    
//    case failureError(String?)
//    case parseError(String?)
//    case voidDataError(String?)
    
}
