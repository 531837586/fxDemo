//
//  ViewController.m
//  fxDemo
//
//  Created by 樊星 on 2019/3/6.
//  Copyright © 2019 樊星. All rights reserved.
//

#import "MenuViewController.h"
#import "FXReadLocalFile.h"
//#import "StackViewController.h"
//#import <GrowingCoreKit/GrowingCoreKit.h>

@interface MenuViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation MenuViewController

-(NSMutableArray *)dataArray{
    if(!_dataArray){
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

-(UITableView *)tableView{
    if(!_tableView){
        _tableView = [UITableView new];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.frame = self.view.frame;
//        _tableView.separatorInset = UIEdgeInsetsZero;
        _tableView.separatorColor = RGB(237, 237, 237);
        _tableView.tableFooterView = [UIView new];
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"fxDemo";
    [self configData];
    [self configSubView];
}

-(void)configSubView{
    
    [self.view addSubview:self.tableView];
}

-(void)configData{
    
    self.dataArray = [NSMutableArray arrayWithObjects:
                      @"FXShadowVC",
                      @"UIStackViewController",
                      @"UICallerViewController",
                      @"StackViewController",
                      @"ImageViewController",
                      @"QueueViewController",
                      @"RACViewController",
                      @"RACLoginViewController",
                      @"AESEncrypViewController",
                      @"DisfileViewController",
                      @"DictionaryVC",
                      @"AnimationImageVC",
                      @"GetChannelVC",
                      @"GCDViewController",
                      @"KVCViewController",
                      nil];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellID=@"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if(!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
//    cell.grow = [NSString stringWithFormat:@"indexPath_%ld", indexPath.row];
    NSString *value = [NSString stringWithFormat:@"%ld", indexPath.row];
//    [Growing setPeopleVariable:@{@"indexPath":value}];
    cell.imageView.image = [UIImage imageNamed:@"white_image"];
//        cell.imageView.image = [UIImage imageNamed:@"black_boll"];
    cell.textLabel.text = self.dataArray[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.row < self.dataArray.count){
        NSString *name = [self.dataArray objectAtIndex:indexPath.row];
        Class class = NSClassFromString(name);
        BaseViewController *vc = [[class alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}
@end
