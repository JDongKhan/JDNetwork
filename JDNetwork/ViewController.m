//
//  ViewController.m
//  JDNetwork
//
//  Created by 王金东 on 2017/7/20.
//  Copyright © 2017年 王金东. All rights reserved.
//

#import "ViewController.h"
#import "JDNetwork.h"
#import "JDNetwork+myproject.h"

@interface ViewController ()

- (IBAction)requestAction:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)requestAction4:(UIButton *)sender {
    [JDNetwork userService]
    .get(@"user/1.htm")
    .parametersForKey(@"username",@"wjd")
    .execute();
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)requestAction2:(id)sender {
    //因为url配置过了 我就不配置了
    JDNetwork
    .get(@"https://www.baidu.com")
    .responseEncoding(JDNetworkResponseXMLParserEncoding)
    .successResponse(^(id  _Nonnull result) {
        NSLog(@"%@",result);
    }).errorResponse(^(NSError * _Nonnull error) {
        NSLog(@"%@",error.description);
    }).execute();
}

- (IBAction)requestAction1:(id)sender {
    JDNetwork.post(@"").parametersForKey(@"username",@"wjd").execute();
}

- (IBAction)requestAction3:(id)sender {

}

- (IBAction)requestAction:(id)sender {
    
}
@end
