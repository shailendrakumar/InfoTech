//
//  MovieCell.swift
//  InfoTechDemo
//
//  Created by Shailendra on 2/08/21
//


import UIKit
import CoreData

class MovieCell: UITableViewCell {
    
    //MARK:- PROPERTIES
    @IBOutlet weak var movieNameLabel : UILabel!
    @IBOutlet weak var yearLabel      : UILabel!
    @IBOutlet weak var typeLabel      : UILabel!
    @IBOutlet weak var movieImageView : UIImageView!
    @IBOutlet weak var movieBgView    : UIView!
    @IBOutlet weak var movieButton    : UIButton!
   
    //MARK:- awakeFromNib
    override func awakeFromNib() {
        self.movieImageView.layer.cornerRadius = 10
        self.movieBgView.layer.cornerRadius    = 10
        super.awakeFromNib()
    }
    //MARK:- Configure UITableView Cell
    public func configureCell(search:Search){
        self.movieNameLabel.text = search.title
        self.yearLabel.text = .kYear + search.year
        self.typeLabel.text = .kType + search.type.rawValue
        self.movieImageView.sd_setImage(with: URL(string: search.poster), placeholderImage: UIImage(named: ImageName.NoMovie.rawValue))
    }
}
