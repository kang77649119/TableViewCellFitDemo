//
//  JokeCell.swift
//  TableViewCellFitDemo
//
//  Created by 也许、 on 16/6/24.
//  Copyright © 2016年 K. All rights reserved.
//

import UIKit

class JokeCell: UITableViewCell {
    
    // 头像
    @IBOutlet weak var headPortrait: UIImageView!
    
    // 昵称
    @IBOutlet weak var nickName: UILabel!
    
    // 笑话内容
    @IBOutlet weak var jokeContent: UILabel!
    
    // 配图
    @IBOutlet weak var picture: UIImageView!
    
    // 笑话计算属性
    var joke:Joke = Joke() {
        
        didSet {
            
            self.headPortrait.image = UIImage(named: "test")
            self.nickName.text = joke.author
            self.jokeContent.text = joke.content
           
            if joke.picUrl != nil {
                if !joke.picUrl!.isEmpty {
                    self.picture.hidden = false
                    self.picture.sd_setImageWithURL(NSURL(string: joke.picUrl!))
                } else {
                    self.picture.hidden = true
                }
            }
            
        }
    
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        self.autoresizingMask = .None
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
