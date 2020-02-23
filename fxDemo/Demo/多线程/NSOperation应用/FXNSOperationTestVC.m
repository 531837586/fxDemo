//
//  FXNSOperationTestVC.m
//  fxDemo
//
//  Created by 樊星 on 2020/1/18.
//  Copyright © 2020 樊星. All rights reserved.
//

#import "FXNSOperationTestVC.h"
#import "FXViewModel.h"
#import "FXCollectionViewCell.h"
#import "NSString+KCAdd.h"
#import "UIImageView+KCWebCache.h"

static NSString *reuseID = @"reuseID";

@interface FXNSOperationTestVC ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView  *collectionView;
@property (nonatomic, strong) NSMutableArray    *dataArray;
@property (nonatomic, strong) FXViewModel       *viewModel;

//下载队列
@property (nonatomic, strong) NSOperationQueue *queue;
//缓存图片字典----可用数据库替换
@property (nonatomic, strong) NSMutableDictionary *imageCacheDict;
//缓存操作字典
@property (nonatomic, strong) NSMutableDictionary *operationDict;

@end

@implementation FXNSOperationTestVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.queue = [[NSOperationQueue alloc] init];
    //添加到视图
    [self.view addSubview:self.collectionView];
    __weak typeof(self) weakSelf = self;
    self.viewModel = [[FXViewModel alloc] initWithBlock:^(id data) {
        [weakSelf.dataArray addObjectsFromArray:(NSArray *)data];
        [weakSelf.collectionView reloadData];
    } fail:nil];
    
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    FXCollectionViewCell *cell  = [collectionView dequeueReusableCellWithReuseIdentifier:reuseID forIndexPath:indexPath];
    FXModel *model        = self.dataArray[indexPath.row];
    cell.titleLabel.text  = model.title;
    cell.moneyLabel.text  = model.money;
    
    [cell.imageView kc_setImageWithUrlString:model.imageUrl title:model.title indexPath:indexPath];
    
//    //内存缓存 -- 内存会被清理
//    UIImage *cacheImage = self.imageCacheDict[model.imageUrl];
//    if(cacheImage){
//        NSLog(@"从内存获取image:%@", model.title);
//        cell.imageView.image = cacheImage;
//        return cell;
//    }
//
//    //沙盒缓存
//    UIImage *diskImage = [UIImage imageWithContentsOfFile:[model.imageUrl getDowloadImagePath]];
//    if(diskImage){
//        NSLog(@"从沙盒获取image:%@", model.title);
//        cell.imageView.image = diskImage;
//        //存内存
//        [self.imageCacheDict setValue:diskImage  forKey:model.imageUrl];
//        return cell;
//    }
//
//    //这样的话model会越来越大，如果达到最大内存的时候需要清理model，就会吧所有model里面的东西都清楚。
////    if(model.image){
////        NSLog(@"从模型获取image:%@", model.title);
////        cell.imageView.image = model.image;
////        return cell;
////    }
//
//    NSBlockOperation *bo = [NSBlockOperation blockOperationWithBlock:^{
//
//        // 延迟
//        NSLog(@"去下载: %@", model.title);
//        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:model.imageUrl]];
//        [data writeToFile:[model.imageUrl getDowloadImagePath] atomically:YES];
//        UIImage *image = [UIImage imageWithData:data];
//
//        //存内存
//        [self.imageCacheDict setValue:image forKey:model.imageUrl];
//
//        //更新UI
//        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
//            cell.imageView.image = image;
////            model.image = image;
//        }];
//    }];
//
//    [self.queue addOperation:bo];
    
    return cell;
}

#pragma mark - lazy
- (UICollectionView *)collectionView{
    if (!_collectionView) {
        
        //创建一个流水布局
        UICollectionViewFlowLayout *layout  = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection              = UICollectionViewScrollDirectionVertical;
        layout.minimumInteritemSpacing      = 5;
        layout.minimumLineSpacing           = 5;
        layout.itemSize                     = CGSizeMake((SCREEN_WIDTH-15)/2.0, 260);
        
        //初始化collectionView
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(5, 0, SCREEN_WIDTH-10, SCREEN_HEIGHT) collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.scrollsToTop    = NO;
        _collectionView.pagingEnabled   = YES;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.bounces         = YES;
        _collectionView.dataSource      = self;
        _collectionView.delegate        = self;
        [_collectionView registerClass:[FXCollectionViewCell class] forCellWithReuseIdentifier:reuseID];
   
    }
    return _collectionView;
}

- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        // 解释一波关于数组 capacity 每次都是开辟10单位内存
        _dataArray = [NSMutableArray arrayWithCapacity:10];
    }
    return _dataArray;
}

- (NSMutableDictionary *)imageCacheDict{
    if (!_imageCacheDict) {
        _imageCacheDict = [NSMutableDictionary dictionaryWithCapacity:10];
    }
    return _imageCacheDict;
}

- (NSMutableDictionary *)operationDict{
    if (!_operationDict) {
        _operationDict = [NSMutableDictionary dictionaryWithCapacity:10];
    }
    return _operationDict;
}

- (void)didReceiveMemoryWarning{
    NSLog(@"收到内存警告,你要清理内存了!!!");
    [self.imageCacheDict removeAllObjects];
    //已经有内存警告就不能在执行操作
    [self.queue cancelAllOperations];
    //清空操作
    [self.operationDict removeAllObjects];
    
}

@end
