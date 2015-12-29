#import "DataGroupDGM.h"
@interface DataGroupDGM()


@end

DataGroupDGM *shareDataGroupDGM;

@implementation DataGroupDGM

@synthesize list;

+(id)share
{
    if (shareDataGroupDGM==nil) {
        shareDataGroupDGM=[[self alloc]init];
    }
    return shareDataGroupDGM;
}
-(id)init
{
    if ([super init]) {
        list=[NSMutableArray array];
    }
    return self;
}
-(BOOL)printall
{
    for (DataGroupDG *current in list) {
        NSLog(@"name=%@ type=%@ ",current.name,current.type);
    }
    return YES;
}
-(BOOL)addWithname:(NSString *)name type:(NSString *)type 
{
    DataGroupDG *new=[[DataGroupDG alloc]init];
    new.name=name;
    new.type=type;
    
    [list addObject:new];
    return YES;
}
-(BOOL)deleteall
{
    [list removeAllObjects];
    return YES;
}
-(BOOL)deleteObject:(DataGroupDG *)del
{
    [list removeObject:del];
    return YES;
}
-(NSArray*)getall
{
    return list;
}
-(NSArray *)findbyPredicate:(NSPredicate *)predicate
{
    return [list filteredArrayUsingPredicate:predicate];
}
-(DataGroupDG *)findOnlyOneObjectIn:(NSString *)where for:(NSString *)string allowExistOther:(BOOL)other
{
    NSArray *array=[self findbyPredicate:[NSPredicate predicateWithFormat:@"%K=%@",where,string]];
    if (array.count==0) {
        return nil;
    }
    else if (array.count>1&&other==NO) {
        return nil;
    }
    else
    {
        return [array firstObject];
    }
}
@end
