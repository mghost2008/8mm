//
//  FeedbackViewController.h
//  bahaomi
//
//  Created by  王国众 on 15/6/22.
//  Copyright (c) 2015年 yuedongxinji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Message.h"

@interface FeedbackViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextView *feedbackTextView;
- (IBAction)submitBtnClick:(id)sender;

@end
