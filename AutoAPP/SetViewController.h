//
//  SetViewController.h
//  AutoAPP
//
//  Created by 国栋 on 15/11/27.
//  Copyright (c) 2015年 GD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SetViewController : UIViewController
- (IBAction)back:(id)sender;
- (IBAction)save:(id)sender;
@property (weak, nonatomic) IBOutlet UITextView *savepath;
@property (weak, nonatomic) IBOutlet UITextView *source;

@end
