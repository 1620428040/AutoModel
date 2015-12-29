//
//  ViewController.m
//  AutoAPP
//
//  Created by 国栋 on 15/11/25.
//  Copyright (c) 2015年 GD. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *datagroupname;
@property (weak, nonatomic) IBOutlet UISegmentedControl *coredata;
@property (weak, nonatomic) IBOutlet UITextField *setnumberofdata;
- (IBAction)getnumberofdata:(id)sender;
@property (weak, nonatomic) IBOutlet UISegmentedControl *setselectnumber;
- (IBAction)getselectnumber:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *tableview;
- (IBAction)back:(id)sender;
- (IBAction)define:(id)sender;
@property (weak, nonatomic) IBOutlet UISegmentedControl *netselect;

@property(strong,nonatomic) DataGroupManager *datagroupmanager;

@end

@implementation ViewController

@synthesize datagroupmanager;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableview.delegate=self;
    self.tableview.dataSource=self;
    
    datagroupmanager=[DataGroupManager share];
    self.datagroupname.text=datagroupmanager.name;
    if(datagroupmanager.coredata==YES) {
        //self.coredata.selectedSegmentIndex=0;
    }
    else
    {
        //self.coredata.selectedSegmentIndex=1;
    }
    self.setnumberofdata.text=@"2";
    self.setselectnumber.selectedSegmentIndex=0;
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{}];
}

- (IBAction)define:(id)sender {
    
    //把信息保存到数据持久层
    datagroupmanager.name=self.datagroupname.text;
    datagroupmanager.net=self.netselect.selectedSegmentIndex;
    if (self.coredata.selectedSegmentIndex==0) {
        datagroupmanager.coredata=YES;
    }
    else
    {
        datagroupmanager.coredata=NO;
    }
    //各属性的名称和类型保持随时同步了
    
    
    //开始创建文件
    FileCreate *filecreate=[FileCreate share];
    [filecreate createfile];
    
    [[[UIAlertView alloc]initWithTitle:@"完成" message:@"文件创建已经完成，请手动添加到工程中。如果失败请查看日志" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles:nil]show];
}

- (IBAction)getselectnumber:(id)sender {
    self.setnumberofdata.text=[NSString stringWithFormat:@"%d",(int)self.setselectnumber.selectedSegmentIndex+2];
    [self.tableview reloadData];
}

- (IBAction)getnumberofdata:(id)sender {
    [self.tableview reloadData];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GDTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"rc"];
    cell.property.placeholder=@"要创建的属性的名称";
    cell.type.placeholder=@"数据类型";
    cell.tag=indexPath.row+1;
    if (indexPath.row<datagroupmanager.list.count) {
        DataGroupDG *dgi=[datagroupmanager.list objectAtIndex:indexPath.row];
        cell.property.text=dgi.name;
        cell.type.text=dgi.type;
    }
    return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    int number=[self.setnumberofdata.text intValue];
    int difference=number-(int)datagroupmanager.list.count;
    if (difference>0) {
        for (int i=0; i<difference; i++) {
            [datagroupmanager addWithname:nil type:nil];
        }
    }
    else if (difference<0)
    {
        difference=-difference;
        for (int i=0; i<difference; i++) {
            int j=(int)datagroupmanager.list.count-1;
            [datagroupmanager.list removeObjectAtIndex:j];
        }
    }
    return [self.setnumberofdata.text integerValue];
}
@end
