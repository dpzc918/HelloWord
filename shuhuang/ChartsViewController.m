//
//  ChartsViewController.m
//  shuhuang
//
//  Created by qianfeng on 15/12/29.
//  Copyright © 2015年 qianfeng. All rights reserved.
//
//排行榜URL
#define URL_Charts @"http://api.zhuishushenqi.com/ranking/gender"
//排行榜点击cell详情书籍
#define URL_bookDetial @"http://api.zhuishushenqi.com/ranking/%@"


#import "ChartsViewController.h"
#import "ChartsDetialViewController.h"
#import <AFNetworking/AFNetworking.h>
@interface ChartsViewController () <UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,copy) UITableView *tableView;

@property (nonatomic,copy) AFHTTPRequestOperationManager *manager;
@property (nonatomic,copy) NSMutableArray *chartsArray;
@property (nonatomic,copy) NSMutableArray *femaleArray;
@property (nonatomic,copy) NSMutableArray *maleArray;
@property (nonatomic,copy) NSArray *sectionName;
@end

@implementation ChartsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _chartsArray = [NSMutableArray new];
    _femaleArray = [NSMutableArray new];
    _maleArray = [NSMutableArray new];
    _sectionName = @[@"男生",@"女生"];
    
    [self createTableView];
    [self fetNetWork];
    
}
- (void)fetNetWork {
    _manager = [AFHTTPRequestOperationManager manager];
    _manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [_manager GET:URL_Charts parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        _femaleArray = dic[@"female"];
        _maleArray = dic[@"male"];
        [_chartsArray addObject:_maleArray];
        [_chartsArray addObject:_femaleArray];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        
    }];
    
}
- (void)createTableView{
    
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self.view addSubview:_tableView];
    }
    
    
}
#pragma  mark -
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _sectionName.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_chartsArray[section] count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier=@"identifier";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    
    
    cell.textLabel.text = _chartsArray[indexPath.section][indexPath.row][@"title"];
    
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 20;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 20)];
    label.text = _sectionName[section];
    label.backgroundColor = [UIColor colorWithRed:0/255.0 green:122/255.0 blue:255/255.0 alpha:1.0];
    label.textAlignment = YES;
    
    return label;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *_id = _chartsArray[indexPath.section][indexPath.row][@"_id"];
    NSString *title = _chartsArray[indexPath.section][indexPath.row][@"title"];
    NSString *url = [NSString stringWithFormat:URL_bookDetial,_id];
    ChartsDetialViewController *detialVC = [[ChartsDetialViewController alloc]init];
    detialVC.url = url;
    detialVC.subtitle = title;
    [self presentViewController:detialVC animated:YES completion:nil];
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
