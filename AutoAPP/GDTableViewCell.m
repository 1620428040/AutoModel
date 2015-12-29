//
//  GDTableViewCell.m
//  AutoAPP
//
//  Created by 国栋 on 15/11/25.
//  Copyright (c) 2015年 GD. All rights reserved.
//

#import "GDTableViewCell.h"
@interface GDTableViewCell()

@property DataTypeManager *datatypemanager;
@property UIScrollView *scroll;
@end

@implementation GDTableViewCell

@synthesize property,type,datatypemanager,scroll;

- (void)awakeFromNib {
    // Initialization code
    datatypemanager=[DataTypeManager share];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)startInputName:(id)sender {
}

- (IBAction)endInputName:(id)sender {
    DataGroupManager *dgm=[DataGroupManager share];
    DataGroupDG *current=[dgm.list objectAtIndex:self.tag-1];
    current.name=property.text;
}

-(IBAction)selecttype:(id)sender
{
    [self openRemindBoard:sender];
}
-(IBAction)endselecttype:(id)sender
{
    [scroll removeFromSuperview];
}
-(void)openRemindBoard:(UIView*)sender
{
    //获取发送消息的对象的边框参数
    int x=sender.frame.origin.x;
    int y=sender.superview.superview.frame.origin.y;
    int width=sender.frame.size.width;
    int height=sender.frame.size.height;
    
    //查找要显示的对象
    NSArray *list;
    if([type.text isEqualToString:@""])
    {
        list=[[DataTypeManager share]getall];
    }
    else
    {
        list=[[DataTypeManager share]findbyPredicate:[NSPredicate predicateWithFormat:@"name contains %@",type.text]];
    }
    //删除和重建ScrollView
    [scroll removeFromSuperview];
    scroll=[[UIScrollView alloc]init];
    scroll.backgroundColor=[UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.5];
    scroll.alwaysBounceVertical=YES;
    scroll.contentSize=CGSizeMake(width,(30+1)*list.count);//内容的大小
    [self.superview addSubview:scroll];
    
    //调整ScrollView的大小和位置，使其不会超出屏幕，这段必须出现在给它设定了父视图之后，否则会出错
    if (y+height+(30+1)*list.count<=[scroll superview].frame.size.height) {
        scroll.frame=CGRectMake(x,y+height,width,(30+1)*list.count);
    }
    else if(y>(30+1)*list.count)
    {
        scroll.frame=CGRectMake(x,y-(30+1)*list.count,width,(30+1)*list.count);
    }
    else if(y<[scroll superview].frame.size.height-y-height)
    {
        scroll.frame=CGRectMake(x,y+height,width,scroll.superview.frame.size.height-y-height);
    }
    else
    {
        scroll.frame=CGRectMake(x,0,width,y);
    }
    
    //在ScrollView上创建按钮
    for (int i=0;i<list.count;i++) {
        DataTypeDG *current=[list objectAtIndex:i];
        UIButton *new=[UIButton new];
        new.frame=CGRectMake(0,(30+1)*i,width-20,30);
        [new setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        new.backgroundColor=[UIColor colorWithRed:0.1 green:0.2 blue:0.2 alpha:0.1];
        [new setTitle:current.name forState:UIControlStateNormal];
        new.titleLabel.text=current.name;
        [new addTarget:self action:@selector(selectedButton:) forControlEvents:UIControlEventTouchDown];
        [scroll addSubview:new];
    }
}
-(void)selectedButton:(UIButton*)sender
{
    [scroll removeFromSuperview];
    type.text=sender.titleLabel.text;
    
    DataGroupManager *dgm=[DataGroupManager share];
    DataGroupDG *current=[dgm.list objectAtIndex:self.tag-1];
    current.type=type.text;
}
@end
