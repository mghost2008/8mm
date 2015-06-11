//
//  SubscribeNewsListViewController.m
//  bahaomi
//
//  Created by lamto on 15/5/27.
//  Copyright (c) 2015年 yuedongxinji. All rights reserved.
//

#import "SubscribeNewsListViewController.h"

@interface SubscribeNewsListViewController ()

@end

@implementation SubscribeNewsListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self buildLayout];
    [self buildData];
}

- (void)buildLayout{
    [self.view setFrame:CGRectMake(0, 108, self.view.frame.size.width, self.view.frame.size.height-140)];
}

/**
 *  集成刷新控件
 */
- (void)setupRefresh
{
    // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
    [self.tableView addHeaderWithTarget:self action:@selector(headerRereshing)];
    
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    [self.tableView addFooterWithTarget:self action:@selector(footerRereshing)];
    //[self.tableView footerBeginRefreshing];
    
    // 设置文字(也可以不设置,默认的文字在MJRefreshConst中修改)
    self.tableView.headerPullToRefreshText = @"下拉刷新";
    self.tableView.headerReleaseToRefreshText = @"松开马上刷新";
    self.tableView.headerRefreshingText = @"刷新中,";
    
    self.tableView.footerPullToRefreshText = @"上拉可以加载更多数据";
    self.tableView.footerReleaseToRefreshText = @"松开加载更多数据";
    self.tableView.footerRefreshingText = @"加载中";
}

- (void)buildData{
    [self setupRefresh];
    [self requestInitData:self.curDate];
}

- (NSMutableArray *)infoArr{
    if (!_infoArr) {
        _infoArr = [NSMutableArray array];
    }
    return _infoArr;
}

- (NSDate *)curDate{
    if (!_curDate) {
        _curDate = [NSDate date];
    }
    return _curDate;
}

- (NSDate *)lastDate{
    if (!_lastDate) {
        _lastDate = [NSDate date];
    }
    return _lastDate;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) setInfoDic:(NSMutableDictionary *)infoDic{
    _infoDic = infoDic;
    self.title = [_infoDic objectForKey:@"accountName"];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [self.infoArr count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *infodic  = [self.infoArr objectAtIndex:[indexPath row]];
    if ([[infodic objectForKey:@"isChief"] boolValue] == 0) {
        return 77;
    }else{
        return 230;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *infodic  = [self.infoArr objectAtIndex:[indexPath row]];
    if ([[infodic objectForKey:@"isChief"] boolValue] == 0) {
        SmallCell *scell = (SmallCell *)[tableView dequeueReusableCellWithIdentifier:SCellIdentifier];
        if (scell == nil) {
            scell = [[[NSBundle mainBundle] loadNibNamed:@"SmallCell" owner:self options:nil]lastObject];
        }
        [scell setInfoDic:infodic];
        return scell;
    }else{
        LargeCell *lcell = (LargeCell *)[tableView dequeueReusableCellWithIdentifier:LCellIdentifier];
        if (lcell == nil){
            lcell = [[[NSBundle mainBundle] loadNibNamed:@"LargeCell" owner:self options:nil]lastObject];
        }
        [lcell setInfoDic:infodic];
        return lcell;
    }
}

#pragma mark 开始进入刷新状态
- (void)headerRereshing
{
    // 1.添加新数据
    [self requestNewData:self.curDate];
    
    // 2.2秒后刷新表格UI
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        [self.tableView reloadData];
        
        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
        [self.tableView headerEndRefreshing];
    });
}

- (void)footerRereshing
{
    // 1.添加假数据
    [self requestOldData:self.lastDate];
    
    // 2.2秒后刷新表格UI
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        [self.tableView reloadData];
        
        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
        [self.tableView footerEndRefreshing];
    });
}

