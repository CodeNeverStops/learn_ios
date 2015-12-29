//
//  ViewController.swift
//  IMDb
//
//  Created by wayne.you on 15/8/17.
//  Copyright (c) 2015年 lokizone. All rights reserved.
//

import UIKit

class ViewController: UIViewController, IMDbAPIControllerDelegate, UISearchBarDelegate {

    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releasedLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var plotLabel: UILabel!
    
    @IBOutlet weak var imdbSearchBar: UISearchBar!
    
    lazy var apiController: IMDbAPIController = IMDbAPIController(delegate: self)
    
    func didFinishIMDbSearch(result: Dictionary<String, String>) {
        self.titleLabel.text = result["Title"]
        self.releasedLabel.text = result["Released"]
        self.ratingLabel.text = result["Rated"] 
        self.plotLabel.text = result["Plot"]
        
        if let foundPosterUrl = result["Poster"] {
            self.formatImageFromPath(foundPosterUrl)
        }
    }
    
    func formatImageFromPath(path: String) {
        var posterUrl = NSURL(string: path)
        var posterImageData = NSData(contentsOfURL: posterUrl!)
        
        self.posterImageView.image = UIImage(data: posterImageData!)
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        self.apiController.searchIMDb(searchBar.text)
        // 重置搜索框状态
        searchBar.resignFirstResponder()
        searchBar.text = ""
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // self.apiController.delegate = self
        // Do any additional setup after loading the view, typically from a nib.
        
        let tapGesture = UITapGestureRecognizer(target: self, action: "userTappedInView:")
        self.view.addGestureRecognizer(tapGesture)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func userTappedInView(recoginzer: UITapGestureRecognizer) {
        self.imdbSearchBar.resignFirstResponder()
    }


}

