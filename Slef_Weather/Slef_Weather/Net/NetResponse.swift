//
//  NetResponse.swift
//  MiaoTu-iOS
//
//  Created by 曹宇航 on 2018/9/13.
//  Copyright © 2018年 yunshang. All rights reserved.
//

import HandyJSON

struct NetResponse<T: HandyJSON>:HandyJSON{
    
    var code: Int?
    var data: T?//json
    var message: String?
    
}

