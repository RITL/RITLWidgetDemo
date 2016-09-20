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

//导入Swift共享代码
@import RITLKit;


@interface RITLWidgetMainViewController ()

/// 负责获取用户信息的文本域
@property (weak, nonatomic) IBOutlet UITextField *mainTextField;

@end


@implementation RITLWidgetMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    __weak typeof(self) weakSelf = self;

    //获得失去前台的监听
    [[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationWillResignActiveNotification object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {//进行数据的保存
        
        //保存当前的数据
#ifdef RITL_ShareDataType_UserDefaults
        //第一种保存数据
        [RITL_ShareDataDefaultsManager saveData:weakSelf.mainTextField.text];
        
#else
        //第二种保存数据
        [RITL_ShareDataFileManager saveData:weakSelf.mainTextField.text];
#endif
        
    }];
    
    
    
    //添加获得拓展打开基础应用的通知
    [[NSNotificationCenter defaultCenter] addObserverForName:@"ExtenicationNotification" object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
       
        //获得类型
        NSString * type = note.object;
        
        [weakSelf presentTextController:type];
        
    }];
    
    
    //add tapGestureRecognizer
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(__tapGestureRecognizerAction)]];
    
}


- (void)__tapGestureRecognizerAction
{
    [self.mainTextField resignFirstResponder];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}


#pragma mark - present Button Action


- (IBAction)firstButtonDidTap:(id)sender
{
    [self presentTextController:@"First"];
}


- (IBAction)secondButtonDidTap:(id)sender
{
    [self presentTextController:@"Second"];
}


- (IBAction)thirdButtonDidTap:(id)sender
{
    [self presentTextController:@"Third"];
}

- (IBAction)fourButtonDidTap:(id)sender
{
    [self presentTextController:@"Four"];
}


- (void)presentTextController:(NSString *)title
{
    
    //shared coding ..
    [RITL_FrameWork_Object sayHello];
    [RITL_Framework_Swift_Object sayHello];
    
    TextViewController * viewController = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"TextViewController"];
    
    viewController.headTitle = title;
    [self presentViewController:viewController animated:true completion:^{}];
}


#pragma mark - clear data Action

- (IBAction)clearButtonDidTap:(id)sender
{
#ifdef RITL_ShareDataType_UserDefaults
    //第一种
    [RITL_ShareDataDefaultsManager clearData];
#else
    //第二种
    [RITL_ShareDataFileManager clearData];
#endif
}




@end
