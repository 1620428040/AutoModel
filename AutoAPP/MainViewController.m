//
//  MainViewController.m
//  AutoAPP
//
//  Created by 国栋 on 15/11/27.
//  Copyright (c) 2015年 GD. All rights reserved.
//

#import "MainViewController.h"
#define sw ([UIScreen mainScreen].bounds.size.width)
#define sh ([UIScreen mainScreen].bounds.size.height)

@interface MainViewController ()<UITextViewDelegate>

@property UIView *noti;

@end

@implementation MainViewController
@synthesize noti;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *setFilePath=[[NSBundle mainBundle]pathForResource:@"set" ofType:@"plist"];
    NSDictionary *set=[NSDictionary dictionaryWithContentsOfFile:setFilePath];
    NSString *sourcepath=[set objectForKey:@"sourcepath"];//源码的文件路径
    
    if (![self testFilePath:sourcepath]) {
        noti=[[UIView alloc]initWithFrame:CGRectMake(sw*0.05, sh*0.3, sw*0.9, sh*0.3)];
        noti.backgroundColor=[UIColor grayColor];
        
        UILabel *lab=[[UILabel alloc]initWithFrame:CGRectMake(sw*0.05, 20, sw*0.8, 60)];
        lab.text=@"原目录实效\n请输入源文件所在的目录";
        lab.numberOfLines=0;
        [noti addSubview:lab];
        
        UITextView *textfi=[[UITextView alloc]initWithFrame:CGRectMake(sw*0.05,sh*0.15, sw*0.8, 60)];
        textfi.text=[NSString stringWithFormat:@"%@<==原目录",sourcepath];
        textfi.delegate=self;
        [noti addSubview:textfi];
        
        [self.view addSubview:noti];
    }
}
-(void)textViewDidChange:(UITextView *)textView
{
    if ([self testFilePath:textView.text]) {
        
        //更改配置文件
        NSString *setFilePath=[[NSBundle mainBundle]pathForResource:@"set" ofType:@"plist"];
        NSMutableDictionary *set=[NSMutableDictionary dictionaryWithContentsOfFile:setFilePath];
        [set setValue:textView.text forKey:@"sourcepath"];
        NSString *savePath=[[textView.text componentsSeparatedByString:@"/AutoModel"]firstObject];
        [set setValue:savePath forKey:@"savepath"];
        [set writeToFile:setFilePath atomically:YES];
        
        //更改源码中的配置文件
        setFilePath=[NSString stringWithFormat:@"%@/AutoAPP/set.plist",textView.text];
        [set writeToFile:setFilePath atomically:YES];
        
        [noti removeFromSuperview];
        noti=nil;
    }
}
-(BOOL)testFilePath:(NSString*)path
{
    NSFileManager *fileManager=[NSFileManager defaultManager];
    if (![path containsString:@"AutoModel"]) {
        return NO;
    }
    if (![fileManager fileExistsAtPath:path]) {
        return NO;
    }
    path=[NSString stringWithFormat:@"%@/AutoAPP/Model.xcdatamodeld/Model.xcdatamodel",path];
    if (![fileManager fileExistsAtPath:path]) {
        return NO;
    }
    return YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)dataGroupCreate:(id)sender {
    UIViewController *vc1=[[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"vc1"];
    [self presentViewController:vc1 animated:YES completion:^{}];
}

- (IBAction)markTranslate:(id)sender {
    UIViewController *vc2=[[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"vc2"];
    [self presentViewController:vc2 animated:YES completion:^{}];
}

- (IBAction)set:(id)sender {
    UIViewController *vc3=[[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"vc3"];
    [self presentViewController:vc3 animated:YES completion:^{}];
}
@end
