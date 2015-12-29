//初始化一些CoreData有关的管理器，不要引用，不要更改

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface DataTypeCDC : NSObject

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;//与数据库同步
- (NSURL *)applicationDocumentsDirectory;//获取路径

@end
