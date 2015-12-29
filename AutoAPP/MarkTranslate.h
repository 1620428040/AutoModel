//
//  MarkTranslate.h
//  MarkTranslate
//
//  Created by 国栋 on 15/11/28.
//  Copyright (c) 2015年 GD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataGroupManager.h"
#import "DataTypeManager.h"

@interface MarkTranslate : NSObject
-(void)create:(NSString*)model;
-(NSString*)changeMark;
-(void)updateModel;
-(void)create:(NSString*)model useModelFile:(NSString*)filename;
@end
