//
//  UnitTest.m
//  fxDemoTests
//
//  Created by 樊星 on 2020/2/11.
//  Copyright © 2020 樊星. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "UnitTestVC.h"

@interface UnitTest : XCTestCase
@property (nonatomic, strong) UnitTestVC *vc;
@end

@implementation UnitTest

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    self.vc = [[UnitTestVC alloc] init];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    self.vc = nil;
}

#pragma mark - 逻辑测试
- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    
    //given ====> 数据
    NSString *account =@"12";
    NSString *password =@"123456";

    //when ==> ceshi
    BOOL b = [self.vc login:account password:password];
    
    //then ===> 判断
    XCTAssertEqual(b, YES,@"登录成功");
        
    //ocmock
}

#pragma mark - 性能测试

- (void)testPerformanceExample2{
    
    [self measureMetrics:@[XCTPerformanceMetric_WallClockTime] automaticallyStartMeasuring:NO forBlock:^{
        
        [self startMeasuring];
        //只测试抱在这两个方法里面的性能
        [self.vc loadManyDatas]; //产品 0.003
        [self stopMeasuring];
        
    }];
    
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    
    [self measureBlock:^{
        [self.vc loadManyDatas];
    }];
}

#pragma mark - 异步测试

// hank cc james cooci gavin dean session kody kasey...
// 答疑 阿里 360  斗鱼
//直播 新技术
// 五星 天猫 维权    合同 : 法律   一年学卡:持续性学习  实物 ===>> 自己平台

- (void)testAcy{
    
    //given ==> 预期
    XCTestExpectation *exp = [self expectationWithDescription:@"this acy test my exp"];
    
    //when
    [self.vc requestData:^(id data) {
        
        XCTAssertNotNil(data);//逻辑测试  15
        
        [exp fulfill];//预期抛出点
    }];
    
    //then
    [self waitForExpectationsWithTimeout:5 handler:^(NSError * _Nullable error) {
       
        NSLog(@"%@",error);
    }];
    
}






@end
