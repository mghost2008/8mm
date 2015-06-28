//
//  CollectViewController.m
//  bahaomi
//
//  Created by  王国众 on 15/6/13.
//  Copyright (c) 2015年 yuedongxinji. All rights reserved.
//

#import "CollectViewController.h"
#import "AppDelegate.h"

@interface CollectViewController (){
    AppDelegate *appDelegate;
}

@end

@implementation CollectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self buildLayout];
    [self buildData];
}

- (void) buildLayout{
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [self.tableView setFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height - 108)];
    [self.tableView setTableFooterView:[[UIView alloc] init]];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(collectListChanged) name:USER_COLLECT_CHANGED object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(collectListLocalChanged) name:USER_COLLECT_LIST_CHANGE object:nil];
}

- (void) collectListChanged{
    self.collectList = [appDelegate.collectArr mutableCopy];
    [self.tableView reloadData];
}

- (void) collectListLocalChanged{
    self.collectList = [appDelegate.collectArr mutableCopy];
}

- (void) buildData{
    self.collectList = [appDelegate.collectArr mutableCopy];//[appDelegate collectArr];
    printf("is NSMutableArray %d\n", [self.collectList isKindOfClass:[NSMutableArray class]]);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

//滑动删除的实现
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSMutableDictionary *dic = [self.collectList objectAtIndex:indexPath.row];
        NSString *url = [NSString stringWithFormat:USER_CANCEL_COLLECT_ARTICLE, [dic objectForKey:@"id"]];
        [NetworkUtil JSONDataWithUrl:url success:^(id json){
            //取消成功
            [self.collectList removeObjectAtIndex:indexPath.row];
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        }fail:^(void){
            NSLog(@"CANCEL_COLLECT_FAILED");
        }];        
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.collectList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *infodic  = [[self.collectList objectAtIndex:[indexPath row]] objectForKey:@"article"];
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *infodic  = [[self.collectList objectAtIndex:[indexPath row]] objectForKey:@"article"];
    if ([[infodic objectForKey:@"isChief"] boolValue] == 0) {
        return 77;
    }else{
        return 230;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
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
