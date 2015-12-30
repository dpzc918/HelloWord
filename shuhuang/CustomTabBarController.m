//
//  CustomTabBarController.m
//  shuhuang
//
//  Created by qianfeng on 15/12/29.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import "CustomTabBarController.h"

@interface CustomTabBarController ()

@end

@implementation CustomTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createTabBarController];
}
- (void)createTabBarController {
    NSArray *titlerNames = @[@"书架",@"分类",@"排行榜",@"搜索"];
    NSArray *viewControllerNames = @[@"BookShelfViewController",@"ClassifyViewController",@"ChartsViewController",@"SearchViewController"];
    NSMutableArray *controllers = [[NSMutableArray alloc]init];
    for (NSInteger i = 0; i<titlerNames.count; i++) {
        
        UIViewController *controller = [[NSClassFromString(viewControllerNames[i]) alloc]init];
        UITabBarItem *item = [[UITabBarItem alloc]initWithTitle:titlerNames[i] image:[UIImage imageNamed:@"rsm_icon_0"] selectedImage:nil];
        controller.tabBarItem = item;
        controller.view.backgroundColor = [UIColor whiteColor];
        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:controller];
        [nav.navigationBar setBarTintColor:[UIColor colorWithRed:0/255.0 green:122/255.0 blue:255/255.0 alpha:1.0]];
        controller.navigationItem.title = titlerNames[i];
        [controllers addObject:nav];
        
    }
    self.viewControllers = controllers;
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
