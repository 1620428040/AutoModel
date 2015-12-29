#import "DataTypeManager.h"

@interface DataTypeManager()

@end


@implementation DataTypeManager

-(instancetype)init
{
    if (self=[super init]) {
        //name是UI界面中显示的名称，objectC是OC中定义和使用时用到的名称，coreData为设置coredata存储类型时实际设置的名称
        
        //数字对象全转化成nsnumber，其他的对象可以转化成nsdata
        
        //重新写DataType组，保留name（选择时显示的名字，主要标记），objectC（oc代码中的名字，未经转化的），coreData（coredata模型文件中对应的名字），添加tran（类型转化代码）,reve（反转代码）,enfo（强制转化）,trans(转数据类型的名字)，去掉type（对数据类型的分组)
        
        //time是点击次数，以后可能需要用这个排序
        
        //reve里面的"current."是反转化时，遍历数组用的 和“cur.”转化时用的
        
        [self deleteall];//清空数据
        if ([self getall].count==0) {
            NSLog(@"载入初始化数据");
            [self addAnDataTypeThatUnNeedTransfromWithname:@"NSString" objectC:@"NSString *" coreData:@"String"];
            [self addAnDataTypeThatUnNeedTransfromWithname:@"NSNumber" objectC:@"NSNumber *" coreData:@"Transformable"];
            [self addAnDataTypeThatUnNeedTransfromWithname:@"NSData" objectC:@"NSData *" coreData:@"Binary"];
            [self addAnDataTypeThatUnNeedTransfromWithname:@"NSDate" objectC:@"NSDate *" coreData:@"Date"];
            [self addWithname:@"NSInteger" objectC:@"NSInteger " coreData:@"Transformable" trans:@"NSNumber *" enfo:@"(long)" hold:@"%ld" tran1:@"[NSNumber numberWithInteger:" tran2:@"]" reve1:@"[" reve2:@" integerValue]" time:0];
            [self addWithname:@"UIImage" objectC:@"UIImage *" coreData:@"Binary" trans:@"NSData *" enfo:@"" hold:@"%@" tran1:@"UIImagePNGRepresentation(" tran2:@")" reve1:@"[UIImage imageWithData:" reve2:@"]" time:0];
            [self addWithname:@"BOOL" objectC:@"BOOL " coreData:@"Transformable" trans:@"NSNumber *" enfo:@"(int)" hold:@"%d" tran1:@"[NSNumber numberWithBool:" tran2:@"]" reve1:@"[" reve2:@" boolValue]" time:0];
        }
    }
    return self;
}
-(void)addAnDataTypeThatUnNeedTransfromWithname:(NSString *)name objectC:(NSString *)objectC coreData:(NSString *)coreData
{
    [self addWithname:name objectC:objectC coreData:coreData trans:objectC enfo:@"" hold:@"%@" tran1:@"" tran2:@"" reve1:@"" reve2:@"" time:0];
}
@end

