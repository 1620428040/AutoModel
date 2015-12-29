//
//  MarkTranslate.m
//  MarkTranslate
//
//  Created by 国栋 on 15/11/28.
//  Copyright (c) 2015年 GD. All rights reserved.
//

#import "MarkTranslate.h"
@interface MarkTranslate()
@property DataGroupManager *datagroupmanager;
@property DataTypeManager *datatypemanager;

@end

@implementation MarkTranslate
@synthesize datagroupmanager,datatypemanager;

-(void)create:(NSString *)model useModelFile:(NSString *)filename
{
    NSString *modelPath=[[NSBundle mainBundle]pathForResource:filename ofType:@""];
    NSString *content=[NSString stringWithContentsOfFile:modelPath encoding:NSUTF8StringEncoding error:nil];
    
    content=[self createContent:content model:model];
    content=[self copyForList:content model:model];
    
    NSString *savepath=[[NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"set" ofType:@"plist"]]objectForKey:@"savepath"];
    NSString *filepath=[NSString stringWithFormat:@"%@/AutoCode/%@%@",savepath,datagroupmanager.name,model];
    [content writeToFile:filepath atomically:YES encoding:NSUTF8StringEncoding error:nil];
}
-(NSString*)changeMark
{
    NSString *savepath=[[NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"set" ofType:@"plist"]]objectForKey:@"savepath"];
    NSString *filespath=[NSString stringWithFormat:@"%@/AutoModel/ChangeMark",savepath];
    if (![[NSFileManager defaultManager]fileExistsAtPath:filespath])
    {
        NSLog(@"路径错误，找不到AutoModel/ChangeMark文件夹");
        return nil;
    }
    NSArray *files=[[NSFileManager defaultManager]contentsOfDirectoryAtPath:filespath error:nil];
    for (NSString *file in files) {
        [self changeMarkInFile:[NSString stringWithFormat:@"%@/%@",filespath,file]];
    }
    return nil;
}

-(void)changeMarkInFile:(NSString*)filepath//翻译以前的标签用的，以后可以和标签翻译器链接起来
{
    NSString *content=[NSString stringWithContentsOfFile:filepath encoding:NSUTF8StringEncoding error:nil];
    content=[self translateMark:@"<<<" by:@"/*<" in:content];
    content=[self translateMark:@">>>" by:@">*/" in:content];
    content=[self translateMark:@"/*/name/*/" by:@"/*/name/*/Mark" in:content];
    content=[self translateMark:@"*/*ATTname*/*" by:@"/*/ATTname/*/Mark" in:content];
    content=[self translateMark:@"*/*ATTtype*/*" by:@"/*/ATTtype/*/NSString *" in:content];
    [content writeToFile:filepath atomically:YES encoding:NSUTF8StringEncoding error:nil];
}

