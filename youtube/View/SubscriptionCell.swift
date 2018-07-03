 //
//  SubscriptionCell.swift
//  youtube
//
//  Created by Baur on 7/3/18.
//  Copyright © 2018 Baur. All rights reserved.
//

import UIKit

class SubscriptionCell: FeedCell {
    
    override func fetchVideos() {
        ApiService.sharedInstance.fetchSuscriptionFeed { (videos) in
            self.videos = videos
            self.collectionView.reloadData()
        } 
    }
    
}
