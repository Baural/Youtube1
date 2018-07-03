//
//  TrendingCell.swift
//  youtube
//
//  Created by Baur on 7/3/18.
//  Copyright © 2018 Baur. All rights reserved.
//

import UIKit

class TrendingCell: FeedCell {
    
    override func fetchVideos() {
        ApiService.sharedInstance.fetchTrendingFeed { (videos) in
            self.videos = videos
            self.collectionView.reloadData()
        }
    }
    
}
