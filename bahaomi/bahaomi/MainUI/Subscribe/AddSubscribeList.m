//
//  AddSubscribeList.m
//  bahaomi
//
//  Created by  王国众 on 15/5/28.
//  Copyright (c) 2015年 yuedongxinji. All rights reserved.
//

#import "AddSubscribeList.h"

@interface AddSubscribeList ()

@end

@implementation AddSubscribeList

- (void)viewDidLoad {
    [super viewDidLoad];
    [self buildData];
}

- (void)buildData{

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [self.commendArr count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *addViewIdentifier =@"addListCell";
    NSDictionary *infodic  = [self.commendArr objectAtIndex:[indexPath row]];
    AddSubscribeCell *cell = [tableView dequeueReusableCellWithIdentifier:addViewIdentifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"AddSubscribeCell" owner:self options:nil]lastObject];
    }
    [cell setInfoDic:infodic];
    [cell setSubscribed:[self isSubscribed:infodic]];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    AddSubscribeCell *cell = (AddSubscribeCell *)[tableView cellForRowAtIndexPath:indexPath];
    [cell addBtnClick:cell.addBtn];
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (void)setCommendArr:(NSMutableArray *)commendArr andUserBookArr:(NSMutableArray *)bookArr{
    self.commendArr = commendArr;
    self.userBookArr = bookArr;
}

- (BOOL)isSubscribed:(NSDictionary *)info{
    for (NSInteger i = 0; i < [self.userBookArr count]; i++) {
        NSDictionary *tmp = [self.userBookArr objectAtIndex:i];
        if ([tmp objectForKey:@"id"] == [info objectForKey:@"id"]) {
            return YES;
        }
    }
    return NO;
}

@end
