//
//  SetViewController.m
//  AutoAPP
//
//  Created by 国栋 on 15/11/27.
//  Copyright (c) 2015年 GD. All rights reserved.
//

#import "SetViewController.h"

@interface SetViewController ()
@property (strong,nonatomic)NSBundle *bundle;
@property (strong,nonatomic)NSString *setfilepath;
@property (strong,nonatomic)NSDictionary *set;
@end

@implementation SetViewController
@synthesize bundle;
@synthesize setfilepath;
@synthesize set;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    bundle=[NSBundle mainBundle];
    setfilepath=[bundle pathForResource:@"set" ofType:@"plist"];
    set=[NSDictionary dictionaryWithContentsOfFile:setfilepath];
    
    self.savepath.text=[set objectForKey:@"savepath"];
    self.source.text=[set objectForKey:@"sourcepath"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{}];
}

- (IBAction)save:(id)sender {
    NSArray *name=@[@"savepath",@"sourcepath"];
    NSArray *path=@[self.savepath.text,self.source.text];
    set=[NSDictionary dictionaryWithObjects:path forKeys:name];
    [set writeToFile:setfilepath atomically:YES];
    [self dismissViewControllerAnimated:YES completion:^{}];
}
@end
