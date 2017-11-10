//
//  ViewController.m
//  myDataSourceTest
//
//  Created by admin on 2017/10/24.
//  Copyright © 2017年 Zhongshan Camry Electronic Company Limited. All rights reserved.
//

#import "ViewController.h"
#import "MyDataSource.h"
#import "myCell.h"
#import "secondCell.h"

@interface ViewController ()<UITableViewDelegate>
@property (nonatomic, strong) MyDataSource *myDataSource;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [self.view addSubview:tableView];
    NSArray *array = @[@"大大",@"dadaa",@"gggdg",@"oooo"];
    
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
        return 200;
    } cellDidSelectBlock:^(NSIndexPath *indexPath, id model) {
        NSLog(@"%ld",(long)indexPath.row);
    }];
    [_myDataSource handleView:tableView delegate:YES];
    [self.myDataSource addModels:array];
    [tableView reloadData];
    
}

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    NSLog(@"%ld",indexPath.row);
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
