//
//  ViewController.swift
//  TableViewCellFitDemo
//
//  Created by 也许、 on 16/6/24.
//  Copyright © 2016年 K. All rights reserved.
//

import UIKit

// 间距
let cellMargin:CGFloat = 10

// 头像高度
let headPortraitH:CGFloat = 50

// 屏幕宽
let screenW = UIScreen.mainScreen().bounds.width

// 屏幕高
let screenH = UIScreen.mainScreen().bounds.height

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    // 接口地址
    let apiURL = "http://api.1-blog.com/biz/bizserver/xiaohua/list.do"
    
    // 单元格标识
    let jokeCellId = "jokeCellId"
    
    // 网络请求管理器
    lazy var afn = AFHTTPSessionManager()
    
    // 表格
    var jokeTable:UITableView?
    
    // 笑话集合
    var jokeArray:NSMutableArray?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 初始化组件
        initUI()
        
        // 加载最新数据
        initData()
        
    }
    
    /**
        初始化UI
     */
    func initUI() {
        
        let table = UITableView(frame: CGRectMake(0, 0, screenW, screenH))
        table.autoresizingMask = .None
        table.delegate = self
        table.dataSource = self
        self.view.addSubview(table)
        self.jokeTable = table

        table.registerNib( UINib(nibName: "JokeCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: jokeCellId)
       
    }
    
    /**
        加载数据
     */
    func initData() {
        
        self.jokeTable?.mj_header = MJRefreshHeader(refreshingTarget: self, refreshingAction: #selector(ViewController.loadNewData))
        self.jokeTable?.mj_header.beginRefreshing()
        
    }
    
    /**
        加载最新数据
     */
    func loadNewData() {
 
        let url = "http://api.1-blog.com/biz/bizserver/xiaohua/list.do"        
        let parameters = NSMutableDictionary()
        parameters["maxXhid"] = 51595
        parameters["minXhid"] = 51476
        parameters["size"] = 20
      
        afn.POST(url, parameters: parameters, progress: nil, success: { (task, response) in
            
            self.jokeTable?.mj_header.endRefreshing()
            self.jokeArray = Joke.mj_objectArrayWithKeyValuesArray(response?.objectForKey("detail"))
            self.jokeTable?.reloadData()
            
        }) { (task, error) in
            print("数据解析失败")
        }
        
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.jokeArray != nil ? self.jokeArray!.count : 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier(jokeCellId) as! JokeCell
        cell.joke = self.jokeArray![indexPath.row] as! Joke
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        let joke = self.jokeArray![indexPath.row] as! Joke
        return joke.cellHeight
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

