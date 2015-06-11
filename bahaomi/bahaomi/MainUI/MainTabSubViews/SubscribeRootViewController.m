//
//  SubscribeRootViewController.m
//  bahaomi
//
//  Created by  王国众 on 15/6/8.
//  Copyright (c) 2015年 yuedongxinji. All rights reserved.
//

#import "SubscribeRootViewController.h"

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
    AddSubscribeList *addListView = [[AddSubscribeList alloc] init];
    [addListView setTitle:@"添加"];
    [addListView setCommendArr:self.collectionController.commendArr andUserBookArr:self.collectionController.userBookArr];
    [self.navigationController pushViewController:addListView animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
