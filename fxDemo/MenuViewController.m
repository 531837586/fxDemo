//
//  ViewController.m
//  fxDemo
//
//  Created by 樊星 on 2019/3/6.
//  Copyright © 2019 樊星. All rights reserved.
//

#import "MenuViewController.h"
#import "FXReadLocalFile.h"

@interface MenuViewController ()
 
@end

@implementation MenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"fxDemo";
}

-(void)configData{
    
    self.menuDataArray = [NSMutableArray arrayWithObjects:
                          @"StrongReferenceVC",
                          @"RetainCircleVC",
                          @"MemeoryOptimizeVC",
                          @"UnitTestVC",
                          @"NetWorkVC",
                          @"FXNSOperationTestVC",
                          @"NSOperationVC",
                          @"DispatchSourceVC",
                          @"GCDViewController",
                          @"ThreadVC",
                          @"RunloopVC",
                          @"KVOViewController",
                          @"CategoryVC",
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
                          @"KVCViewController",
                          nil];
    
}

 
@end
