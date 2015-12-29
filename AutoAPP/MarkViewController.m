//
//  MarkViewController.m
//  AutoAPP
//
//  Created by 国栋 on 15/11/27.
//  Copyright (c) 2015年 GD. All rights reserved.
//

#import "MarkViewController.h"
#import "MarkTranslate.h"
@interface MarkViewController ()

@end

@implementation MarkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[[MarkTranslate alloc]init]changeMark];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{}];
}

- (IBAction)save:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{}];
}
@end
