//数据管理组的基类，实现常用的方法，不要引用，不要更改

#import "DataTypeCDC.h"
#import "DataTypeMDG.h"
#import "DataTypeDG.h"

@interface DataTypeMDGM : DataTypeCDC

@property (strong,nonatomic)NSArray *list;
@property (strong,nonatomic)NSManagedObjectContext *moc;

+(id)share;
-(BOOL)printall;
-(BOOL)addWithname:(NSString *)name objectC:(NSString *)objectC coreData:(NSString *)coreData trans:(NSString *)trans enfo:(NSString *)enfo hold:(NSString *)hold tran1:(NSString *)tran1 tran2:(NSString *)tran2 reve1:(NSString *)reve1 reve2:(NSString *)reve2 time:(NSString *)time ;
-(BOOL)deleteall;
-(BOOL)deleteObject:(DataTypeMDG*)del;
-(BOOL)savechange;//更改数据后一定要与数据库同步
-(NSArray*)getall;
-(NSArray*)findbyPredicate:(NSPredicate*)predicate;//谓词是搜索条件,能理解字符串中的数字之类的,但是似乎不能从数据库中找出相应的字符串
//NSPredicate *predicate=[NSPredicate predicateWithFormat:@"name=%@",name];
-(NSArray*)getAllWithSortDescriptor:(NSArray*)sortDescriptor;//排序条件是多个排序组成的数组
//NSArray *sortDescriptor=[NSArray arrayWithObjects:[[NSSortDescriptor alloc]initWithKey:@"age" ascending:NO], nil];
-(NSArray*)requestWithPredicate:(NSPredicate*)predicate SortDescriptor:(NSArray*)sortDescriptor Error:(NSError*)error;
//自定义请求

-(DataTypeMDG*)findOnlyOneObjectIn:(NSString*)where for:(NSString*)string allowExistOther:(BOOL)other;
//只获取一个对象

-(NSArray*)translateDataTypeInArray:(NSArray*)input;//这个数组可以将输入的数组中所有转化过的数据类型转化回来，但新的数组会失去对coredata中数据的操作能力,其中的对象是DG
@end
