//
//  SubscribeCollectionController.m
//  bahaomi
//
//  Created by lamto on 15/6/11.
//  Copyright (c) 2015年 yuedongxinji. All rights reserved.
//

#import "SubscribeCollectionController.h"
#import "AppDelegate.h"

@interface SubscribeCollectionController ()

@end

@implementation SubscribeCollectionController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.collectionView registerClass:[CollectionCell class] forCellWithReuseIdentifier:ColCellIdentifier];
    [self buildData];
}

- (void)buildData{
    //直接使用app启动时读取的列表，不做刷新操作
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    self.commendArr =  [appDelegate commendArr];
    self.infoArr = [appDelegate bookArr];
    for (NSInteger i = 0 ; i < [self.commendArr count]; i++) {
        NSDictionary *tmp = [self.commendArr objectAtIndex:i];
        NSNumber *isCommended = [tmp objectForKey:@"isCommended"];
        if ([isCommended boolValue]) {
            [self.sysCommendArr addObject:tmp];
        }
        for (NSInteger j = 0 ; j < [self.infoArr count]; j ++) {
            NSDictionary *tmpBook = [self.infoArr objectAtIndex:j];
            if ([tmpBook objectForKey:@"accountId"] == [tmp objectForKey:@"id"]) {//已经订阅
                [self.userBookArr addObject:tmp];
            }
        }
    }
    if ([self.userBookArr count] == 0) {
        self.userBookArr = self.sysCommendArr;
    }
}

- (NSMutableArray *)userBookArr{
    if (!_userBookArr) {
        _userBookArr = [NSMutableArray array];
    }
    return _userBookArr;
}

- (NSMutableArray *)sysCommendArr{
    if (!_sysCommendArr) {
        _sysCommendArr = [NSMutableArray array];
    }
    return _sysCommendArr;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.userBookArr count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *infodic  = [self.userBookArr objectAtIndex:[indexPath row]];
    CollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ColCellIdentifier forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"CollectionCell" owner:self options:nil]lastObject];
    }
    
    [cell setInfoDic: [[NSMutableDictionary alloc] initWithDictionary:infodic]];
    return cell;
}
#pragma mark <UICollectionViewDelegate>
//选中
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    CollectionCell *cell = (CollectionCell *)[collectionView cellForItemAtIndexPath:indexPath];
    SubscribeNewsListViewController *newsList = [[SubscribeNewsListViewController alloc] init];
    [newsList setInfoDic:cell.infoDic];
    [self.navController pushViewController:newsList animated:YES];
}

// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}



// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

@end
