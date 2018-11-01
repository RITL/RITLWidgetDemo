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
public final class RITL_ShareDataFileManager: NSObject
{
    fileprivate struct RITL_ShareDataConfig {
        //组名
        static let groupIdentifier: String = "group.com.yue.WidgetTest"
        //存储的路径
        static let dataSavePathFile: String = "Library/Caches/widgetTest"
    }
    
    /// 保存数据
    @discardableResult @objc public static func saveData(_ value:String) -> Bool {
        //进行存储
        do {
            try value.write(to: fileManagerSavePath(), atomically: true, encoding: String.Encoding.utf8)
            
        } catch _ as NSError {//出错
            return false
        }
        
        return true
    }
    
    
    /// 获取数据
    @objc public static func getData() -> String
    {
        //用于接收数据
        var value : String
        
        do {//读取数据
            try value = String(contentsOf: fileManagerSavePath())
        } catch _ as NSError {
            return ""//有误输出空字符串
        }
        return value
    }
    
    
    /// 清除数据
    @discardableResult @objc public static func clearData() -> Bool
    {
        do {//开始删除
            try FileManager.default.removeItem(at: fileManagerSavePath())
            
        } catch _ as NSError{
            
            return false
        }
        
        return true
    }
    
    
    // MARK: Private
    
    /// 获得存储的路径
    private static func fileManagerSavePath() -> URL
    {
        //获得当前的组的路径
        var url = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: RITL_ShareDataConfig.groupIdentifier)
        
        //返回拼接完毕的路径
        url?.appendPathComponent(RITL_ShareDataConfig.dataSavePathFile)
        
        return url!
    }
    
}
