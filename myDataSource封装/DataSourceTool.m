//
//  DataSourceTool.m
//  myDataSourceTest
//
//  Created by admin on 2017/10/25.
//  Copyright © 2017年 Zhongshan Camry Electronic Company Limited. All rights reserved.
//

#import "DataSourceTool.h"


@implementation DataSourceTool
- (id)initWithIdentifier:(NSString *)identifier cellConfigureBlock:(CellConfigureBlock)aBlock{
    if (self = [super init]) {
        _identifier = identifier;
        _cellConfigureBlock = [aBlock copy];
    }
    return self;
}

- (id)initWithIdentifier:(NSString *)identifier cellConfigureBlock:(CellConfigureBlock)aBlock cellHeightBlock:(CellHeightBlock)heightBlock cellDidSelectBlock:(CellDidSelectBlock)selectBlock{
    if (self = [super init]) {
        _identifier = identifier;
        _cellConfigureBlock = [aBlock copy];
        _cellHeightBlock = [heightBlock copy];
        _cellDidSelectBlock = [selectBlock copy];
    }
    return self;
}

- (NSMutableArray *)dataArray{
    if (_dataArray == nil) {
        self.dataArray = [@[] mutableCopy];
    }
    return _dataArray;
}

- (id)modelsAtIndexPath:(NSIndexPath *)indexPath{
    return _dataArray.count > indexPath.row ? _dataArray[indexPath.row] : nil;
}

- (void)addModels:(NSArray *)models{
    if (!models) {
        return;
    }
    [self.dataArray addObjectsFromArray:models];
}

- (void)handleView:(UITableView *)view delegate:(BOOL)delegate{
    view.dataSource = self;
    if (delegate) {
        view.delegate = self;
    }
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray == nil ? 0 : _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:_identifier];
    UITableViewCell *cell;
//    if ([_identifier isEqualToString:@"MTCell"]) {
//        cell = (myCell *)cell;
//        cell = [tableView dequeueReusableCellWithIdentifier:_identifier];
//        if(cell == nil) {
//            cell = [[myCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:_identifier];
//        }
//    }
//    
//    if ([_identifier isEqualToString:@"secondCell"]) {
//        cell = (secondCell *)cell;
//        cell = [tableView dequeueReusableCellWithIdentifier:_identifier];
//        if(cell == nil) {
//            cell = [[secondCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:_identifier];
//        }
//    }
    
    id model = [self modelsAtIndexPath:indexPath];
    if (_cellConfigureBlock) {
        _cellConfigureBlock(cell,model,indexPath);
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    id model = [self modelsAtIndexPath:indexPath];
    return self.cellHeightBlock(indexPath,model);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    id model = [self modelsAtIndexPath:indexPath];
    self.cellDidSelectBlock(indexPath, model);
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _dataArray == nil ? 0 : _dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:_identifier forIndexPath:indexPath];
    id model = [self modelsAtIndexPath:indexPath];
    if (_cellConfigureBlock) {
        _cellConfigureBlock(cell,model,indexPath);
    }
    return cell;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    id model = [self modelsAtIndexPath:indexPath];
    _cellHeightBlock(indexPath,model);
}

@end
