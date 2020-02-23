//
//  HTTPCookieVC.m
//  fxDemo
//
//  Created by 樊星 on 2020/2/4.
//  Copyright © 2020 樊星. All rights reserved.
//

#import "HTTPCookieVC.h"

@interface HTTPCookieVC ()

@end

@implementation HTTPCookieVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)configData{
    self.menuDataArray = [NSMutableArray arrayWithObjects:
    @"TestWebViewController",
    @"WKViewController",
    nil];
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
