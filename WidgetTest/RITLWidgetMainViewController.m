//
//  ViewController.m
//  WidgetTest
//
//  Created by YueWen on 16/9/18.
//  Copyright © 2016年 YueWen. All rights reserved.
//

#import "RITLWidgetMainViewController.h"
#import "WidgetTest-Swift.h"
#import "RITL_FrameWork_Object.h"



@interface RITLWidgetMainViewController ()

@property (nonatomic, strong) NSTimer * timer;
@property (nonatomic, assign) NSInteger number;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    __weak typeof(self) weakSelf = self;

    //获得失去前台的监听
    [[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationWillResignActiveNotification object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
        
        if (weakSelf.timer == nil)
        {
            [weakSelf __clearDefaults];//删除默认
        }
        
        
        else
        {
            
        }
        
        
    }];
    
    
    
    [[NSNotificationCenter defaultCenter] addObserverForName:@"ExtenicationNotification" object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
       
        //获得类型
        NSString * type = note.object;
        
        [weakSelf presentTextController:type];
        
    }];

    
    // iOS 10 之后的block方法
    self.timer = [NSTimer timerWithTimeInterval:1.0 repeats:true block:^(NSTimer * _Nonnull timer) {
       
        //number++
        weakSelf.number ++;
        weakSelf.timeLabel.text = [NSString stringWithFormat:@"%ld",(long)weakSelf.number];
        
        
    }];
}



//private function
- (void)__applicationWillResignActive
{
    if (_timer == nil)
    {
        [self __clearDefaults];//删除默认
    }
    
    
    else
    {
        if (!_timer.valid)
        {
            [self __saveDefaults];
        }
        
        else
        {
            [self __clearDefaults];
        }
    }
}


- (void)__saveDefaults
{
    //创建UserDefault
    NSUserDefaults * userDefault = [[NSUserDefaults alloc]initWithSuiteName:@"group.com.yue.WidgetTest"];
    
    
    [userDefault setInteger:1 forKey:@"com.yue.WidgetTest.defaultTime"];
    [userDefault setInteger:self.number forKey:@"com.yue.WidgetTest.currentTime"];
    
    //加锁
    [userDefault synchronize];
}


- (void)__clearDefaults
{
    //获得userDefault
    NSUserDefaults * userDefault = [[NSUserDefaults alloc] initWithSuiteName:@"group.com.yue.WidgetTest"];
    
    //移除数据
    [userDefault removeObjectForKey:@"com.yue.WidgetTest.defaultTime"];
    [userDefault removeObjectForKey:@"com.yue.WidgetTest.currentTime"];
    
    [userDefault synchronize];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}


#pragma mark - Button Action


- (IBAction)firstButtonDidTap:(id)sender
{
    NSLog(@"first");
    [self presentTextController:@"First"];
}


- (IBAction)secondButtonDidTap:(id)sender
{
    NSLog(@"second");
    [self presentTextController:@"Second"];
}


- (IBAction)thirdButtonDidTap:(id)sender
{
    NSLog(@"third");
    [self presentTextController:@"Third"];
}

- (IBAction)fourButtonDidTap:(id)sender
{
    NSLog(@"forth");
    [self presentTextController:@"Four"];
}


- (void)presentTextController:(NSString *)title
{
    [RITL_FrameWork_Object sayHello];

    TextViewController * viewController = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"TextViewController"];
    
    viewController.headTitle = title;
    [self presentViewController:viewController animated:true completion:^{}];
}



- (IBAction)startButtonDidTap:(id)sender
{
    //开启计时器
    if (_timer.isValid)
    {
        [_timer fire];
    }
}


- (IBAction)stopButtonDidTap:(id)sender
{
    [_timer invalidate];
}

@end