#pragma requestdata
- (void) requestInitData:(NSDate *)date{
    NSString *url = [NSString stringWithFormat:SUBSCRIBE_ACCOUNT_NEWS_INIT, [self.infoDic objectForKey:@"id"], [Util NSDateToString:self.curDate], 10];
    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"%@, %@", self.curDate, url);
    [NetworkUtil JSONDataWithUrl:url success:^(id json){
        NSDictionary *responseJson = json;
        NSMutableArray *temparr = [NSMutableArray array];
        [temparr addObjectsFromArray:[responseJson objectForKey:@"content"]];
        [temparr addObjectsFromArray:self.infoArr];
        self.infoArr = temparr;
        self.curDate = [Util NSDateFromString:[[self.infoArr objectAtIndex:0] objectForKey:@"pubDate"]];
        if (self.infoArr.count == 0 ) {
            self.lastDate = self.curDate;
        }else{
            self.lastDate = [Util NSDateFromString:[[self.infoArr objectAtIndex:(self.infoArr.count-1)] objectForKey:@"pubDate"]];
        }
        //self.infodic = json;
        //NSLog(@"%@", self.infodic);
        [self.tableView reloadData];
    }fail:^(void){
        NSLog(@"NETWORK ERROR!!!");
    }];
}

- (void) requestNewData:(NSDate *)date{
    NSString *url = [NSString stringWithFormat:SUBSCRIBE_ACCOUNT_NEWS_NEW, [self.infoDic objectForKey:@"id"], [Util NSDateToString:self.curDate], 10];
    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"%@, %@", self.curDate, url);
    [NetworkUtil JSONDataWithUrl:url success:^(id json){
        NSDictionary *responseJson = json;
        NSMutableArray *temparr = [NSMutableArray array];
        [temparr addObjectsFromArray:[responseJson objectForKey:@"content"]];
        [temparr addObjectsFromArray:self.infoArr];
        self.infoArr = temparr;
        self.curDate = [Util NSDateFromString:[[self.infoArr objectAtIndex:0] objectForKey:@"pubDate"]];
        if (self.infoArr.count == 0 ) {
            self.lastDate = self.curDate;
        }else{
            self.lastDate = [Util NSDateFromString:[[self.infoArr objectAtIndex:(self.infoArr.count-1)] objectForKey:@"pubDate"]];
        }
        //self.infodic = json;
        //NSLog(@"%@", self.infodic);
        [self.tableView reloadData];
    }fail:^(void){
        NSLog(@"NETWORK ERROR!!!");
    }];
}

- (void) requestOldData:(NSDate *)date{
    NSString *url = [NSString stringWithFormat:SUBSCRIBE_ACCOUNT_NEWS_OLD, [self.infoDic objectForKey:@"id"], [Util NSDateToString:self.lastDate], 10];
    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"%@, %@", self.lastDate, url);
    [NetworkUtil JSONDataWithUrl:url success:^(id json){
        NSDictionary *responseJson = json;
        [self.infoArr addObjectsFromArray:[responseJson objectForKey:@"content"]];
        self.curDate = [Util NSDateFromString:[[self.infoArr objectAtIndex:0] objectForKey:@"pubDate"]];
        if (self.infoArr.count == 0 ) {
            self.lastDate = self.curDate;
        }else{
            self.lastDate = [Util NSDateFromString:[[self.infoArr objectAtIndex:(self.infoArr.count-1)] objectForKey:@"pubDate"]];
        }
        //self.infodic = json;
        //NSLog(@"%@", self.infodic);
        [self.tableView reloadData];
    }fail:^(void){
        NSLog(@"NETWORK ERROR!!!");
    }];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DetailViewController *detailCtl = [[DetailViewController alloc] init];
    UITableViewCell *cell = (UITableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    NSMutableDictionary *dic;
    if ([cell isKindOfClass:[LargeCell class]])
        dic = [NSMutableDictionary dictionaryWithDictionary:[((LargeCell *)cell) infoDic]];
    else
        dic = [NSMutableDictionary dictionaryWithDictionary:[((SmallCell *)cell) infoDic]];
    [detailCtl setInofDic:dic];
    [detailCtl setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:detailCtl animated:YES];
}

@end
