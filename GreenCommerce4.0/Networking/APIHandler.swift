//
//  APIHandler.swift
//  GreenCommerce4.0
//
//  Created by Preston Perriott on 10/23/17.
//  Copyright © 2017 Preston Perriott. All rights reserved.
//

import UIKit

enum endPoints: String {
    
    //Options for CIndustry Journal
    case feed = "feed"
    
    //Options for CReports.com
    case strains = "strains"
    case news = "news"
    case flowers = "flowers"
    case extracts = "extracts"
    case dispensaries = "dispensaries"
    case product = "product"
    case producers = "producers"
    
    //Options for Google Maps?
    
 }
class APIHandler: NSObject {
    //Base URLS for both sites
    let CReportsBaseURL = "https://www.cannabisreports.com/api/v1.0/"
    
    let CIndustryBaseURL = "https://www.cannabisindustryjournal.com/"
    
    let localHost = "localhost:"
    let port = "3000/users/mobile"
    
    //Will probably need a computed value to tell us which end point to append
    /*
     
     */
    
    //shared instance returning the one and only instance of the APIHandler each time its called
    static let sharedInstance = APIHandler()
    
    //wrapper for data task, takes a NSURLRequest and method name
    //returns an indicator of success and decoded JSON
    
    //**Remember** A completion is just a function wrapped up into a parameter
    //Our completion here takes a bool and object and returns void
    private func dataTask(request: NSMutableURLRequest, method: String, completion: @escaping (_ success: Bool, _ object: AnyObject?) -> () ){
        
        request.httpMethod = method
        
        let session = URLSession(configuration: URLSessionConfiguration.default)
        
        //The "in" keyword is how we pass the params into the block, alternatives are $0, $1
        session.dataTask(with: request as URLRequest)
        {
            (data, response, error) -> Void in
            if let data = data {
                if let json = try? JSONSerialization.jsonObject(with: data, options: [])
                    {
                    print("The JSON Object recieved was : \(String(describing: json) )")
                    DispatchQueue.main.async() {
                        completion(true, json as AnyObject)
                    }
                } else {
                    print("Our errors from the request were : \(String(describing: error))")
                    completion(false, response as AnyObject)
                }
            }
            }.resume()
        }
    
    //Post
    //wrapping the common task "dataTask" into smaller methods that specify the HTTP Method
    private func post(request: NSMutableURLRequest, completion: @escaping (_ success: Bool, _ object: AnyObject?)->()){
        
        dataTask(request: request, method: "POST", completion: completion)
    }
    //Put
    private func put(request: NSMutableURLRequest, completion: @escaping (_ success: Bool, _ object: AnyObject?)->() ){
        
        dataTask(request: request, method:"PUT", completion: completion)
    }
    //Get
    private func get(request: NSMutableURLRequest, completion: @escaping (_ success: Bool, _ object: AnyObject?)->()){
        
        dataTask(request: request, method: "GET", completion: completion)
    }
    
    func getFromNodeservice(requestString: String){
        let baseroute: String = localHost + port
        if let baseUrl = URL(string: baseroute) {
        let request: NSMutableURLRequest = NSMutableURLRequest(url: baseUrl)
            get(request: request, completion: {(ok, obj) in
                print("Our object is \(String(describing: obj))")
            })
      
        }
        
    }
    
}
