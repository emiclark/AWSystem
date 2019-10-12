//
//  ApiClient.swift
//  AcuDragon
//
//  Created by Emiko Clark on 4/5/18.
//  Copyright © 2018 Emiko Clark. All rights reserved.
//

import UIKit

protocol reloadDataDelegate {
    func updateUI()
}

class ApiClient {
    
    static var videosArray = Video()
    var delegate: reloadDataDelegate?

    func EmptyFlagIsTrueGetDataFromLocalFile() {
        // for test purpose only - read from local file

        if let url = Bundle.main.url(forResource: "aws1", withExtension: "txt") {
            do {
                let data = try Data(contentsOf: url)
                ApiClient.videosArray = try JSONDecoder().decode(Video.self, from: data)
            } catch {
                print("error:\(error)")
            }
        }
        DispatchQueue.main.async() {
            self.delegate?.updateUI()
        }
    }

    
    func fetchVideos(pageNum: Int) {

        // AcuDragon search by channelId
        let urlString = "https://www.googleapis.com/youtube/v3/playlists?part=id.kind=youtube#video&status&channelId=\(secret.awsChannelId)&list=\(secret.awsplaylist_privateForApp)&key=\(secret.myAPIKey)"

//        let urlString = "https://www.googleapis.com/youtube/v3/playlists?part=id.kind=youtube#video&status&channelId=\(secret.awsChannelId)&list=\(secret.awsplaylist_privateForApp)&key=AIzaSyCz7ChsZALe88gbZuQyexQY82oQ1de6qZU"

        
//        let urlString = "\(Constants.baseUrlString)\(secret.myAPIKey)&channelId=\(secret.awsChannelId)&part=snippet,id&list=\(secret.awsplaylist_privateForApp)"

        let url = URL(string: urlString)
        let urlRequest = URLRequest(url: url!)
        
        getVideoData(urlRequest: urlRequest, completion: { (Video) in
            ApiClient.videosArray = Video
            
            DispatchQueue.main.async() {
                self.delegate?.updateUI()
            }
        })
    }

    func getVideoData(urlRequest: URLRequest, completion: @escaping (_ jsonArr: Video) -> ()) {

        
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in

            if error != nil {
                print(error!)
                return
            }

            guard let data  = data else { return }

            do {
                ApiClient.videosArray = try JSONDecoder().decode(Video.self, from: data)
                
                DispatchQueue.main.async {
                    dump(ApiClient.videosArray)
                    print((ApiClient.videosArray.items?.count)!)
                }
                
                completion(ApiClient.videosArray)

            } catch let error {
                print(error)
            }
        }.resume()
    }

    
    func downloadImage(urlString: String, completion: @escaping(UIImage?)->()) {
       
        if let url = URL(string: urlString) {
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print(error!)
                    return
                }
                
                guard let data = data else { return }
                let img = UIImage(data: data)
                
                DispatchQueue.main.async() {
                    completion(img)
                    self.delegate?.updateUI()
                }
            }.resume()
        }
    }
}

//=========================================
////  b4 refactor to aws
//
//import UIKit
//
//protocol reloadDataDelegate {
//    func updateUI()
//}
//
//class ApiClient {
//
//    static var videosArray = Video()
//    var delegate: reloadDataDelegate?
//
//    func fetchVideos(pageNum: Int) {
//
//        //        let urlString = "https://www.googleapis.com/youtube/v3/playlists?part=id%2Cstatus&channelId=UCD5kT8GTKnbYl9WxgnLM0aA&list=PLkHZi0mdFMbx60Xr8ZV6naErxSbUIyldo&maxResults=20&key=AIzaSyCz7ChsZALe88gbZuQyexQY82oQ1de6qZU"
//
//        // EC url
//        //        let urlString = "\(Constants.baseUrlString)\(secret.myAPIKey)&channelId=\(secret.myECChannel)&part=snippet,id"
//
//        // AcuDragon search by channelId
//        let urlString = "\(Constants.baseUrlString)\(secret.myAPIKey)&channelId=\(secret.awsChannelId)&part=snippet,id&list=\(secret.awsplaylist_privateForApp)"
//
//        // AcuDragon search by playlist="All"
//        //        let urlString = "https://www.googleapis.com/youtube/v3/playlists?part=id%2Cstatus&channelId=\(secret.adChannelId)&list=\(secret.adplaylistAll)&maxResults=20&key=AIzaSyCz7ChsZALe88gbZuQyexQY82oQ1de6qZU"
//
//        let url = URL(string: urlString)
//        let urlRequest = URLRequest(url: url!)
//
//        getVideoData(urlRequest: urlRequest, completion: { (Video) in
//            ApiClient.videosArray = Video
//
//            DispatchQueue.main.async() {
//                self.delegate?.updateUI()
//            }
//        })
//    }
//
//    func getVideoData(urlRequest: URLRequest, completion: @escaping (_ jsonArr: Video) -> ()) {
//
//        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
//
//            if error != nil {
//                print(error!)
//                return
//            }
//
//            guard let data  = data else { return }
//
//            do {
//                ApiClient.videosArray = try JSONDecoder().decode(Video.self, from: data)
//
//                DispatchQueue.main.async {
//                    dump(ApiClient.videosArray)
//                    //                    print((ApiClient.videosArray.items?.count)!)
//
//
//                    // not returning private/unlisted. status = nil. should be public at the least.
//                    for item in ApiClient.videosArray.items!  {
//                        if item.status?.privacyStatus! == "private" || item.status?.privacyStatus! == "unlisted" {
//                            print("\n",item.etag!, item.id!, (item.status?.privacyStatus!)!)
//                        }
//
//                    }
//                }
//
//                completion(ApiClient.videosArray)
//
//            } catch let error {
//                print(error)
//            }
//            }.resume()
//    }
//
//
//    func downloadImage(urlString: String, completion: @escaping(UIImage?)->()) {
//
//        if let url = URL(string: urlString) {
//            URLSession.shared.dataTask(with: url) { (data, response, error) in
//                if error != nil {
//                    print(error!)
//                    return
//                }
//
//                guard let data = data else { return }
//                let img = UIImage(data: data)
//
//                DispatchQueue.main.async() {
//                    completion(img)
//                    //                    self.delegate?.updateUI()
//                }
//                }.resume()
//        }
//    }
//
//    //    func downloadImage(imageType: String, urlString: String) {
//    //        if let url = URL(string: urlString) {
//    //            URLSession.shared.dataTask(with: url) { (data, response, error) in
//    //                if error != nil {
//    //                    print(error!)
//    //                    return
//    //                }
//    //                guard let data = data else { return }
//    //
//    //                DispatchQueue.main.async() {
//    //                    if imageType == "videoThumbnail" {
//    //                        self.thumbnailImageView.image = UIImage(data: data)
//    //                    } else if imageType == "profile_image" {
//    //                        self.profileImageView.image = UIImage(data: data)
//    //                    }
//    //                    self.delegate?.updateUI()
//    //                }
//    //                }.resume()
//    //        }
//    //    }
//
//}

