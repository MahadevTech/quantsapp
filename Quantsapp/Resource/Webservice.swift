//
//  Webservice.swift
//  Quantsapp
//
//  Created by Mahadev on 07/12/21.
//



import Foundation
import UIKit

protocol webServicesDelegate {
    func responseData(data : Data, reqId : String)
    func errorResponse(err : String, reqId : String)
}

class webServices {
    
    
    var delegate : webServicesDelegate? = nil
    var requestId : String = ""
    func getRequest(reqStr : String,requestId: String,completion: @escaping (_ data: AnyObject?, _ error: String) -> ()){
        
        print("Request Url : \(reqStr)")
        
        let request = NSMutableURLRequest(url: URL(string: reqStr.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!)!)
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        request.httpMethod = "GET"
        request.timeoutInterval = 25
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            (data, response, error) in DispatchQueue.main.async(execute: {
                if error != nil {
                    self.delegate?.errorResponse(err :cfg.no_internet,reqId: requestId)
                }
                else {
                    let httpResponse = response as! HTTPURLResponse
                    print("httpResponse -> \(httpResponse.statusCode)")
                    switch httpResponse.statusCode {
                    case 503:
                        self.delegate?.errorResponse(err :cfg.err_no_503,reqId: requestId)
                        break
                    case 404:
                        self.delegate?.errorResponse(err :cfg.err_no_404,reqId: requestId)
                        break
                    case 200:
                        self.delegate?.responseData(data :data!,reqId: requestId)
                        break
                    case 0:
                        self.delegate?.errorResponse(err :cfg.err_no_0,reqId: requestId)
                        break
                    default:
                        self.delegate?.errorResponse(err :cfg.err_default,reqId: requestId)
                        break
                    }
                }
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            })
        }
        task.resume()
    }
    
    func getRequest_new(_ reqUrl : String, completion: @escaping (_ data: Data, _ error: String)->()){
        
        
        
        print("Request Str : \(reqUrl)")
        
        let request = NSMutableURLRequest(url: URL(string: reqUrl.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!)!)
        
        
        //UIApplication.shared.isNetworkActivityIndicatorVisible = true
        //        let postString = postParams
        request.httpMethod = "GET"
        request.timeoutInterval = 15
        
        
        
        let taskCaller = URLSession.shared.dataTask(with: request as URLRequest) { (data, response, error) in
            DispatchQueue.global(qos: .userInitiated).async {
                DispatchQueue.main.async {
                    if error != nil{
                        completion(Data(),"error")
                    }
                    else{
                        let resp = response as! HTTPURLResponse
                        let status = resp.statusCode
                        print(status)
                        switch status{
                        case 200:
                            completion(data!,"")
                            break
                        case 1002:
                            completion(data!,cfg.err_no_0)
                            break
                        case 1003:
                            completion(data!,cfg.err_no_0)
                            break
                        case 1001:
                            completion(data!,cfg.err_no_0)
                            break
                        default:
                            completion(Data(),self.errorMsg(status))
                            break
                        }
                        
                    }
                }
            }
        }
        
        taskCaller.resume()
    }
    func errorMsg(_ status: Int) -> String{
        var msg = cfg.err_default
        switch status {
        case 500:
            msg = cfg.err_no_503
            break
        case 404:
            msg = cfg.err_no_404
            break
        case 1000:
            msg = cfg.err_no_0
            break
        case 1001:
            msg = cfg.err_default
            break
        case 1002:
            msg = cfg.err_default
            break
        case 0:
            msg = cfg.err_default
            break
        default:
            break
        }
        
        return msg
    }
}
