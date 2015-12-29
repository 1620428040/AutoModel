//数据管理组的基类，实现常用的方法，不要引用，不要更改

#import "DataGroupDG.h"

@interface DataGroupDGM : NSObject

@property (strong,nonatomic)NSMutableArray *list;

+(id)share;
-(BOOL)printall;
-(BOOL)addWithname:(NSString *)name type:(NSString *)type ;
-(BOOL)deleteall;
-(BOOL)deleteObject:(DataGroupDG*)del;
-(NSArray*)getall;

-(NSArray*)findbyPredicate:(NSPredicate*)predicate;//谓词是搜索条件,能理解字符串中的数字之类的,但是似乎不能从数据库中找出相应的字符串
//NSPredicate *predicate=[NSPredicate predicateWithFormat:@"name=%@",name];

-(DataGroupDG*)findOnlyOneObjectIn:(NSString*)where for:(NSString*)string allowExistOther:(BOOL)other;
//只获取一个对象
@end
