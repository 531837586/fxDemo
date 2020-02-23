//
//  UnitTestVC.m
//  fxDemo
//
//  Created by 樊星 on 2020/2/11.
//  Copyright © 2020 樊星. All rights reserved.
//

#import "UnitTestVC.h"

@interface UnitTestVC ()

@end

@implementation UnitTestVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self requestData:^(id data) {
         
          //更新UI
      }];
}

- (BOOL)login:(NSString *)account password:(NSString *)password{
    
    if ([account isEqualToString:@"Cooci"]) {
        
        return YES;
    }

    return NO;
}


- (void)loadManyDatas{
    
    for (int i = 0; i<200; i++) {
        NSLog(@"i am test performance");
    }
}

- (void)requestData:(void(^)(id data))dataBlock{
    
    //模拟数据
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
       
        NSString *str = @"I am Cooci";
        
        [NSThread sleepForTimeInterval:6];
        
        dispatch_async(dispatch_get_main_queue(), ^{
           
            dataBlock(str);
        });
        
    });
    
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
