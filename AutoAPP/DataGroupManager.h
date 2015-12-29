#import "DataGroupDGM.h"

@interface DataGroupManager : DataGroupDGM

@property (strong,nonatomic)NSString *name;
@property (assign,nonatomic)BOOL coredata;
@property (assign,nonatomic)NSInteger net;

@end

//调用时需要引用的头文件，可以在这里定义新的属性和方法，不要更改其他文件！
//重新生成数据组时，可以保留这个文件而不用拖新的过来！以保留原来自定义的属性和方法
//引用父类的属性，例如：NSMutableArray *list，用[self List];
