//
//  FileCreate.m
//  AutoAPP
//
//  Created by 国栋 on 15/11/26.
//  Copyright (c) 2015年 GD. All rights reserved.
//

#import "FileCreate.h"

@interface FileCreate ()

@property NSString *savepath;
@property DataGroupManager *datagroupmanager;
@property DataTypeManager *datatypemanager;
@property MarkTranslate *markTranslate;

@end

FileCreate *filecreate;

@implementation FileCreate

@synthesize savepath,datagroupmanager,datatypemanager,markTranslate;

+(id)share
{
    if (filecreate==nil) {
        filecreate=[[FileCreate alloc]init];
        
    }
    return filecreate;
}

-(id)init
{
    if ([super init]!=nil) {
        savepath=[NSString stringWithFormat:@"%@/AutoCode",[[NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"set" ofType:@"plist"]]objectForKey:@"savepath"]];
        datagroupmanager=[DataGroupManager share];
        datatypemanager=[DataTypeManager share];
        markTranslate=[[MarkTranslate alloc]init];
    }
    return self;
}
-(void)createfile
{
    if(![self cheakinfo])
    {
        return;
    }
    if (![[NSFileManager defaultManager]fileExistsAtPath:savepath]) {
        [[NSFileManager defaultManager]createDirectoryAtPath:savepath withIntermediateDirectories:NO attributes:nil error:nil];
    }
    if(datagroupmanager.coredata==NO)
    {
        [markTranslate create:@"Manager.h" useModelFile:@"UnStoreManager"];
        [markTranslate create:@"Manager.m" useModelFile:@"UnStoreManager"];
    }
    else
    {
        [markTranslate create:@"Manager.h" useModelFile:@"CoreDataManager"];
        [markTranslate create:@"Manager.m" useModelFile:@"CoreDataManager"];
        [markTranslate updateModel];
    }
}

-(BOOL)cheakinfo
{
    if ([datagroupmanager.name isEqual:@""]) {
        NSLog(@"失败，数据组名为空！");
        return NO;
    }
    for (int i=0; i<datagroupmanager.list.count; i++) {
        DataGroupDG *dgi=[datagroupmanager.list objectAtIndex:i];
        if ([dgi.name isEqualToString:@""]) {
            NSLog(@"失败，有空的属性名！");
            return NO;
        }
        if ([dgi.name containsString:@" "]) {
            NSLog(@"失败，属性名中不能包含空格！");
            return NO;
        }
        if ([datatypemanager findOnlyOneObjectIn:@"name" for:dgi.type allowExistOther:YES]==nil)
        {
            NSLog(@"失败，无法识别的类型！");
            return NO;
        }
        for (int j=0; j<i; j++) {
            DataGroupDG *dgj=[datagroupmanager.list objectAtIndex:j];
            if ([dgi.name isEqualToString:dgj.name]) {
                NSLog(@"失败，有重复的属性名！");
                return NO;
            }
        }
    }
    return YES;
}

-(void)printinfo
{
    NSLog(@"datagroupname:%@",datagroupmanager.name);
    NSLog(@"didusecoredata:%d",datagroupmanager.coredata);
    for (int i=0; i<datagroupmanager.list.count; i++) {
        DataGroupDG *datagroup=[datagroupmanager.list objectAtIndex:i];
        NSLog(@"dataname:%@,type:%@",datagroup.name,datagroup.type);
    }
}
@end
