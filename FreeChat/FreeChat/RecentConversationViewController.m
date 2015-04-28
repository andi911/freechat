//
//  FirstViewController.m
//  FreeChat
//
//  Created by Feng Junwen on 2/3/15.
//  Copyright (c) 2015 Feng Junwen. All rights reserved.
//

#import "RecentConversationViewController.h"
#import "ConversationStore.h"
#import "ChatViewController.h"
#import "ConversationUtils.h"

NSString * kConversationCellIdentifier = @"ConversationIdentifier";

@interface RecentConversationViewController () {
    UITableView *_tableView;
    NSMutableArray *_recentConversations;
}

@end

@implementation RecentConversationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    CGSize frameSize = self.view.frame.size;
    CGSize navSize = self.navigationController.navigationBar.frame.size;
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, navSize.height + 24, frameSize.width, frameSize.height - navSize.height) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kConversationCellIdentifier];
    [self.view addSubview:_tableView];
    _recentConversations = [[NSMutableArray alloc] initWithCapacity:20];
    ConversationStore *store = [ConversationStore sharedInstance];
    [store addEventObserver:self forConversation:@"*"];
    [self loadFootView];
    [self baseInformation];
//    [self loadSegmentController];
    
}

- (void) loadSegmentController{
    NSArray *segmentedData = [[NSArray alloc]initWithObjects:NSLocalizedString(@"Message", nil),NSLocalizedString(@"Phone", nil), nil];
    UISegmentedControl *segmentedControl = [[UISegmentedControl alloc]initWithItems:segmentedData];
    segmentedControl.tintColor = [UIColor colorWithWhite:0.94 alpha:1];
    segmentedControl.selectedSegmentIndex = 0;//默认选中的按钮索引
    /*下面的代码实同正常状态和按下状态的属性控制,比如字体的大小和颜色等*/
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:12],NSFontAttributeName,[UIColor whiteColor], NSForegroundColorAttributeName,nil];
    
    [segmentedControl setTitleTextAttributes:attributes forState:UIControlStateNormal];
    
    NSDictionary *highlightedAttributes = [NSDictionary dictionaryWithObject:[UIColor colorWithRed:27/255.0f green:166/255.0f blue:225/255.0f alpha:1] forKey:NSForegroundColorAttributeName];
    
    [segmentedControl setTitleTextAttributes:highlightedAttributes forState:UIControlStateHighlighted];
    
    //设置分段控件点击相应事件
    [segmentedControl addTarget:self action:@selector(doSomethingInSegment:)forControlEvents:UIControlEventValueChanged];
    self.navigationItem.titleView = segmentedControl;
}

- (void)doSomethingInSegment:(id)sender {
    NSLog(@"do some thing");
}

- (void)baseInformation {
    if ([_tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        
        [_tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([_tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        
        [_tableView setLayoutMargins:UIEdgeInsetsZero];
    }
}

- (void)loadFootView {
    UILabel *label = [[UILabel alloc]init];
    _tableView.tableFooterView = label;
}

-(void)viewDidUnload{
    [super viewDidUnload];
    ConversationStore *store = [ConversationStore sharedInstance];
    [store removeEventObserver:self forConversation:@"*"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    ConversationStore *store = [ConversationStore sharedInstance];
    NSArray *recentConvs = [store recentConversations];
    [_recentConversations removeAllObjects];
    [_recentConversations addObjectsFromArray:recentConvs];
    [_tableView reloadData];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}

#pragma UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_recentConversations count];
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([indexPath row] >= [_recentConversations count]) {
        return nil;
    }
    AVIMConversation *conv = [_recentConversations objectAtIndex:[indexPath row]];
    UITableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:kConversationCellIdentifier
                                                             forIndexPath:indexPath];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kConversationCellIdentifier];
    }
    NSArray *members = conv.members;
    if ([conv.name length] > 0) {
        [cell.textLabel setText:conv.name];
    } else {
        NSString *displayName = [ConversationUtils getConversationDisplayname:conv];
        if (members.count < 3) {
            [cell.textLabel setText:displayName];
        } else {
            [cell.textLabel setText:[NSString stringWithFormat:@"%@ 等%d人", displayName, members.count]];
        }
        
    }
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}



#pragma UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    AVIMConversation *conv = [_recentConversations objectAtIndex:[indexPath row]];
    ChatViewController *chatViewController = [[ChatViewController alloc] init];
    chatViewController.conversation = conv;
    [self.navigationController pushViewController:chatViewController animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44.0f;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    
}

#pragma IMEventObserver
- (void)newMessageArrived:(Message*)message conversation:(AVIMConversation*)conversation {
    ConversationStore *store = [ConversationStore sharedInstance];
    if(message.eventType == EventKicked) {
        [store quitConversation:conversation];
    }
    NSArray *recentConvs = [store recentConversations];
    [_recentConversations removeAllObjects];
    [_recentConversations addObjectsFromArray:recentConvs];
    [_tableView reloadData];
}

- (void)messageDelivered:(Message*)message conversation:(AVIMConversation*)conversation {
    ;
}

@end
