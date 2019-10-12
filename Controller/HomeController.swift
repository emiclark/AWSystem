//
//  ViewController.swift
//  AcuDragon
//
//  Created by Emiko Clark on 1/22/18.
//  Copyright © 2018 Emiko Clark. All rights reserved.
//

import UIKit

let videoHeight = (UIScreen.main.bounds.width - 16 - 16) * 9 / 16

var stackviewHeight: CGFloat {
    // calculate stackview height to adjust videoCell
    return 80.0
}
class HomeController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    override func viewDidLoad() {
        super.viewDidLoad()
        let navTitleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
        navigationItem.titleView = navTitleLabel
        navTitleLabel.text = "Home"
        navTitleLabel.textColor = .white
        navTitleLabel.font = UIFont.systemFont(ofSize: 20)
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = Constants.awsRed
        collectionView?.backgroundColor = .white
        collectionView?.register(VideoCell.self, forCellWithReuseIdentifier: "cellId")
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: videoHeight + stackviewHeight)
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! VideoCell
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
// 2018 back - wip
//
//class HomeController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
//
//    let menuBar: MenuBar = {
//        let mb = MenuBar()
//        return mb
//    }()
//
//    var activityIndicator: UIActivityIndicatorView!
//    let apiClient = ApiClient()
//    let pageNum = Constants.pageNum
//    var isEmptyStateFlag = true
//
//    // MARK:- View Methods
//    override func viewWillAppear(_ animated: Bool) {
//        initializeVideoModelForEmptyState()
//    }
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        apiClient.delegate = self
//
//        startActivityIndicator()
//        setupViewController()
////        self.apiClient.fetchVideos(pageNum: pageNum)
//
//        // for test purpose using local json
//        if isEmptyStateFlag == true {
//            setupViewController()
//        } else {
//            // regular api call
//            //        self.apiClient.fetchVideos(pageNum: pageNum)
//
//        }
//
//    }
//
//    // MARK:- Setup/Initialization Methods
//    func initializeVideoModelForEmptyState() {
//
//        // create empty video array for empty state
//        let videoArray = Video()
//        videoArray.etag = " "
//        videoArray.items = [Items]()
//
//        let itemsArr = Items()
//        itemsArr.etag = " "
//        itemsArr.channelTitle = " "
//        itemsArr.id = Id()
//        itemsArr.id?.playlistId = " "
//
//        var snippet = Snippet()
//        snippet.channelId = " "
//        snippet.title = " "
//        snippet.description = " "
//
//        var videoThumbnails = VideoThumbnails()
//        videoThumbnails.high = Thumbnails()
//
//        videoThumbnails.high?.url = " "
//        videoThumbnails.high?.height = 0
//        videoThumbnails.high?.width = 0
//
//        snippet.thumbnails = videoThumbnails
//        itemsArr.snippet = snippet
//        videoArray.items?.append(itemsArr)
//        ApiClient.videosArray = videoArray
//    }
//
//    func startActivityIndicator() {
//        self.activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.whiteLarge)
//        self.activityIndicator.color = .blue
//        self.activityIndicator.center = view.center
//        self.activityIndicator.hidesWhenStopped = false
//        self.activityIndicator.startAnimating()
//        view.addSubview(self.activityIndicator)
//    }
//
//    func setupViewController() {
//        // Register cell
//        self.collectionView!.register(VideoCell.self, forCellWithReuseIdentifier: "cellid")
//
//        // adjust collectionview and scrollview to begin below menubar
//        collectionView?.contentInset = UIEdgeInsetsMake(50, 0, 0, 0)
//        collectionView?.scrollIndicatorInsets = UIEdgeInsetsMake(50, 0, 0, 0)
//
//        navigationController?.navigationBar.isTranslucent = false
//        navigationController?.navigationBar.barTintColor = UIColor(red: 230/255, green: 32/255, blue: 31/255, alpha: 1)
//
//        let navTitleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
//        navTitleLabel.text = "Home"
//        navTitleLabel.font = UIFont.systemFont(ofSize: 20)
//        navTitleLabel.textColor = UIColor.white
//        navigationItem.titleView = navTitleLabel
//        collectionView?.backgroundColor = UIColor.white
//
//        setupMenuBar()
//    }
//
//    private func setupMenuBar() {
//        view.addSubview(menuBar)
//        view.addConstraintsWithFormat(format: "H:|[v0]|", views: menuBar)
//        view.addConstraintsWithFormat(format: "V:|[v0(50)]", views: menuBar)
//    }
//
//    // MARK:- CollectionView Delegate Methods
//    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return (ApiClient.videosArray.items?.count)!
//    }
//
//    override func numberOfSections(in collectionView: UICollectionView) -> Int {
//        return 1
//    }
//
//    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellid", for: indexPath) as! VideoCell
//        let videoInfo = ApiClient.videosArray.items![indexPath.row]
//
//        print("\(String(describing: (videoInfo.snippet?.title!)!))\n\(String(describing: (videoInfo.snippet?.thumbnails?.high?.url!)!))\n*****\n")
//
//        if isEmptyStateFlag == true {
//            // empty state - draw minimal collectionview - get data from local file
//            apiClient.EmptyFlagIsTrueGetDataFromLocalFile()
//            isEmptyStateFlag = false
//        }
//        else {
//            // api called successfully
//            if videoInfo.id?.kind == "youtube#video" {
//                cell.titleLabel.text =  videoInfo.snippet?.title
//                cell.subtitleLabel.text =  videoInfo.snippet?.description
//                // MARK:- FIXME recusive download of thumbnails
////                apiClient.downloadImage(urlString: (videoInfo.snippet?.thumbnails?.high?.url!)!) { (thumbnailImage) in
////                    cell.thumbnailImageView.image = thumbnailImage
////                }
//            }
//        }
//        return cell
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let height = (view.frame.width - 16 - 16) * 9 / 16
//        VideoCell.videoHeight = height
//        return CGSize(width: view.frame.width, height: height)
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 0
//    }
//
//    // MARK:- TODO MenuBar Methods
//    @objc func handleSearch() {
//        print("123")
//    }
//
//    @objc func handleMore() {
//        print("234")
//    }
//}
//
//// MARK:- Extensions
//extension HomeController : reloadDataDelegate {
//    func updateUI() {
//        self.activityIndicator.stopAnimating()
//        self.activityIndicator.isHidden = true
//        self.collectionView?.reloadData()
//    }
//}

