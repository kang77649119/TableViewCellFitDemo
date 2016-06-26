//
//  Joke.swift
//  TableViewCellFitDemo
//
//  Created by 也许、 on 16/6/25.
//  Copyright © 2016年 K. All rights reserved.
//

import UIKit

class Joke: NSObject {

    // 作者
    var author:String?
    
    // 内容
    var content:String?
    
    // 配图
    var picUrl:String?
    
    var cellHeight:CGFloat {
        
        get {
            
            let content = NSString(string: self.content!)
            
            // 笑话内容label距离单元格顶部的间距
            let contentY:CGFloat = headPortraitH +  cellMargin * 2
            
            // 计算笑话内容文字的高度
            let maxSize = CGSizeMake(screenW - cellMargin * 2, CGFloat.max)
            let contentH = content.boundingRectWithSize(maxSize, options: .UsesLineFragmentOrigin, attributes: [ NSFontAttributeName : UIFont.systemFontOfSize(13) ], context: nil).size.height
            
            // 计算配图的高度
            var cellH = contentY + contentH + cellMargin
            let picurl = self.picUrl
            if picurl != nil && !picurl!.isEmpty {
                cellH += 320
            }

            return cellH
            
        }
    
    }
    
    
}
