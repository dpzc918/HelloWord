//
//  DetialViewController.m
//  shuhuang
//
//  Created by qianfeng on 15/12/30.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import "DetialViewController.h"

@interface DetialViewController ()
@property (nonatomic,copy) AFHTTPRequestOperationManager *manager;
@end

@implementation DetialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createNav];
   
   // [self fetNetWork];
}
- (void)fetNetWork {
    
}
- (void)createNav {
    
    UIView *subView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 64)];
    subView.backgroundColor = [UIColor colorWithRed:0/255.0 green:122/255.0 blue:255/255.0 alpha:1.0];
    
    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 180, 44)];
    title.center = CGPointMake(self.view.bounds.size.width/2, 42);
    title.text = _subtitle;
    
    [subView addSubview:title];
    
    
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 22, 50, 40)];
    [button setTitle:@"返回" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [subView addSubview:button];
    
    [self.view addSubview:subView];
    
    
}
- (void)back {
    
    [self dismissViewControllerAnimated:YES completion:nil];
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
