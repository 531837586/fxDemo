//
//  KVCViewController.m
//  fxDemo
//
//  Created by 樊星 on 2019/12/11.
//  Copyright © 2019 樊星. All rights reserved.
//

#import "KVCViewController.h"
#import "Person.h"
#import "NSObject+FXKVC.h"

//KVC官方文档
//https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/KeyValueCoding/index.html#//apple_ref/doc/uid/10000107i
//Key-value coding is a mechanism enabled by the NSKeyValueCoding informal protocol that objects adopt to provide indirect access to their properties.
//翻译：KVC是一种对象提供的机制，可以间接的通过NSKeyValueCoding协议便捷访问属性。

//需要理解的内容：
//iOS 成员变量，实例变量，属性变量的区别：
//全部为成员变量
//实例变量是一宗特殊的成员变量
@interface KVCViewController (){
    @public
    NSString *myName; //成员
    UIButton *btn; //实例变量
    id hell; //id 是一种特殊的 class 所以也是实例变量
}
//属性 -- 会生成默认的setter + getter
//GCC -> LLVM(编译器升级)
//LLVM为没有匹配的实例变量属性，自动创建一个带下划线的成员变量
//@sythesie namep = _namep; //自动生成setter getter
@property (nonatomic, copy) NSString *namep;
@end

@implementation KVCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    Person *p = [Person new];

    
    [p setValue:[NSMutableArray arrayWithObjects:@"1", nil] forKey:@"array"];
 
//    [p fx_setValue:@"jack" forKey:@"name"];
    
    //valueForKey查找流程
    //查找调用顺序 get<Key>, <key>, is<Key>, or _<key>
//    NSLog(@"%@",[p valueForKey:@"name"]);
    
//     NSLog(@"%@",[p mutableArrayValueForKey:@"array"]);
     NSLog(@"%@",[p valueForKey:@"fxArray"]);
//    [p setValue:@"" forKey:@"array"];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    [self.view setValue:[UIColor grayColor] forKeyPath:@"backgroundColor"];
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
