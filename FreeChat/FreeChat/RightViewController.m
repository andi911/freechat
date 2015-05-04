//
//  RightViewController.m
//  FreeChat
//
//  Created by liangyu on 15/5/4.
//  Copyright (c) 2015年 Feng Junwen. All rights reserved.
//

#import "RightViewController.h"

@interface RightViewController ()<UITableViewDelegate,UITableViewDataSource>{
    NSArray *listArray;
}

@end

@implementation RightViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadTableView];
    // Do any additional setup after loading the view.
}

- (void)loadTableView {
    listArray = @[@"扫一扫",@"建讨论组",@"面对面",@"群组电话",@"我的电脑",@"加好友"];
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return listArray.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *Cell=[[UITableViewCell alloc]init];
    UILabel *lable=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, Cell.frame.size.width-20, Cell.frame.size.height)];
    [Cell.contentView addSubview:lable];
    lable.textAlignment=NSTextAlignmentRight;
    lable.textColor=[UIColor whiteColor];
    Cell.backgroundColor=[UIColor clearColor];
    lable.text=[listArray objectAtIndex:indexPath.row];
    return Cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.RightDelegate selectRightDelegate:indexPath];
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
