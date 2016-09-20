//
//  AppDelegate.m
//  WidgetTest
//
//  Created by YueWen on 16/9/18.
//  Copyright © 2016年 YueWen. All rights reserved.
//

#import "RITLWidgetAppDelegate.h"

@interface RITLWidgetAppDelegate ()

@end

@implementation RITLWidgetAppDelegate

-(BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options
{
    if ([url.scheme isEqualToString:@"WidgetDemoOpenViewController"])
    {
        NSLog(@"host = %@",url.host);
        
        //发送通知
        [[NSNotificationCenter defaultCenter] postNotificationName:@"ExtenicationNotification" object:url.host];
    }
    return false;
}



@end