-(NSString*)translateMark:(NSString*)mark by:(NSString*)str in:(NSString*)content
{
    NSArray *array=[content componentsSeparatedByString:mark];
    content=[array firstObject];
    for (int i=1; i<array.count; i++) {
        content=[NSString stringWithFormat:@"%@%@%@",content,str,[array objectAtIndex:i]];
    }
    return content;
}
-(void)create:(NSString*)model
{
    NSString *modelPath=[[NSBundle mainBundle]pathForResource:@"CodeModel" ofType:@""];
    NSString *content=[NSString stringWithContentsOfFile:modelPath encoding:NSUTF8StringEncoding error:nil];
    
    content=[self createContent:content model:model];
    content=[self copyForList:content model:model];
    
    NSString *savepath=[[NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"set" ofType:@"plist"]]objectForKey:@"savepath"];
    NSString *filepath=[NSString stringWithFormat:@"%@/AutoCode/%@%@",savepath,datagroupmanager.name,model];
    [content writeToFile:filepath atomically:YES encoding:NSUTF8StringEncoding error:nil];
}
-(NSString*)createContent:(NSString*)content model:(NSString*)model
{
    content=[[content componentsSeparatedByString:[NSString stringWithFormat:@"/*<%@>*/\n",model]]objectAtIndex:1];//注意，截取模型时，需要截掉开头的换行符，否则coredata会出错
    
    datagroupmanager=[DataGroupManager share];
    datatypemanager=[DataTypeManager share];
    
    content=[self translateMark:@"/*/name/*/Mark" by:datagroupmanager.name in:content];
    //此处可以添加要替换的其它标签
    
    //获取对应的管理器的类名
    NSString *manager;
    if (datagroupmanager.coredata==YES) {
        manager=[NSString stringWithFormat:@"%@M",datagroupmanager.name];
    }
    else
    {
        manager=[NSString stringWithFormat:@"%@",datagroupmanager.name];
    }
    content=[self translateMark:@"/*/manager/*/Mark" by:manager in:content];//翻译对应的标签
    return content;
}
-(NSString*)copyForList:(NSString*)content model:(NSString*)model
{
    NSArray *array=[content componentsSeparatedByString:@"/*<LIST>*/"];
    content=[array firstObject];
    for (int i=1; i<array.count; i++) {
        NSString *current=[array objectAtIndex:i];
        //NSLog(@"循环检测");
        if ([current containsString:@"/*/ATT"]) {
            //NSLog(@"匹配%d",(int)datagroupmanger.attributeList.count);
            for (int j=0; j<datagroupmanager.list.count; j++) {
                NSString *copy=[current copy];
                DataGroupDG *currentAtt=[datagroupmanager.list objectAtIndex:j];
                copy=[self transAttIn:copy model:model currentAtt:currentAtt];
                content=[NSString stringWithFormat:@"%@%@",content,copy];
            }
        }
        else
        {
            content=[NSString stringWithFormat:@"%@%@",content,current];
        }
    }
    return content;
}
-(NSString*)transAttIn:(NSString*)copy model:(NSString*)model currentAtt:(DataGroupDG*)currentAtt
{
    //转换"/*/ATTname/*/Mark"标签
    copy=[self translateMark:@"/*/ATTname/*/Mark" by:currentAtt.name in:copy];
    
    //转换"/*/ATTtype/*/NSString *"标签
    NSString *type;//类型（coredata和objectc中的类型相互转换）
    if ([model isEqualToString:@"contents"]) {
        type=[datatypemanager findOnlyOneObjectIn:@"name" for:currentAtt.type allowExistOther:YES].coreData;
    }
    //else if此处添加对其他类型的模型中的数据类型的转换
    else
    {
        type=[datatypemanager findOnlyOneObjectIn:@"name" for:currentAtt.type allowExistOther:YES].objectC;
    }
    copy=[self translateMark:@"/*/ATTtype/*/NSString *" by:type in:copy];
    
    //转换"/*/ATTtrans/*/NSString *"标签
    //转换"/*/ATTenfo/*/"标签
    //转换"/*/ATThold/*/%@"标签
    //转换"/*/ATTtran1/*/"标签
    //转换"/*/ATTtran2/*/"标签
    //转换"/*/ATTreve1/*/"标签
    //转换"/*/ATTreve2/*/"标签
    DataTypeMDG *dt=[datatypemanager findOnlyOneObjectIn:@"name" for:currentAtt.type allowExistOther:YES];
    copy=[self translateMark:@"/*/ATTtrans/*/NSString *" by:dt.trans in:copy];
    copy=[self translateMark:@"/*/ATTenfo/*/" by:dt.enfo in:copy];
    copy=[self translateMark:@"/*/ATThold/*/%@" by:dt.hold in:copy];
    copy=[self translateMark:@"/*/ATTtran1/*/" by:dt.tran1 in:copy];
    copy=[self translateMark:@"/*/ATTtran2/*/" by:dt.tran2 in:copy];
    copy=[self translateMark:@"/*/ATTreve1/*/" by:dt.reve1 in:copy];
    copy=[self translateMark:@"/*/ATTreve2/*/" by:dt.reve2 in:copy];
    
    //转换"strong"标签
    if ((![dt.name isEqualToString:@"NSNumber"])&&[dt.trans isEqualToString:@"NSNumber *"]) {
        copy=[self translateMark:@"strong" by:@"assign" in:copy];
    }
    //此处可以添加其他需要转化的标签
    return copy;
}
-(void)updateModel
{
    NSString *modelPath=[[NSBundle mainBundle]pathForResource:@"CodeModel" ofType:@""];
    NSString *content=[NSString stringWithContentsOfFile:modelPath encoding:NSUTF8StringEncoding error:nil];
    
    content=[self createContent:content model:@"contents"];
    content=[self copyForList:content model:@"contents"];
    
    if (content==nil) {
        return;
    }
    
    NSString *savepath=[[NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"set" ofType:@"plist"]]objectForKey:@"savepath"];
    NSString *modelpath=[NSString stringWithFormat:@"%@/AutoCode/%@Model.xcdatamodeld",savepath,datagroupmanager.name];
    
    if ([[NSFileManager defaultManager]fileExistsAtPath:modelpath]) {
        [[NSFileManager defaultManager]removeItemAtPath:modelpath error:nil];
    }
    
    NSString *sourcepath=[[NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"set" ofType:@"plist"]]objectForKey:@"sourcepath"];
    
    NSString *path=[NSString stringWithFormat:@"%@/AutoAPP/Model.xcdatamodeld",sourcepath];
    if (![[NSFileManager defaultManager]fileExistsAtPath:path]) {
        NSLog(@"警告，或许是文件路径变化，找不到Model.xcdatamodeld，请修改set.plist中的源文件路径");
    }
    [[NSFileManager defaultManager]copyItemAtPath:path toPath:modelpath error:nil];
    modelpath=[NSString stringWithFormat:@"%@/Model.xcdatamodel/contents",modelpath];
    [content writeToFile:modelpath atomically:YES encoding:NSUTF8StringEncoding error:nil];
}
@end
