//
//  MarkViewController.h
//  AutoAPP
//
//  Created by 国栋 on 15/11/27.
//  Copyright (c) 2015年 GD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MarkViewController : UIViewController


@property (weak, nonatomic) IBOutlet UITableView *tableview;
- (IBAction)back:(id)sender;
- (IBAction)save:(id)sender;

@end
