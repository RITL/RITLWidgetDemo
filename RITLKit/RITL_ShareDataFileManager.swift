//
//  RITL_ShareDataFileManager.swift
//  WidgetTest
//
//  Created by YueWen on 16/9/20.
//  Copyright © 2016年 YueWen. All rights reserved.
//
//
//  ************************************
//  共享数据的方法2
//  ************************************

import UIKit

/// 负责使用Group中的fileManager进行数据的共享类
class RITL_ShareDataFileManager: NSObject
{
    //组名
    private static let groupIdentifier : String = "group.com.yue.WidgetTest"
    
    //存储的路径
    private static let dataSavePathFile : String = "Library/Caches/widgetTest"
    
    
    /// 保存数据
    open class func saveData(_ value:String) -> Bool
    {
        //进行存储
        do {
            try value.write(to: __fileManagerSavePath(), atomically: true, encoding: String.Encoding.utf8)
            
        } catch _ as NSError {//出错
            
            return false
        }
        
        return true
    }
    
    
    /// 获取数据
    open class func getData() -> String
    {
        //用于接收数据
        var value : String
        
        do {//读取数据
            try value = String(contentsOf: __fileManagerSavePath())
            
        } catch _ as NSError {
            
            return ""//有误输出空字符串
        }
        
        return value
    }
    
    
    /// 清除数据
    open class func clearData() -> Bool
    {
        do {//开始删除
            try FileManager.default.removeItem(at: __fileManagerSavePath())
            
        } catch _ as NSError{
            
            return false
        }
        
        return true
    }
    
    
    
    /// 获得存储的路径
    private class func __fileManagerSavePath() -> URL
    {
        //获得当前的组的路径
        var url = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: RITL_ShareDataFileManager.groupIdentifier)
        
        //返回拼接完毕的路径
        url?.appendPathComponent(RITL_ShareDataFileManager.dataSavePathFile)
        
        return url!
    }
    
}
