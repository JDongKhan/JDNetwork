//
//  ViewController.m
//  JDNetwork
//
//  Created by 王金东 on 2017/7/20.
//  Copyright © 2017年 王金东. All rights reserved.
//

#import "ViewController.h"
#import "JDNetWork.h"
#import "FirstRequest.h"

#import "UIView+hs_network.h"

@interface ViewController ()
- (IBAction)requestAction:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)requestAction4:(UIButton *)sender {
        sender.jd_request(BaseRequest.class)
        .jd_param(@"username",@"wjd")
        .jd_send();
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)requestAction2:(id)sender {
    //因为url配置过了 我就不配置了
    FirstRequest.jd_request().jd_send();
}

- (IBAction)requestAction1:(id)sender {
    JDRequest.jd_request().jd_param(@"username",@"wjd").jd_url(@"www.baidu.com").jd_send();
}
- (IBAction)requestAction3:(id)sender {
    FirstRequest *fq = [[FirstRequest alloc] init];
    fq.userName = @"wjd";
    fq.sex = @"1";
    fq.jd_method(@"POST").jd_send();
}

- (IBAction)requestAction:(id)sender {
    FirstRequest *fq = [[FirstRequest alloc] init];
    fq.userName = @"wjd";
    fq.sex = @"1";
    [fq sendRequest];
    
}
@end
