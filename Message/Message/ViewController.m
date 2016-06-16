//
//  ViewController.m
//  Message
//
//  Created by 李根 on 16/6/16.
//  Copyright © 2016年 ligen. All rights reserved.
//

#import "ViewController.h"
#import <MessageUI/MessageUI.h>

@interface ViewController ()<MFMessageComposeViewControllerDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:btn];
    btn.frame = CGRectMake(100, 100, 100, 50);
    btn.backgroundColor = [UIColor purpleColor];
    [btn setTitle:@"send message!" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(sendMessage:) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)sendMessage:(id)sender {
    Class messageClass = (NSClassFromString(@"MFMessageComposeViewController"));
    
    if (messageClass != nil) {
        //  check wheather the current device is configurd for sending SMS Messages
        if ([messageClass canSendText]) {
            [self displaySMSComposeMessage];
        }
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Your device don't support SMS function!" message:nil delegate:self cancelButtonTitle:@"YES" otherButtonTitles:nil, nil];
        [alert show];
    }
    
    
}

- (void)displaySMSComposeMessage {
    MFMessageComposeViewController *messageController = [[MFMessageComposeViewController alloc] init];
    messageController.messageComposeDelegate = self;
    NSString *smsBody = [NSString stringWithFormat:@"I am you!"];
    messageController.body = smsBody;
    [self presentViewController:messageController animated:YES completion:nil];
}

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result {
    [self dismissViewControllerAnimated:YES completion:nil];
    NSLog(@"%d", result);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
