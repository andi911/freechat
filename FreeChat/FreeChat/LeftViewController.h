//
//  LeftViewController.h
//  FreeChat
//
//  Created by liangyu on 15/5/4.
//  Copyright (c) 2015年 Feng Junwen. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol LeftDelegate<NSObject>
- (void)selectLeftTableView:(NSIndexPath*)indexpath;
@end

@interface LeftViewController : UIViewController
@property (nonatomic, strong)UITableView *tableView;
@property (weak, nonatomic)id<LeftDelegate>LeftDelegate;
@end
