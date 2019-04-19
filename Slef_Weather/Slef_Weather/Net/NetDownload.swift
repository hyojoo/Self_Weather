//
//  NetDownload.swift
//  MiaoTu-iOS
//
//  Created by 曹宇航 on 2018/10/25.
//  Copyright © 2018年 yunshang. All rights reserved.
//

import Alamofire

class NetDownload{
    
    //单例 - 简便写法
    static let inst = NetDownload()
    
    func download(_ urlDownload:URL, filePath:URL, complete:@escaping (_ urlLocal:String , _ error: Error?)->()){
        let destination: DownloadRequest.DownloadFileDestination = { _, _ in
            
            return (filePath, [.createIntermediateDirectories])
        }
        
        Alamofire.download(urlDownload.absoluteString, to: destination).response { response in
            print(response)
            
            if let path = response.destinationURL?.path {
                complete(path, nil)
//                let image = UIImage(contentsOfFile: imagePath)
            }
            if response.error != nil {
                complete("", response.error)
            }
        }
    }
        
}
