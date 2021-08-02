

import Foundation
import UIKit

extension UIView{
    func boaderProperty(_ cornerRadius:CGFloat, _ borderColor: CGColor, _ borderWidth:CGFloat){
        self.layer.cornerRadius = cornerRadius
        self.layer.borderColor = borderColor
        self.layer.borderWidth = borderWidth
    }
    func Shadow(){
        self.layer.cornerRadius = 30.0
        self.mask?.layer.cornerRadius = 2.0
        self.layer.shadowRadius = 3.0;
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: -1.0, height: 2.0)
        self.layer.shadowOpacity = 0.7
        self.layer.masksToBounds = false
    }
    func ViewAnimation(){
        self.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
        UIView.animate(withDuration: 3.0,
                       delay: 0,
                       usingSpringWithDamping: CGFloat(0.20),
                       initialSpringVelocity: CGFloat(6.0),
                       options: UIView.AnimationOptions.allowUserInteraction,
                       animations: {
                        self.transform = CGAffineTransform.identity
        },
                       completion: { Void in()  }
        )
    }
}

extension UILabel{
    func Animation(){
        self.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
        UIView.animate(withDuration: 3.0,
                       delay: 0,
                       usingSpringWithDamping: CGFloat(0.20),
                       initialSpringVelocity: CGFloat(6.0),
                       options: UIView.AnimationOptions.allowUserInteraction,
                       animations: {
                        self.transform = CGAffineTransform.identity
        },
                       completion: { Void in()  }
        )
    }
}

extension UIImageView{
    func boaderPropertyImageView(_ cornerRadius:CGFloat, _ borderColor: CGColor, _ borderWidth:CGFloat){
        self.layer.cornerRadius = cornerRadius
        self.layer.borderColor = borderColor
        self.layer.borderWidth = borderWidth
    }
    func Animation(){
        self.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
        UIView.animate(withDuration: 3.0,
                       delay: 0,
                       usingSpringWithDamping: CGFloat(0.20),
                       initialSpringVelocity: CGFloat(6.0),
                       options: UIView.AnimationOptions.allowUserInteraction,
                       animations: {
                        self.transform = CGAffineTransform.identity
                       },
                       completion: { Void in()  }
        )
    }
}

extension UIButton{
    func Animation(){
        self.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
        UIView.animate(withDuration: 3.0,
                       delay: 0,
                       usingSpringWithDamping: CGFloat(0.20),
                       initialSpringVelocity: CGFloat(6.0),
                       options: UIView.AnimationOptions.allowUserInteraction,
                       animations: {
                        self.transform = CGAffineTransform.identity
                       },
                       completion: { Void in()  }
        )
    }
}

extension String{
    static let kEmpty          = ""
    static let kOK             = "OK"
    static let kMovie          = "movie"
    static let kYear           = "Year : "
    static let kType           = "Type : "
    static let kTrue           = "True"
    static let kSomethingWorng = "Something went worng from server side"
}
