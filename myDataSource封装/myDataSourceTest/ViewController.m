

#import "ViewController.h"
#import "MyDataSource.h"
#import "myCell.h"
#import "secondCell.h"

@interface ViewController ()
@property (nonatomic, strong) MyDataSource *myDataSource;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [self.view addSubview:tableView];
    NSArray *array = @[@"11111",@"2222",@"33333",@"44444"];
    
//    tableView.estimatedRowHeight = 40;//预算高度
//    tableView.rowHeight = UITableViewAutomaticDimension;
//    _myDataSource = [[MyDataSource alloc] initWithIdentifier:@"secondCell" cellConfigureBlock:^(id cell, id model, NSIndexPath *indePath) {
//        [cell loadData:model];
//    }];
//    [self.myDataSource addModels:array];
//    tableView.dataSource = self.myDataSource;
//    tableView.delegate = self;
//    [tableView reloadData];
    
    
    _myDataSource = [[MyDataSource alloc] initWithIdentifier:@"secondCell" cellConfigureBlock:^(id cell, id model, NSIndexPath *indePath) {
        [cell loadData:model];
    } cellHeightBlock:^CGFloat(NSIndexPath *indexPath, id model) {
        return 100; // 设置cell高度
    } cellDidSelectBlock:^(NSIndexPath *indexPath, id model) {
        NSLog(@"%ld",(long)indexPath.row); // cell 点击事件
    }];
    [_myDataSource handleView:tableView delegate:YES];
    [self.myDataSource addModels:array];
    [tableView reloadData];
    
}




@end
