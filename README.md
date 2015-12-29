介绍：
这个程序是用来自动生成 用来储存数据的类和管理这些数据 的源码的,
例如：
选择 新建数据组
只需要输入类名Student 和类中的属性 name , age , score 等，就能自动创建Student类，和用来管理的StudentManager类

选择使用CoreData，生成的代码可以自动将数据存储在CoreData管理的数据库中，如果选择不用，则不会生成有存储数据的代码
字段数这个选项，可以选择类中属性的数量，后面的按钮是方便快速选择的
网络通信格式选项没有用，生成的代码中都有将数据对象转化为NSData和字典格式的方法
下面的表视图中添加属性 和 属性的数据类型

如果源文件的位置被移动了，再次启动时会要求输入存储路径，即 /.../AutoModel


文件夹中有一个名为[Simple]的示例



生成的代码介绍：

list可以直接转化为NSData类型，数据类中实现了<NSCoding>协议
    例如：
    NSData *data=[NSKeyedArchiver archivedDataWithRootObject:list];
    list=[NSKeyedUnarchiver unarchiveObjectWithData:data];

自定义的类名+Manager 是用来管理的类

属性中：
@property (strong,nonatomic)NSMutableArray *list;//存储的对象列表，可以直接对这个数组进行操作，然后用[... updata]方法储存进数据库
@property BOOL autoUpdata;//是否自动存储，默认为YES；设定为NO的时候，add／delete等操作之后需要手动调用[... updata]方法

+(id)share;//获取管理类

-(NSMutableArray*)getall;//读取数据，将数据库中的数据读取到list中
-(BOOL)updata;//存储数据，将list中的数据存储到数据库中

-(BOOL)printall;//打印所有的数据

-(BOOL)addWithname:(NSString *)name age:(NSInteger )age ;//添加对象
-(BOOL)addObject:(Test*)del;
-(BOOL)addObjects:(NSArray*)array;//将数组中的数据添加进去，其中的对象类型必须符合

-(BOOL)deleteObject:(Test*)del;//删除对象
-(BOOL)deleteall;//删除所有数据

-(NSArray*)findObjectIn:(NSString*)where for:(NSString*)string;
-(NSArray*)findbyPredicate:(NSPredicate*)predicate;//以谓词为搜索条件搜索
//例如NSPredicate *predicate=[NSPredicate predicateWithFormat:@"name=%@",name];

-(NSDictionary*)dictionaryWithObject:(Test*)obj;//对象转化为字典
-(Test*)objectWithDictionary:(NSDictionary*)dict;//字典转化为对象
-(NSArray*)dictionaryArrayWithAllObject;//将list中的对象全转化为字典类型的，然后放入数组中
-(NSArray*)dictionaryArrayWithArray:(NSArray*)array;将array中的对象全转化为字典类型的，然后放入数组中
-(BOOL)saveDictionaryArray:(NSArray*)array;//将数组中字典格式的数据转化回来，然后存进去

-(BOOL)checkObjectClass:(id)obj;//检测对象是否是正确的类


示例：Test是自定义的数据组名，实际使用时是不同的
TestManager *tm=[TestManager share];//获取管理类
[tm deleteall];//清空
[tm addWithname:@"xcewc" age:12];//添加一条数据
NSData *data=[NSJSONSerialization dataWithJSONObject:[tm dictionaryArrayWithAllObject] options:NSJSONWritingPrettyPrinted error:nil];//转化成JSON数据
NSLog(@"%@",[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding]);//转化成JSON字符串

NSArray *array=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];//将JSON数据转化回来
[tm saveDictionaryArray:array];//保存，注意这个方法和-(BOOL)addObjects:(NSArray*)array;要求的类型不同
[tm printall];//打印所有的数据，现在有两条同样的数据了
