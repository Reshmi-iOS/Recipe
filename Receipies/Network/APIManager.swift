//
//  APIManager.swift
//  Receipies
//
//  Created by Apple on 27/03/24.
//

import Foundation
import UIKit
struct EndPoints{
    static let  mealsListURL = "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert"
    static let mealDetail = "https://themealdb.com/api/json/v1/1/lookup.php?i="
    
}
//Preparing URL request
enum APIEndoints{
    case mealsList
    case mealsDetail(mealID:String)
    
    func urlRequest() -> URLRequest{
        switch self{
        case .mealsList:
            let url = EndPoints.mealsListURL
            var urlRuest = URLRequest(url: URL(string: url)!)
            urlRuest.httpMethod = "GET"
            return urlRuest
        case .mealsDetail(let mealId):
            let url = EndPoints.mealDetail + mealId
            var urlRuest = URLRequest(url: URL(string: url)!)
            urlRuest.httpMethod = "GET"
            return urlRuest
        }
    }
}
struct APIManager{
    static let shared = APIManager()
    func callAPI(request:URLRequest,completion:@escaping ((Data?) -> Void)){
        let task = URLSession.shared.dataTask(with: request, completionHandler: { (data,response,error) in
            if error == nil{
                print(try! JSONSerialization.jsonObject(with: data!, options: []) as? [String:Any])
                return completion(data)
            }
        })
        task.resume()
    }
}
extension APIManager{
    func mealsListAPICall(completion:@escaping((Data?) -> Void)){
        self.callAPI(request: APIEndoints.mealsList.urlRequest(), completion: completion)
    }
    func mealsDetailAPICall(mealID:String,completion:@escaping((Data?) -> Void)){
        self.callAPI(request: APIEndoints.mealsDetail(mealID: mealID).urlRequest(), completion: completion)
    }
}
extension UIImageView{
    func downloadImage(from url: URL) {
        print("Download Started")
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")
            // always update the UI from the main thread
            DispatchQueue.main.async() { [weak self] in
                self?.image = UIImage(data: data)
            }
        }
    }
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
}
