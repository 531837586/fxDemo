//
//  MemeoryOptimizeVC.m
//  fxDemo
//
//  Created by 樊星 on 2020/2/14.
//  Copyright © 2020 樊星. All rights reserved.
//

#import "MemeoryOptimizeVC.h"
#import "FXTank.h"

extern uintptr_t objc_debug_taggedpointer_obfuscator;

typedef void(^FXBlock)(void);

@interface MemeoryOptimizeVC () 
@property (nonatomic, strong) dispatch_queue_t  queue;
@property (nonatomic, copy) NSString *nameStr;

@property (nonatomic, copy) FXBlock block;
@end

@implementation MemeoryOptimizeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    int a = 10;
//    NSLog(@"%p", &a);
    
//    NSObject *obj = [NSObject new];
//    NSLog(@"%@ - %p", obj, &obj);
    
//    NSArray *array = [[NSArray alloc] init];
//    NSLog(@"%@-%p", array, &array);
//    NSInteger count = 0;
//    while (1) {
//        UILabel *label = [[UILabel alloc] init];
//        count += 1;
//        NSLog(@"--%ld", count);
//    }
    
//    [self targedPoint];
//    [self targedPointEncode];
//    [self testCrash];
//    [self testStrLengthDifferent];
//    [self testUnion];
//    [self positionCalculate];
//    [self testRetainCount];
    [self retainCircle];
}

- (void)retainCircle{
    self.nameStr = @"fanxing";
    __weak typeof(self) weakSelf = self;
    self.block = ^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
             NSLog(@"%@", weakSelf.nameStr);
        });
    };
    self.block();
}

- (void)dealloc{
//    [super dealloc];
    NSLog(@"%s", __func__);
}

- (void)testStruct{
    
}

- (void)testRetainCount{
    
//    FXTank *p = [[FXTank alloc] init];
//    NSLog(@"%lu", (unsigned long)[p retainCount]);
    
//    FXTank *p = [[FXTank alloc] init];
//    [p retain];
//    NSLog(@"%lu", (unsigned long)[p retainCount]);
    
//    FXTank *p = [[FXTank alloc] init];
//    [p retain];
//    NSLog(@"%lu", (unsigned long)[p retainCount]); //2
//    [p release];
//    NSLog(@"%lu", (unsigned long)[p retainCount]); //1
//    [p release];
//    NSLog(@"%lu", (unsigned long)[p retainCount]); //0
//    [p release];
//    NSLog(@"%lu", (unsigned long)[p retainCount]); //-1
}

- (void)positionCalculate{
    long num1 = 2;
    long num1new = num1 >> 1; //10 >> 1 = 1 ;
    NSLog(@"num1 = %ld", num1new);
    
    
    long num2 = 5;
    long num2new = num2 >> 1; //101 >> 1 = 10 ;
    NSLog(@"num2 = %ld", num2new);
    
}

- (void)testUnion{
    
    FXTank *tank = [[FXTank alloc] init];
//    [tank setBack:YES];
//    [tank setFront:NO];
//    NSLog(@"%d - %d", tank.isBack, tank.isFront);
    NSLog(@"%lu", class_getInstanceSize([tank class]));
}

- (void)testCrash{
    
    self.queue = dispatch_queue_create("com.fnxing.cn", DISPATCH_QUEUE_CONCURRENT);

    for (int i = 0; i<100000; i++) {
      dispatch_async(self.queue, ^{
          self.nameStr = [NSString stringWithFormat:@"ggk"];
      });
    }
    
    NSLog(@"下面这段代码会崩溃，上面的不会");
    
    for (int i = 0; i<100000; i++) {
         dispatch_async(self.queue, ^{
             self.nameStr = [NSString stringWithFormat:@"dsggkdashjksda"];
         });
    }
}

- (void)targedPoint{
    
    NSNumber *num1 = @(100);//  0x00011e22 ^ mask --
    NSNumber *num2 = @(200);//  0x00011e22 ^mask^mask
    NSLog(@"%@-%p,%@-%p",num1,&num1,num2,&num2);
}

- (void)testStrLengthDifferent{
    
    NSString *str1 = [NSString stringWithFormat:@"a"];
    NSString *str2 = [NSString stringWithFormat:@"ab"];
    NSString *str3 = [NSString stringWithFormat:@"abc"];
    NSString *str4 = [NSString stringWithFormat:@"abcd"];
    NSString *str5 = [NSString stringWithFormat:@"abcde"];
    NSString *str6 = [NSString stringWithFormat:@"abcdefghij"];
    
    NSLog(@"%@--%p-%@-0x%lx", object_getClass(str1), str1, str1, _objc_encodeTaggedPointer(str1));
    NSLog(@"%@--%p-%@-0x%lx", object_getClass(str2), str2, str2, _objc_encodeTaggedPointer(str2));
    NSLog(@"%@--%p-%@-0x%lx", object_getClass(str3), str3, str3, _objc_encodeTaggedPointer(str3));
    NSLog(@"%@--%p-%@-0x%lx", object_getClass(str4), str4, str4, _objc_encodeTaggedPointer(str4));
    NSLog(@"%@--%p-%@-0x%lx", object_getClass(str5), str5, str5, _objc_encodeTaggedPointer(str5));
    NSLog(@"%@--%p-%@-0x%lx", object_getClass(str6), str6, str6, _objc_encodeTaggedPointer(str6));
}

- (void)targedPointEncode{
    
    NSString *str1 = [NSString stringWithFormat:@"abc"];
    NSString *str2 = [NSString stringWithFormat:@"你"];
    
    NSLog(@"%@--%p-%@-0x%lx", object_getClass(str1), str1, str1, _objc_encodeTaggedPointer(str1));
    NSLog(@"%@--%p-%@-0x%lx", object_getClass(str2), str2, str2, _objc_encodeTaggedPointer(str2));
    
    NSLog(@"\n");
    
    int    num1 = 1;
    float  num2 = 2;
    long   num3 = 3;
    double num4 = 4;
    
    NSNumber *number1 = @(num1);
    NSNumber *number2 = @(num2);
    NSNumber *number3 = @(num3);
    NSNumber *number4 = @(num4);
    
    NSLog(@"%@--%p-%@-0x%lx", object_getClass(number1), number1, number1, _objc_encodeTaggedPointer(number1));
    NSLog(@"%@--%p-%@-0x%lx", object_getClass(number2), number2, number2, _objc_encodeTaggedPointer(number2));
    NSLog(@"%@--%p-%@-0x%lx", object_getClass(number3), number3, number3, _objc_encodeTaggedPointer(number3));
    NSLog(@"%@--%p-%@-0x%lx", object_getClass(number4), number4, number4, _objc_encodeTaggedPointer(number4));
}

uintptr_t _objc_encodeTaggedPointer(id ptr) {
    return  (objc_debug_taggedpointer_obfuscator ^ (uintptr_t)ptr);
}

- (void)didReceiveMemoryWarning{
    NSLog(@"***");
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
