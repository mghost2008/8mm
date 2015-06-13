//
//  CommentViewController.m
//  bahaomi
//
//  Created by  王国众 on 15/6/13.
//  Copyright (c) 2015年 yuedongxinji. All rights reserved.
//

#import "CommentViewController.h"
#import "AppDelegate.h"

@interface CommentViewController (){
    AppDelegate *appDelegate;
}

@end

@implementation CommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self buildLayout];
    [self buildData];
}

- (void) buildLayout{
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [self.tableView setFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height - 108)];
    [self.tableView setTableFooterView:[[UIView alloc] init]];
}

- (void) buildData{
    NSString *url = [NSString stringWithFormat:FIND_COMMENTS_BY_ARTICLE, self.articleId];
    [NetworkUtil JSONDataWithUrl:url success:^(id json){
        self.commentList = json;
    }fail:^(void){
        NSLog(@"FIND COMMENTS FAIELD");
    }];
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
    return [self.commentList count];
}


@end
