//被管理对象的类，不要引用，不要更改

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface DataTypeMDG : NSManagedObject

@property (strong,nonatomic)NSString *name;
@property (strong,nonatomic)NSString *objectC;
@property (strong,nonatomic)NSString *coreData;
@property (strong,nonatomic)NSString *trans;
@property (strong,nonatomic)NSString *enfo;
@property (strong,nonatomic)NSString *hold;
@property (strong,nonatomic)NSString *tran1;
@property (strong,nonatomic)NSString *tran2;
@property (strong,nonatomic)NSString *reve1;
@property (strong,nonatomic)NSString *reve2;
@property (strong,nonatomic)NSString *time;

@end
