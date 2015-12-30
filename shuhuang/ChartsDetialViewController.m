//
//  ChartsDetialViewController.m
//  shuhuang
//
//  Created by qianfeng on 15/12/30.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#define URL_bookInfo @"http://api.zhuishushenqi.com/book/%@"

#import "ChartsDetialViewController.h"
#import "ChartsViewController.h"
#import "BookDetialViewController.h"
#import <AFNetworking/AFNetworking.h>
@interface ChartsDetialViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, copy) NSMutableDictionary *dic;
@property (nonatomic, copy) UITableView *tableView;
@property (nonatomic, copy) NSMutableArray *dataArray;
@property (nonatomic, copy) AFHTTPRequestOperationManager *manager;
@end

@implementation ChartsDetialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _dataArray = [[NSMutableArray alloc]init];
    [self createNav];
    [self fetNetWork];
    [self createTableView];
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

- (void)createTableView{
    
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height - 64)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self.view addSubview:_tableView];
    }
    
    
}
- (void)fetNetWork {
    _manager = [AFHTTPRequestOperationManager manager];
    _manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [_manager GET:_url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        _dic = dic[@"ranking"];
        _dataArray = _dic[@"books"];
        //NSLog(@"%@",_dataArray);
        [_tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        
    }];
}
#define mark -
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier=@"identifier";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    
    
    _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    
    cell.textLabel.text = _dataArray[indexPath.row][@"title"];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    BookDetialViewController *bookVC = [[BookDetialViewController alloc]init];
    NSString *_id  = _dataArray[indexPath.row][@"_id"];
    

    bookVC.url = [NSString stringWithFormat:URL_bookInfo,_id];
  
    NSLog(@"%@",bookVC.url);
    [self presentViewController:bookVC animated:YES completion:nil];
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
