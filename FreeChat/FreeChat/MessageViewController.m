//
//  MessageViewController.m
//  FreeChat
//
//  Created by liangyu on 15/5/4.
//  Copyright (c) 2015年 Feng Junwen. All rights reserved.
//

#import "MessageViewController.h"
#import "LeftViewController.h"
#import "RightViewController.h"
#import "RecentConversationViewController.h"
@interface MessageViewController ()<LeftDelegate,RightDelegate> {
    RecentConversationViewController *center;
    LeftViewController *left;
    RightViewController *right;
    BOOL showLeft;
    BOOL showRight;
    double Coefficient;
}
@property (nonatomic, strong)UIPanGestureRecognizer *panGesture;
@end

@implementation MessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImageView *imageview=[[UIImageView alloc]initWithFrame:self.view.frame];
    [self.view addSubview:imageview];
    imageview.image=[UIImage imageNamed:@"333.jpg"];

    showLeft = NO;
    left.view.hidden = YES;
    showRight = NO;
    right.view.hidden = YES;
    
    left=[[LeftViewController alloc]init];
    left.view.backgroundColor=[UIColor clearColor];
    [self addChildViewController:left];
    [left didMoveToParentViewController:self];
    [self.view addSubview:left.view];
    
    right=[[RightViewController alloc]init];
    right.view.backgroundColor=[UIColor clearColor];
    [self addChildViewController:right];
    [right didMoveToParentViewController:self];
    [self.view addSubview:right.view];

    center=[[RecentConversationViewController alloc]init];
    center.view.backgroundColor=[UIColor clearColor];
    [self addChildViewController:center];
    [center didMoveToParentViewController:self];
    [self.view addSubview:center.view];

    
    self.panGesture =[[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panHandle:)];
    [self.panGesture setMaximumNumberOfTouches:1];
    [center.view addGestureRecognizer:self.panGesture];
    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapHandle:)];
    tap.numberOfTapsRequired=1;
    tap.numberOfTouchesRequired=1;
    [center.view addGestureRecognizer:tap];
    [self loadNagaviButton];
}

- (void)loadNagaviButton {
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"iconfont-qq.png"] style:UIBarButtonItemStylePlain target:self action:@selector(showLeftView)];
    self.navigationItem.leftBarButtonItem = leftButton;
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"iconfont-jiantou.png"] style:UIBarButtonItemStylePlain target:self action:@selector(showRightView)];
    self.navigationItem.rightBarButtonItem = rightButton;
}

- (void)showLeftView {
    showLeft=YES;
    left.view.hidden=NO;
    showRight=NO;
    right.view.hidden=YES;
        [UIView animateWithDuration:0.3 animations:^{
            center.view.transform = CGAffineTransformScale(CGAffineTransformIdentity,0.8,0.8);
            center.view.center = CGPointMake([UIScreen mainScreen].bounds.size.width,[UIScreen mainScreen].bounds.size.height/2);
        }];
}

- (void)showRightView {
    showLeft=NO;
    left.view.hidden=YES;
    showRight=YES;
    right.view.hidden=NO;
        [UIView animateWithDuration:0.3 animations:^{
            center.view.transform = CGAffineTransformScale(CGAffineTransformIdentity,0.8,0.8);
            center.view.center = CGPointMake(0,[UIScreen mainScreen].bounds.size.height/2);
        }];
}



-(void)panHandle:(UIPanGestureRecognizer *)sender{
    CGPoint translation=[sender translationInView:self.view];
    Coefficient=fabs( translation.x*0.8+Coefficient);
    sender.view.center=CGPointMake(translation.x+sender.view.center.x, translation.y+sender.view.center.y);
    sender.view.transform=CGAffineTransformScale(CGAffineTransformIdentity, 1-Coefficient/1000, 1-Coefficient/1000);
    [sender setTranslation:CGPointMake(0, 0) inView:self.view];
    
    //判断往哪边拖
    if (sender.view.frame.origin.x>0) {
        [self showLeftView:sender.view];
    }else{
        [self showRightView:sender.view];
    }
    
}

-(void)tapHandle:(UITapGestureRecognizer *)sender{
    
    [UIView animateWithDuration:0.3 animations:^{
        sender.view.transform = CGAffineTransformScale(CGAffineTransformIdentity,1,1);
        sender.view.center = CGPointMake([UIScreen mainScreen].bounds.size.width/2,[UIScreen mainScreen].bounds.size.height/2);
        Coefficient=0;
    }];
    
}

-(void)showLeftView:(UIView *)sender{
    
    showLeft=YES;
    left.view.hidden=NO;
    showRight=NO;
    right.view.hidden=YES;
    if (self.panGesture.state==UIGestureRecognizerStateEnded) {
        [UIView animateWithDuration:0.3 animations:^{
            sender.transform = CGAffineTransformScale(CGAffineTransformIdentity,0.8,0.8);
            sender.center = CGPointMake([UIScreen mainScreen].bounds.size.width,[UIScreen mainScreen].bounds.size.height/2);
        }];
    }
    
}
-(void)showRightView:(UIView *)sender{
    
    showLeft=NO;
    left.view.hidden=YES;
    showRight=YES;
    right.view.hidden=NO;
    if (self.panGesture.state==UIGestureRecognizerStateEnded) {
        [UIView animateWithDuration:0.3 animations:^{
            sender.transform = CGAffineTransformScale(CGAffineTransformIdentity,0.8,0.8);
            sender.center = CGPointMake(0,[UIScreen mainScreen].bounds.size.height/2);
        }];
    }
    
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
