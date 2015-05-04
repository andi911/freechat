//
//  RightViewController.h
//  FreeChat
//
//  Created by liangyu on 15/5/4.
//  Copyright (c) 2015年 Feng Junwen. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol RightDelegate<NSObject>
- (void)selectRightDelegate:(NSIndexPath *)indexpath;
@end
@interface RightViewController : UIViewController
@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, weak)id<RightDelegate>RightDelegate;
@end
