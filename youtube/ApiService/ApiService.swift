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
        fetchFeedForUrlString(urlString: "\(baseUrl)/home.json", completion: completion)
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
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
                
                var  videos = [Video]()
                
                for dictinary in json as! [[String: AnyObject]] {
                    
                    let video = Video()
                    video.title = dictinary["title"] as? String
                    video.thumbnailImageName = dictinary["thumbnail_image_name"] as? String
                    
                    
                    let channelDictionary = dictinary["channel"] as! [String: AnyObject]
                    
                    let channel = Channel()
                    channel.name = channelDictionary["name"] as? String
                    channel.profileImageName = channelDictionary["profile_image_name"] as? String
                    
                    video.channel = channel
                    
                    videos.append(video)
                }
                
                DispatchQueue.main.async {
                    completion(videos)
                }
                
            } catch let jsonError{
                print(jsonError)
            }
            
            
            }.resume()
    }

}
