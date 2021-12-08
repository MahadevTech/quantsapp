//
//  vm_category.swift
//  Quantsapp
//
//  Created by Mahadev on 07/12/21.
//

import Foundation

let jsonD = JSONDecoder()
class vm_category {
    
    let webReq = webServices()

    
    func getCategoryData(completion: @escaping (_ data: model_categoryRootClass?,_ error: String) -> ()){
        let url = cfg.url
        webReq.getRequest_new(url)  { (data, error) in
            if error == ""{
                do{
                    let resp = try jsonD.decode(model_categoryRootClass.self, from: data)
                    completion(resp,error)
                }
                catch
                {
                   completion(nil,"No Data!")
                }
               
            }
            else{
                completion(nil,error)
            }
        }
        
    }
    

}
