//
//  SubscribeRootViewController.m
//  bahaomi
//
//  Created by  王国众 on 15/6/8.
//  Copyright (c) 2015年 yuedongxinji. All rights reserved.
//

#import "SubscribeRootViewController.h"
#import "AppDelegate.h"

@interface SubscribeRootViewController ()

@end

@implementation SubscribeRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self buildLayout];
}

- (void) buildLayout{
    [self.view addSubview:self.collectionController.view];
}

- (SubscribeCollectionController *) collectionController{
    if (!_collectionController) {
        UICollectionViewFlowLayout *layout= [[UICollectionViewFlowLayout alloc]init];
        layout.itemSize = CGSizeMake((SCREEN_WIDTH-2)/3, (SCREEN_WIDTH-2)/3);
        layout.minimumLineSpacing = 1;
        layout.minimumInteritemSpacing = 0;
        _collectionController = [[SubscribeCollectionController alloc] initWithCollectionViewLayout:layout];
        [_collectionController.collectionView setBackgroundColor:UIColorFromRGB(0xE4E8EB)];
        [_collectionController.collectionView setFrame:CGRectMake(0, 44, self.view.frame.size.width, self.view.frame.size.height - 108)];
        [_collectionController setNavController:self.navigationController];
        UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"addsubimg" ] style:UIBarButtonItemStylePlain target:self action:@selector(addClick:)];
        [self.navigationItem setRightBarButtonItem: rightItem];
    }
    return _collectionController;
}

- (void) addClick:(UIBarButtonItem *)item{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if (![appDelegate isLogin]) {
        [[NSNotificationCenter defaultCenter] postNotificationName:NEED_LOGIN object:nil];
        return;
    }
    AddSubscribeList *addListView = [[AddSubscribeList alloc] init];
    [addListView setTitle:@"添加"];
    [addListView setUserDelegate:self];
    [addListView setCommendArr:self.collectionController.commendArr andUserBookArr:self.collectionController.userBookArr];
    [self.navigationController pushViewController:addListView animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) userBookChanged{
    //请求网络保存，服务器端修改接口，每次上传新的订阅关系，需要清空原有的订阅关系，
    NSMutableArray *params = [self makeParams];
    
    [NetworkUtil postJSONWithUrl:BOOK_CREATE parameters:params success:^(id responseObject){
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        NSString *url = [NSString stringWithFormat:SUBSCRIBE_BY_USER, [appDelegate.userInfo objectForKey:@"id"]];
        [NetworkUtil JSONDataWithUrl:url success:^(id json){
            appDelegate.bookArr = json;
            //清空用户订阅列表
            [[DBUtil sharedManager] deleteAllBook];
            [[DBUtil sharedManager] insertAllBook:appDelegate.bookArr];
            appDelegate.bookArr = [[DBUtil sharedManager] getAllBook];
        }fail:^(void){
            NSLog(@"初始化用户订阅列表失败");
        }];
    }fail:^(void){
        NSLog(@"保存失败");
    }];                      
    
    //刷新界面
    [self.collectionController.collectionView reloadData];
}

- (NSMutableArray *) makeParams{
    NSMutableArray *params = [NSMutableArray array];
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSNumber *userId = [[appDelegate userInfo] objectForKey:@"id"];
    for (NSInteger i = 0; i < [self.collectionController.userBookArr count]; i ++) {
        NSMutableDictionary *dic = [self.collectionController.userBookArr objectAtIndex:i];
        NSMutableDictionary *tmp = [NSMutableDictionary dictionary];
        [tmp setValue:userId forKey:@"userId"];
        [tmp setValue:[dic objectForKey:@"id"] forKey:@"accountId"];
        [params addObject:tmp];
    }
    return params;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
