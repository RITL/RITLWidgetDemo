//
//  RITL_UserDefaultsManager.swift
//  WidgetTest
//
//  Created by YueWen on 16/9/20.
//  Copyright © 2016年 YueWen. All rights reserved.
//
//
//  ************************************
//  共享数据的方法1
//  ************************************

import UIKit


/// 负责使用Group中的userDefault进行数据的共享类
class RITL_UserDefaultsManager: NSObject
{
    //组名
    private static let groupIdentifier : String = "group.com.yue.WidgetTest"
    
    //存放数据的键值
    private static let defaultKey : String = "com.yue.WidgetTest.value"
    
    
    /// 保存数据
    open class func saveData(_ value : String)
    {
        //保存数据
        __userDefault().set(value, forKey: RITL_UserDefaultsManager.defaultKey)
    }

    
    /// 获取数据
    open class func getData() -> String!
    {
        //如果值为nil,表示没有存过值，返回默认的值
        let value = (__userDefault().value(forKey: RITL_UserDefaultsManager.defaultKey))
        
        guard value == nil else {
            
            return value as! String
        }

        return ""
    }
    
    
    /// 清除数据
    open class func clearData()
    {
        __userDefault().removeSuite(named: RITL_UserDefaultsManager.groupIdentifier)
    }
    
    
    
    /// 获得userDefualtFile
    private class func __userDefault() -> UserDefaults
    {
        return UserDefaults(suiteName: RITL_UserDefaultsManager.groupIdentifier)!
    }
    
}
