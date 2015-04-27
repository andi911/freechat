//
//  LoginViewController.m
//  FreeChat
//
//  Created by Feng Junwen on 2/3/15.
//  Copyright (c) 2015 Feng Junwen. All rights reserved.
//

#import "LoginViewController.h"
#import "AVOSCloud/AVOSCloud.h"
#import "AVOSCloudIM/AVOSCloudIM.h"
#import "MainViewController.h"
#import "ConversationStore.h"

@interface LoginViewController () {
    UITextField *_username;
    UITextField *_password;
}

@end



@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    
    if ([AVUser currentUser] != nil) {
        [self pushToMainViewController];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)pushToMainViewController {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    MainViewController *mainView = [storyboard instantiateViewControllerWithIdentifier:@"MainViewIdentifier"];

    AVUser* currentUser = [AVUser currentUser];
    AVIMClient *imClient = [[AVIMClient alloc] init];
    imClient.delegate = mainView;
    NSLog(@"open AVIMClient");
    [imClient openWithClientId:[currentUser objectId] callback:^(BOOL succeeded, NSError *error){
        if (error) {
            UIAlertView *view = [[UIAlertView alloc] initWithTitle:@"聊天不可用！" message:[error description] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [view show];
        } else {
            ConversationStore *store = [ConversationStore sharedInstance];
            store.imClient = imClient;
            [store reviveFromLocal:currentUser];
            [self.navigationController pushViewController:mainView animated:YES];
        }
    }];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    UIView *view = (UIView *)[touch view];
    if (self.view == view) {
        [self dismissKeyboard];
    }
}

- (void)dismissKeyboard
{
    NSArray *subviews = [self.view subviews];
    for (id objInput in subviews)
    {
        if ([objInput isKindOfClass:[UITextField class]])
        {
            UITextField *theTextField = objInput;
            if ([objInput isFirstResponder])
            {
                [theTextField resignFirstResponder];
            }
        }
    }
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)loginAction:(id)sender {
    [AVUser logInWithUsernameInBackground:_userName.text
                                 password:_userCode.text
                                    block:^(AVUser *user, NSError *error){
                                        if (error) {
                                            UIAlertView *view = [[UIAlertView alloc] initWithTitle:@"Error" message:[error description] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                                            [view show];
                                        } else {
                                            [self pushToMainViewController];
                                        }
                                    }];
    
}

- (IBAction)registerAction:(id)sender {
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *signupView = [storyboard instantiateViewControllerWithIdentifier:@"SignupViewIdentifier"];
    [self.navigationController pushViewController:signupView animated:YES];
}
@end
