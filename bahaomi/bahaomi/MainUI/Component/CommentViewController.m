//
//  CommentViewController.m
//  bahaomi
//
//  Created by  王国众 on 15/6/13.
//  Copyright (c) 2015年 yuedongxinji. All rights reserved.
//

#import "CommentViewController.h"
#import "AppDelegate.h"

static NSString *MessengerCellIdentifier = @"MessengerCell";
static NSString *AutoCompletionCellIdentifier = @"AutoCompletionCell";

@interface CommentViewController (){
    NSMutableArray *_comments;
    AppDelegate *appDelegate;
}

@end

@implementation CommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self buildLayout];
}

- (void) buildLayout{
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [self.navigationItem setLeftBarButtonItem:self.backItem];
    self.bounces = YES;
    self.undoShakingEnabled = YES;
    self.keyboardPanningEnabled = YES;
    self.inverted = YES;

    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[MessageTableViewCell class] forCellReuseIdentifier:MessengerCellIdentifier];
    [self.autoCompletionView registerClass:[MessageTableViewCell class] forCellReuseIdentifier:AutoCompletionCellIdentifier];

    self.textInputbar.autoHideRightButton = NO;
    self.typingIndicatorView.canResignByTouch = YES;

    self.textView.placeholder = NSLocalizedString(@"评论内容", nil);
    self.textView.placeholderColor = [UIColor lightGrayColor];
    self.textInputbar.backgroundColor = [UIColor colorWithRed:240.0/255.0 green:240.0/255.0 blue:240.0/255.0 alpha:1.0];
    self.textView.layer.borderColor = [UIColor colorWithRed:217.0/255.0 green:217.0/255.0 blue:217.0/255.0 alpha:1.0].CGColor;

    [self.rightButton setTitle:NSLocalizedString(@"提交", nil) forState:UIControlStateNormal];

    [self.textInputbar.editorTitle setTextColor:[UIColor darkGrayColor]];
    [self.textInputbar.editortRightButton setTintColor:[UIColor colorWithRed:0.0/255.0 green:122.0/255.0 blue:255.0/255.0 alpha:1.0]];

    [self registerPrefixesForAutoCompletion:@[@"@", @"#", @":"]];

}

- (void) setArticleInfo:(NSMutableDictionary *)articleInfo{
    _articleInfo = articleInfo;
    [self buildData];
}

- (void)buildData{
    NSString *url = [NSString stringWithFormat:FIND_COMMENTS_BY_ARTICLE, [self.articleInfo objectForKey:@"id"]];
    [NetworkUtil JSONDataWithUrl:url success:^(id json){
        _comments = json;
        [self.tableView reloadData];
    }fail:^(void){
        NSLog(@"获取文章评论失败");
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIBarButtonItem *)backItem{
    if (!_backItem) {
        _backItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"backimg"] style:UIBarButtonItemStylePlain target:self action:@selector(backItemClick:)];
    }
    return _backItem;
}

- (void)backItemClick:(UIBarButtonItem *)item{
    [self.navigationController setToolbarHidden:NO];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UITableViewDataSource Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _comments.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSMutableDictionary *dic = [_comments objectAtIndex:indexPath.row];
    self.textView.text = [NSString stringWithFormat:@"%@ // ",[dic objectForKey:@"content"]];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self messageCellForRowAtIndexPath:indexPath];
//    return [self autoCompletionCellForRowAtIndexPath:indexPath];
}

- (MessageTableViewCell *)messageCellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MessageTableViewCell *cell = (MessageTableViewCell *)[self.tableView dequeueReusableCellWithIdentifier:MessengerCellIdentifier];
    
    if (!cell.textLabel.text) {
//        UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(editCellMessage:)];
//        [cell addGestureRecognizer:longPress];
    }
    
    NSString *message = [_comments[indexPath.row] objectForKey:@"content"];
    cell.textLabel.text = message;
    cell.indexPath = indexPath;
    cell.topAligned = YES;
    
    if (cell.needsPlaceholder)
    {
        cell.needsPlaceholder = NO;
        
        CGFloat scale = [UIScreen mainScreen].scale;
        
        if ([[UIScreen mainScreen] respondsToSelector:@selector(nativeScale)]) {
            scale = [UIScreen mainScreen].nativeScale;
        }
        
        CGSize imgSize = CGSizeMake(kAvatarSize*scale, kAvatarSize*scale);
        
        [LoremIpsum asyncPlaceholderImageWithSize:imgSize
                                       completion:^(UIImage *image) {
                                           image = [UIImage imageWithCGImage:image.CGImage scale:scale orientation:UIImageOrientationUp];
                                           cell.imageView.image = image;
                                       }];
    }

    cell.transform = self.tableView.transform;
    
    return cell;
}

//提交事件
- (void) didPressRightButton:(id)sender{
    //提交评论
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSMutableDictionary *user = [NSMutableDictionary dictionaryWithObject:[appDelegate.userInfo objectForKey:@"id"] forKey:@"id"];
    [params setValue:user forKey:@"user"];
    [params setValue: [self.articleInfo objectForKey:@"id"] forKey:@"articleId"];
    [params setValue:self.textView.text forKey:@"content"];
    [NetworkUtil postJSONWithUrl:COMMIT_COMMENT parameters:params success:^(id responseObj){
        [self buildData];
        [super didPressRightButton:sender];
        [self.textView resignFirstResponder];
    }fail:^(void){
        NSLog(@"评论提交失败");
    }];
}

@end
