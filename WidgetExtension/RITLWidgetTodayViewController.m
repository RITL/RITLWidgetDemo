//
//  TodayViewController.m
//  WidgetExtension
//
//  Created by YueWen on 16/9/18.
//  Copyright © 2016年 YueWen. All rights reserved.
//

#import "RITLWidgetTodayViewController.h"
#import <NotificationCenter/NotificationCenter.h>
#import "RITL_FrameWork_Object.h"

//导入Swift共享代码
@import RITLKit;

@interface RITLWidgetTodayViewController () <NCWidgetProviding>

/// 用于显示的标签
@property (weak, nonatomic) IBOutlet UILabel *textLabel;

@end

@implementation RITLWidgetTodayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //共享代码的测试
    [RITL_FrameWork_Object sayHello];
    [RITL_Framework_Swift_Object sayHello];

    //如果不是storyboard,记得设置VC大小
//    self.preferredContentSize = CGSizeMake(0, 200);
    
    //reload data
    [self uploadData];
    
    
    
#ifdef __IPHONE_10_0
    //如果需要折叠
    self.extensionContext.widgetLargestAvailableDisplayMode = NCWidgetDisplayModeExpanded;
#endif
    
}


/// 更新数据
- (void)uploadData
{
    
#ifdef RITL_ShareDataType_UserDefaults
    //获得数据--方法1
    self.textLabel.text = [RITL_ShareDataDefaultsManager getData];
#else
    //获得数据--方法2
    self.textLabel.text = [RITL_ShareDataFileManager getData];
#endif
}


-(void)dealloc
{
    NSLog(@"TodayControlle Dealloc");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




#pragma mark - <NCWidgetProviding>

- (void)widgetPerformUpdateWithCompletionHandler:(void (^)(NCUpdateResult))completionHandler {
    // Perform any setup necessary in order to update the view.
    
    // If an error is encountered, use NCUpdateResultFailed
    // If there's no update required, use NCUpdateResultNoData
    // If there's an update, use NCUpdateResultNewData
    //获得数据
    NSString * newValue = [RITL_ShareDataDefaultsManager getData];
    
    if ([newValue isEqualToString:self.textLabel.text])//表明没有更新
    {
        completionHandler(NCUpdateResultNoData);
    }
    
    else//需要刷新
    {
        completionHandler(NCUpdateResultNewData);
    }
}

#ifdef __IPHONE_10_0

// available NS_AVAILABLE_IOS(10_0)
- (void)widgetActiveDisplayModeDidChange:(NCWidgetDisplayMode)activeDisplayMode withMaximumSize:(CGSize)maxSize
{
    switch (activeDisplayMode)
    {
        //如果是正常折叠的高度
        case NCWidgetDisplayModeCompact:
        {
            //设置当前的高度
            self.preferredContentSize = CGSizeMake(0, 200);//宽度会自动变为屏幕的宽度，这里就索性给0了
        }
        break;
            
        //如果是展开的高度
        case NCWidgetDisplayModeExpanded:
        {
            self.preferredContentSize = CGSizeMake(0, 800);
        }
        break;
    }
}

#else

// 表示当前widget的内嵌边距，如果不设置，那么返回的就是默认的defaultMarginInsets，不过在iOS10以及以后就不会再调用该方法了
// Widgets wishing to customize the default margin insets can return their preferred values.
// Widgets that choose not to implement this method will receive the default margin insets.
// This method will not be called on widgets linked against iOS versions 10.0 and later.
- (UIEdgeInsets)widgetMarginInsetsForProposedMarginInsets:(UIEdgeInsets)defaultMarginInsets
{
    return UIEdgeInsetsMake(0, 20, 0, 0);//随便写一下
}

#endif




#pragma mark - custom action


- (IBAction)fristButtonDidTap:(id)sender
{
    [self openMyApplication:@"First"];
}

- (IBAction)secondButtonDidTap:(id)sender
{
    [self openMyApplication:@"Second"];
}

- (IBAction)thirdButtonDidTap:(id)sender
{
    [self openMyApplication:@"Three"];
}

- (IBAction)fourButtonDidTap:(id)sender
{
    [self openMyApplication:@"Four"];
}


- (void)openMyApplication:(NSString *)title
{
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"WidgetDemoOpenViewController://%@",title]];
    
   [self.extensionContext openURL:url completionHandler:^(BOOL success) {}];
}




@end
