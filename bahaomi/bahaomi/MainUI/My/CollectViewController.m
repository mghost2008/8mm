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
}

- (void) collectListChanged{
    self.collectList = [appDelegate collectArr];
    [self.tableView reloadData];
}

- (void) buildData{
    self.collectList = [appDelegate collectArr];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

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
