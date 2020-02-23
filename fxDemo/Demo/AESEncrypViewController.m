//
//  AESEncrypViewController.m
//  fxDemo
//
//  Created by 樊星 on 2019/6/24.
//  Copyright © 2019 樊星. All rights reserved.
//

#import "AESEncrypViewController.h"
#import "NSString+AES.h"

@interface AESEncrypViewController ()

@end

@implementation AESEncrypViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSString *phone = @"17742003179";
    
    NSString *aesStr = [phone aci_encryptWithAES];
    
//    NSString *resultStr = [aesStr aci_decryptWithAES];
}

@end
