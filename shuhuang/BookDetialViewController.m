//
//  BookDetialViewController.m
//  shuhuang
//
//  Created by qianfeng on 15/12/30.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import "BookDetialViewController.h"
//#import <AFNetworking/AFNetworking.h>
@interface BookDetialViewController ()
@property (nonatomic, copy) AFHTTPRequestOperationManager *manager;
@property (nonatomic, copy) NSMutableDictionary *dic;
@end

@implementation BookDetialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self fetNetWork];
    
    
}


- (void)fetNetWork {
    _manager = [AFHTTPRequestOperationManager manager];
    
    [_manager.requestSerializer setValue:@"ZhuiShuShenQi/3.30.2" forHTTPHeaderField:@"User-Agent"];
    _manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSLog(@"url:%@",self.url);
    [_manager GET:self.url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        [self setInfoWith:dic];
        NSLog(@"%@",dic);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        
    }];
}
- (void)setInfoWith:(NSDictionary*)dic {
    _dic = [NSMutableDictionary dictionaryWithDictionary:dic];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, self.view.bounds.size.height/2, self.view.bounds.size.width, self.view.bounds.size.height/2)];
    label.text = _dic[@"longIntro"];
    label.textAlignment = YES;
    label.numberOfLines = 0;
    [self.view addSubview:label];
    
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
