#import "DataTypeMDGM.h"

@interface DataTypeMDGM ()


@end

DataTypeMDGM *shareDataTypeMDGM;

@implementation DataTypeMDGM

@synthesize list,moc;

+(id)share
{
    if (shareDataTypeMDGM==nil) {
        shareDataTypeMDGM=[[self alloc]init];
    }
    return shareDataTypeMDGM;
}
-(id)init
{
    if ([super init]) {
        moc=[self managedObjectContext];
        list=[self getall];
    }
    return self;
}
-(BOOL)addWithname:(NSString *)name objectC:(NSString *)objectC coreData:(NSString *)coreData trans:(NSString *)trans enfo:(NSString *)enfo hold:(NSString *)hold tran1:(NSString *)tran1 tran2:(NSString *)tran2 reve1:(NSString *)reve1 reve2:(NSString *)reve2 time:(NSString *)time 
{
    DataTypeMDG *new=[NSEntityDescription insertNewObjectForEntityForName:@"DataType" inManagedObjectContext:moc];
    new.name=name;
    new.objectC=objectC;
    new.coreData=coreData;
    new.trans=trans;
    new.enfo=enfo;
    new.hold=hold;
    new.tran1=tran1;
    new.tran2=tran2;
    new.reve1=reve1;
    new.reve2=reve2;
    new.time=time;
    
    [moc save:nil];
    return YES;
}
-(BOOL)printall
{
    [self getall];
    for (DataTypeMDG *current in list) {
        NSLog(@"name=%@ objectC=%@ coreData=%@ trans=%@ enfo=%@ hold=%@ tran1=%@ tran2=%@ reve1=%@ reve2=%@ time=%@ ",current.name,current.objectC,current.coreData,current.trans,current.enfo,current.hold,current.tran1,current.tran2,current.reve1,current.reve2,current.time);
    }
    return YES;
}
-(BOOL)deleteall
{
    for (DataTypeMDG *current in list) {
        [moc deleteObject:current];
    }
    return YES;
}
-(BOOL)deleteObject:(DataTypeMDG*)del
{
    [moc deleteObject:del];
    return YES;
}
-(NSArray*)getall
{
    NSFetchRequest *request=[self fetchRequest];
    list=[moc executeFetchRequest:request error:nil];
    return list;
}
-(NSFetchRequest*)fetchRequest
{
    NSFetchRequest *request=[[NSFetchRequest alloc]init];
    NSEntityDescription *entityDescription=[NSEntityDescription entityForName:@"DataType" inManagedObjectContext:moc];
    [request setEntity:entityDescription];
    return request;
}
-(BOOL)savechange
{
    [moc save:nil];
    return YES;
}
-(NSArray*)findbyPredicate:(NSPredicate*)predicate
{
    NSFetchRequest *request=[self fetchRequest];
    [request setPredicate:predicate];
    list=[moc executeFetchRequest:request error:nil];
    return list;
}
-(NSArray *)getAllWithSortDescriptor:(NSArray *)sortDescriptor
{
    NSFetchRequest *request=[self fetchRequest];
    [request setSortDescriptors:sortDescriptor];
    list=[moc executeFetchRequest:request error:nil];
    return list;
}
-(NSArray*)requestWithPredicate:(NSPredicate*)predicate SortDescriptor:(NSArray*)sortDescriptor Error:(NSError *)error
{
    NSFetchRequest *request=[self fetchRequest];
    [request setPredicate:predicate];
    [request setSortDescriptors:sortDescriptor];
    list=[moc executeFetchRequest:request error:&error];
    return list;
}
-(DataTypeMDG*)findOnlyOneObjectIn:(NSString*)where for:(NSString*)string allowExistOther:(BOOL)other
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
-(NSArray*)translateDataTypeInArray:(NSArray*)input
{
    NSMutableArray *output=[NSMutableArray array];
    for (DataTypeMDG *current in input) {
        DataTypeDG *new=[[DataTypeDG alloc]init];
        new.name=current.name;
        new.objectC=current.objectC;
        new.coreData=current.coreData;
        new.trans=current.trans;
        new.enfo=current.enfo;
        new.hold=current.hold;
        new.tran1=current.tran1;
        new.tran2=current.tran2;
        new.reve1=current.reve1;
        new.reve2=current.reve2;
        new.time=current.time;
        
        [output addObject:new];
    }
    return output;
}
@end
