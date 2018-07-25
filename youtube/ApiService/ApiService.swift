//
//  ApiService.swift
//  youtube
//
//  Created by Baur on 6/30/18.
//  Copyright © 2018 Baur. All rights reserved.
//

import UIKit

class ApiService: NSObject {
    
    static let sharedInstance = ApiService()
    
    let baseUrl = "https://s3-us-west-2.amazonaws.com/youtubeassets"
    
    func fetchVideos(completion: @escaping ([Video]) -> ()) {
        fetchFeedForUrlString(urlString: "\(baseUrl)/home_num_likes.json", completion: completion)
    }
    
    func fetchTrendingFeed(completion: @escaping ([Video]) -> ()) {
        fetchFeedForUrlString(urlString: "\(baseUrl)/trending.json", completion: completion)
    }
    func fetchSuscriptionFeed(completion: @escaping ([Video]) -> ()) {
        fetchFeedForUrlString(urlString: "\(baseUrl)/subscriptions.json", completion: completion)
    }
    
    func fetchFeedForUrlString(urlString: String, completion: @escaping ([Video]) -> ()){
        
        let url = URL(string: urlString)
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if error != nil {
                print(error!.localizedDescription)
                return
            }
            
            do {
                if let unwrappedData = data, let jsonDictinaries = try JSONSerialization.jsonObject(with: unwrappedData, options: .mutableContainers) as? [[String: AnyObject]] {
//                    var numbersArray = [1, 2, 3]
//                    let doubledNumbersArray = numbersArray.map({return $0 * 2})
//                    let stringArray = numbersArray.map({return "\($0 * 2 )"})
//                    print(stringArray)
                    
                    var  videos = [Video]()
                    
                    for dictinary in jsonDictinaries {
                        
                        let video = Video()
                        video.title = dictinary["title"] as? String
                        video.thumbnailImageName = dictinary["thumbnail_image_name"] as? String
                        video.numberOfViews = dictinary["number_of_views"] as? NSNumber
                        
                        let channelDictionary = dictinary["channel"] as! [String: AnyObject]
                        let channel = Channel()
                        channel.name = channelDictionary["name"] as? String
                        channel.profileImageName = channelDictionary["profile_image_name"] as? String
                        
                        video.channel = channel
                        videos.append(video)
                    }
                    
//                    let videos = jsonDictinaries.map({return Video(dictionary: $0)})
                    
                    DispatchQueue.main.async {
                        completion(videos)
                    }
                    
                }
                
                
            } catch let jsonError{
                print(jsonError)
            }
            
            
            }.resume()
    }
    

}

//let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
//
//var  videos = [Video]()
//
//for dictinary in json as! [[String: AnyObject]] {
//
//    let video = Video()
//    video.title = dictinary["title"] as? String
//    video.thumbnailImageName = dictinary["thumbnail_image_name"] as? String
//    video.numberOfViews = dictinary["number_of_views"] as? NSNumber
//
//
//    let channelDictionary = dictinary["channel"] as! [String: AnyObject]
//
//    let channel = Channel()
//    channel.name = channelDictionary["name"] as? String
//    channel.profileImageName = channelDictionary["profile_image_name"] as? String
//
//    video.channel = channel
//
//    videos.append(video)
//}
//
//DispatchQueue.main.async {
//    completion(videos)
//}
