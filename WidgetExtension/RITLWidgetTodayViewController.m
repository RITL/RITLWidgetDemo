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

@interface RITLWidgetTodayViewController () <NCWidgetProviding>

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;



@end

@implementation TodayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [RITL_FrameWork_Object sayHello];
    
}



-(void)viewWillAppear:(BOOL)animated
{
    //获得userDefault
    NSUserDefaults * userDefault = [[NSUserDefaults alloc]initWithSuiteName:@"group.com.yue.WidgetTest"];
    
    //获得当前的数字
    NSUInteger number = [userDefault integerForKey:@"com.yue.WidgetTest.currentTime"];
    
    //显示
    self.timeLabel.text = [NSString stringWithFormat:@"%ld",(long)number];
}

-(void)dealloc
{
    NSLog(@"TodayControlle Dealloc");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)widgetPerformUpdateWithCompletionHandler:(void (^)(NCUpdateResult))completionHandler {
    // Perform any setup necessary in order to update the view.
    
    // If an error is encountered, use NCUpdateResultFailed
    // If there's no update required, use NCUpdateResultNoData
    // If there's an update, use NCUpdateResultNewData

    completionHandler(NCUpdateResultNewData);
}

- (IBAction)fristButtonDidTap:(id)sender
{
    NSLog(@"first");
    [self openMyApplication:@"First"];
}

- (IBAction)secondButtonDidTap:(id)sender
{
    NSLog(@"second");
    [self openMyApplication:@"Second"];
}

- (IBAction)thirdButtonDidTap:(id)sender
{
    NSLog(@"third");
    [self openMyApplication:@"Three"];
}

- (IBAction)fourButtonDidTap:(id)sender
{
    NSLog(@"four");
    [self openMyApplication:@"Four"];
}


- (void)openMyApplication:(NSString *)title
{
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"WidgetDemoOpenViewController://%@",title]];
    
   [self.extensionContext openURL:url completionHandler:^(BOOL success) {}];
}




@end
