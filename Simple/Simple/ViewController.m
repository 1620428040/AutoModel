//
//  ViewController.m
//  Simple
//
//  Created by 国栋 on 15/12/29.
//  Copyright (c) 2015年 GD. All rights reserved.
//


//示例，使用CoreData存储数据时的用法
#import "ViewController.h"
#import "PersonManager.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    PersonManager *personmanager=[PersonManager share];
    [personmanager addWithname:@"张三" age:25];
    
    Person *lisi=[Person new];
    lisi.name=@"李四";
    lisi.age=19;
    [personmanager addObject:lisi];
    
    [personmanager printall];
    
    NSLog(@"==========分界线===========");
    
    [personmanager deleteObject:lisi];
    [personmanager printall];
    
    NSLog(@"==========分界线===========");
    
    [personmanager addWithname:@"王五" age:42];
    NSMutableArray *array=[personmanager getall];
    NSLog(@"%@",array);
    
    NSLog(@"==========分界线===========");
    
    [personmanager addArray:[personmanager getall]];//直接复制自身的数据，这样也不会死循环
    [personmanager printall];
    
    NSArray *array2=[personmanager findbyPredicate:[NSPredicate predicateWithFormat:@"name=%@",@"张三"]];
    for (Person *person in array2) {
        NSLog(@"%@",person.name);
    }
    [personmanager deleteArray:array2];
    [personmanager printall];
    
    NSLog(@"==========分界线===========");
    
    Person *thePerson=[personmanager.list firstObject];
    thePerson.name=@"王二麻子";
    [personmanager changeObject:thePerson];//修改之后需要保存一下
    [personmanager printall];
    
    NSLog(@"%@",[personmanager findObjectIn:@"name" for:@"王二麻子"]);//比较直接的搜索，但是不支持数字
    NSLog(@"%@",[personmanager findObjectIn:@"age" for:@"42"]);
    
    NSLog(@"==========分界线===========");
    
    [personmanager deleteall];//全部删除
    [personmanager printall];//删干净了
    
    
    NSLog(@"==========格式的转化===========");
    
    [personmanager addWithname:@"张三" age:12];
    [personmanager addWithname:@"李四" age:54];
    [personmanager addWithname:@"王五" age:17];
    [personmanager addWithname:@"赵六" age:38];
    [personmanager printall];
    NSData *data=[NSKeyedArchiver archivedDataWithRootObject:personmanager.list];//归档
    //NSLog(@"%@",data);
    [personmanager addArray:[NSKeyedUnarchiver unarchiveObjectWithData:data]];//解档，然后保存
    [personmanager printall];
    
    NSLog(@"==========分界线===========");
    
    NSDictionary *dict=[personmanager dictionaryWithObject:[personmanager.list firstObject]];//将一个对象转化为字典
    NSLog(@"%@",dict);
    
    array2=[personmanager dictionaryArrayWithArray:[personmanager getall]];//转化一个数组
    array2=[personmanager dictionaryArrayWithAllObject];//转化全部
    
    data=[NSJSONSerialization dataWithJSONObject:array2 options:NSJSONWritingPrettyPrinted error:nil];//转化成JSON数据
    NSLog(@"%@",[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding]);
    
    
    NSArray *array3=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];//接收数据
    [personmanager saveDictionaryArray:array3];//保存
    [personmanager printall];
    
    
    
    NSLog(@"==========类型检查===========");
    [personmanager addArray:array3];//内部会检测类型，所以有些不正确的操作会被跳过
    
    
    
    NSLog(@"==========示例结束===========");
    
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
