//
//  MyDataSource.h
//  myDataSourceTest
//
//  Created by admin on 2017/10/24.
//  Copyright © 2017年 Zhongshan Camry Electronic Company Limited. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

// 实现对 tableview/collectionview datasource/delegate 的封装
// dataspurce
typedef void(^CellConfigureBlock)(id cell,id model,NSIndexPath *indePath);
// delegate
typedef CGFloat(^CellHeightBlock)(NSIndexPath *indexPath,id model);
typedef void(^CellDidSelectBlock)(NSIndexPath *indexPath,id model);

@interface MyDataSource : NSObject<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) NSString *identifier;
@property (nonatomic, copy) CellConfigureBlock cellConfigureBlock;
@property (nonatomic, copy) CellHeightBlock cellHeightBlock;
@property (nonatomic, copy) CellDidSelectBlock cellDidSelectBlock;
@property (nonatomic, strong) NSMutableArray *dataArray; // 数据源使用

// dataSource
- (id)initWithIdentifier:(NSString *)identifier cellConfigureBlock:(CellConfigureBlock)aBlock;
// dataSource + delegate
- (id)initWithIdentifier:(NSString *)identifier cellConfigureBlock:(CellConfigureBlock)aBlock cellHeightBlock:(CellHeightBlock)heightBlock cellDidSelectBlock:(CellDidSelectBlock)selectBlock;

// 授权
- (void)handleView:(UITableView *)view delegate:(BOOL)delegate;

// 设定数据源
- (void)addModels:(NSArray *)models;

- (id)modelsAtIndexPath:(NSIndexPath *)indexPath;



@end
