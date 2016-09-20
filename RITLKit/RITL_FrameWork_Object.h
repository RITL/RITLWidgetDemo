//
//  RITL_FrameWork_Object.h
//  WidgetTest
//
//  Created by YueWen on 16/9/18.
//  Copyright © 2016年 YueWen. All rights reserved.
//

#import <Foundation/Foundation.h>

/// ObjC 进行共享的代码
@interface RITL_FrameWork_Object : NSObject

@property (nonatomic, copy) NSString * name;

+ (void)sayHello;

@end
