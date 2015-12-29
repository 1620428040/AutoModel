//
//  GDTableViewCell.h
//  AutoAPP
//
//  Created by 国栋 on 15/11/25.
//  Copyright (c) 2015年 GD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataTypeManager.h"
#import "DataGroupManager.h"

@interface GDTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UITextField *property;
@property (weak, nonatomic) IBOutlet UITextField *type;

- (IBAction)startInputName:(id)sender;
- (IBAction)endInputName:(id)sender;


- (IBAction)selecttype:(id)sender;
- (IBAction)endselecttype:(id)sender;

@end
