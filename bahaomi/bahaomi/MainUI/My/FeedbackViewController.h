//
//  FeedbackViewController.h
//  bahaomi
//
//  Created by  王国众 on 15/6/22.
//  Copyright (c) 2015年 yuedongxinji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BHM_TextField.h"
#import "NetworkUtil.h"
#import "Message.h"

@interface FeedbackViewController : UIViewController

@property (weak, nonatomic) IBOutlet BHM_TextField *contactTextView;
@property (weak, nonatomic) IBOutlet UITextView *feedbackTextView;
@property (strong, nonatomic) UIBarButtonItem *submitBtn;

@end
