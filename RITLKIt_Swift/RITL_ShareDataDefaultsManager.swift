//
//  RITL_ShareDataDefaultsManager.swift
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
public final class RITL_ShareDataDefaultsManager: NSObject {
    
    fileprivate struct RITL_ShareDataDefaultsConfig {
        //组名
        static let groupIdentifier: String = "group.com.yue.WidgetTest"
        //存放数据的键值
        static let defaultKey: String = "com.yue.WidgetTest.value"
    }
    
    /// 保存数据
    @objc public static func saveData(_ value: String) {
        //保存数据
        userDefault().set(value, forKey: RITL_ShareDataDefaultsConfig.defaultKey)
        userDefault().synchronize()
    }

    
    /// 获取数据
    @objc public static func getData() -> String! {
        //如果值为nil,表示没有存过值，返回默认的值
        let value = (userDefault().value(forKey: RITL_ShareDataDefaultsConfig.defaultKey))
        
        userDefault().synchronize()
        
        if value != nil,let realValue = value as? String  {
            return realValue
        }

        return ""
    }
    
    
    /// 清除数据
    public static func clearData() {
        userDefault().removeSuite(named: RITL_ShareDataDefaultsConfig.groupIdentifier)
        userDefault().synchronize()
    }
    
    // MARK: private
    
    /// 获得userDefualtFile
    private class func userDefault() -> UserDefaults {
        return UserDefaults(suiteName: RITL_ShareDataDefaultsConfig.groupIdentifier)!
    }
    
}
