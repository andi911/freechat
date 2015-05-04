//
//  LeftViewController.m
//  FreeChat
//
//  Created by liangyu on 15/5/4.
//  Copyright (c) 2015年 Feng Junwen. All rights reserved.
//

#import "LeftViewController.h"

@interface LeftViewController ()<UITableViewDataSource,UITableViewDelegate>{
    NSArray *listArray;
}

@end

@implementation LeftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadTableView];
    // Do any additional setup after loading the view.
}

- (void)loadTableView {
    listArray = @[@"开通会员",@"QQ钱包",@"网上营业厅",@"个性打扮",@"我的收藏",@"我的相册"];
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.separatorColor = [UIColor clearColor];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
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
    UILabel *lable=[[UILabel alloc]initWithFrame:CGRectMake(20, 0, Cell.frame.size.width-20, Cell.frame.size.height)];
    [Cell.contentView addSubview:lable];
    Cell.backgroundColor=[UIColor clearColor];
    lable.textAlignment=NSTextAlignmentLeft;
    lable.textColor=[UIColor whiteColor];
    lable.text=[listArray objectAtIndex:indexPath.row];
    return Cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    [self.Leftdelegate sendString:[self.listArray objectAtIndex:indexPath.row]];
    [self.LeftDelegate selectLeftTableView:indexPath];
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