//===== backup homeController b4 snapkit ========
//class HomeController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
//    let vcell = VideoCell()
//
//    let menuBar: MenuBar = {
//        let mb = MenuBar()
//        return mb
//    }()
//
//    var activityIndicator: UIActivityIndicatorView!
//    let apiClient = ApiClient()
//    let pageNum = 0
//
//    // MARK:- View Methods
//    override func viewWillAppear(_ animated: Bool) {
//        initializeVideoModelForEmptyState()
//    }
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        apiClient.delegate = self
//
//        startActivityIndicator()
//        setupViewController()
//        self.apiClient.fetchVideos(pageNum: pageNum)
//    }
//
//    // MARK:- Setup/Initialization Methods
//    func initializeVideoModelForEmptyState() {
//
//        // create empty video array for empty state
//        let eva = Video()
//        eva.etag = " "
//        eva.items = [Items]()
//
//        var itemsArr = Items()
//        itemsArr.etag = " "
//        itemsArr.channelTitle = " "
//        itemsArr.id = Id()
//        itemsArr.id?.playlistId = " "
//
//        var snippet = Snippet()
//        snippet.channelId = " "
//        snippet.title = " "
//        snippet.description = " "
//
//        var videoThumbnails = VideoThumbnails()
//        videoThumbnails.high = Thumbnails()
//
//        videoThumbnails.high?.url = " "
//        videoThumbnails.high?.height = 0
//        videoThumbnails.high?.width = 0
//
//        snippet.thumbnails = videoThumbnails
//        itemsArr.snippet = snippet
//        eva.items?.append(itemsArr)
//        ApiClient.videosArray = eva
//    }
//
//    func startActivityIndicator() {
//        self.activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.whiteLarge)
//        self.activityIndicator.color = .blue
//        self.activityIndicator.center = view.center
//        self.activityIndicator.hidesWhenStopped = false
//        self.activityIndicator.startAnimating()
//        view.addSubview(self.activityIndicator)
//    }
//
//    func setupViewController() {
//        // Register cell
//        self.collectionView!.register(VideoCell.self, forCellWithReuseIdentifier: "cellid")
//
//        // adjust collectionview and scrollview to begin below menubar
//        collectionView?.contentInset = UIEdgeInsetsMake(50, 0, 0, 0)
//        collectionView?.scrollIndicatorInsets = UIEdgeInsetsMake(50, 0, 0, 0)
//
//        navigationController?.navigationBar.isTranslucent = false
//        navigationController?.navigationBar.barTintColor = UIColor(red: 230/255, green: 32/255, blue: 31/255, alpha: 1)
//
//        let navTitleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
//        navTitleLabel.text = "Home"
//        navTitleLabel.font = UIFont.systemFont(ofSize: 20)
//        navTitleLabel.textColor = UIColor.white
//        navigationItem.titleView = navTitleLabel
//        collectionView?.backgroundColor = UIColor.white
//
//        // add search to navbar
//        let searchIcon = UIImage(named:"searchIcon")?.withRenderingMode(.alwaysOriginal)
//        let searchBarButtonItem = UIBarButtonItem(image: searchIcon, style: .plain, target: self, action: #selector(handleSearch))
//
//        // add more to navbar
//        let moreIcon = UIImage(named:"moreIcon")?.withRenderingMode(.alwaysOriginal)
//        let moreBarButtonItem = UIBarButtonItem(image: moreIcon, style: .plain, target: self, action: #selector(handleMore))
//        navigationItem.rightBarButtonItems = [ moreBarButtonItem, searchBarButtonItem ]
//
//        setupMenuBar()
//    }
//
//    private func setupMenuBar() {
//        view.addSubview(menuBar)
//        view.addConstraintsWithFormat(format: "H:|[v0]|", views: menuBar)
//        view.addConstraintsWithFormat(format: "V:|[v0(50)]", views: menuBar)
//    }
//
//    // MARK:- CollectionView Delegate Methods
//    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return (ApiClient.videosArray.items?.count)!
//    }
//
//    override func numberOfSections(in collectionView: UICollectionView) -> Int {
//        return 1
//    }
//
//    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellid", for: indexPath) as! VideoCell
//        let videoInfo = ApiClient.videosArray.items![indexPath.row]
//        //        cell.videoItem = ApiClient.videosArray.items![indexPath.row]
//
//        cell.subTitleTextView.text =  videoInfo.channelTitle != nil ?  videoInfo.channelTitle : "AcuDragon Wellness System"
//        cell.subTitleTextView.text =  videoInfo.snippet?.description != nil ?  videoInfo.snippet?.description : "AcuDragon Wellness System"
//
//        apiClient.downloadImage(urlString: (videoInfo.snippet?.thumbnails?.high?.url!)!) { (thumbnailImage) in
//            cell.thumbnailImageView.image = thumbnailImage
//        }
//
//        cell.profileImageView.image = #imageLiteral(resourceName: "dragon")
//
//        return cell
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//
//        //     FIX:    calculate all object height+ vertical padding
//        //        let cell = videos[indexPath.row]
//        //        let height = (view.frame.width - 16 - 16) * 9 / 16
//
//        let height = (view.frame.width - 16 - 16) * 9 / 16
//        return CGSize(width: view.frame.width, height: height + 16 + 68)
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 0
//    }
//
//    // MARK:- MenuBar Methods
//    @objc func handleSearch() {
//        print("123")
//    }
//
//    @objc func handleMore() {
//        print("234")
//    }
//
//}
//
//// MARK:- Extensions
//extension HomeController : reloadDataDelegate {
//    func updateUI() {
//        self.activityIndicator.stopAnimating()
//        self.activityIndicator.isHidden = true
//        self.collectionView?.reloadData()
//    }
//}

