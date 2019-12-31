//
//  KVOViewController.m
//  fxDemo
//
//  Created by 樊星 on 2019/12/18.
//  Copyright © 2019 樊星. All rights reserved.
//

#import "KVOViewController.h"
#import "KVOPerson.h"
#import "KVOStudent.h"
#import "NSObject+FXKVO.h"

@interface KVOViewController ()
@property (nonatomic, strong) KVOPerson *person;
@property (nonatomic, strong) KVOStudent *student;
@end

@implementation KVOViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.person = [KVOPerson new];
    self.student = [KVOStudent new];
//     self.student.dataArray = [NSMutableArray array];
//    [self.student addObserver:self forKeyPath:@"progress" options:NSKeyValueObservingOptionNew context:NULL];
//      [self.person addObserver:self forKeyPath:@"st" options:NSKeyValueObservingOptionNew context:NULL];
//     [self.student addObserver:self forKeyPath:@"dataArray" options:NSKeyValueObservingOptionNew context:NULL];
 
//    [self printClasses:[KVOStudent class]];
//    [self printClassAllMethod:[KVOStudent class]];
//    NSLog(@"----------");
//    [self printClassAllMethod:[KVOPerson class]];
//    NSLog(@"***************NSKVONotifying_KVOStudent****************");
//    [self printClasses:NSClassFromString(@"NSKVONotifying_KVOStudent")];
    
//    [self.student addObserver:self forKeyPath:@"age" options:NSKeyValueObservingOptionNew context:NULL];
//    [self.student addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionNew context:NULL];
    
//    [self.student fx_addObserver:self forKeyPath:@"name" options:FXKeyValueObservingOptionOld|FXKeyValueObservingOptionNew context:NULL];
    [self.student fx_addObserver:self forKeyPath:@"name" options:FXKeyValueObservingOptionOld|FXKeyValueObservingOptionNew context:NULL handBlock:^(NSObject * _Nonnull observer, NSString * _Nonnull keyPath, id  _Nonnull oldValue, id  _Nonnull newValue) {
        NSLog(@"实际情况 %@ -- %@", oldValue, newValue);
    }];
//    NSLog(@"*******进去了*******");
    
//    [self printClassAllMethod:NSClassFromString(@"NSKVONotifying_KVOStudent")];
//    [self printClasses:[KVOStudent class]];
//    NSLog(@"***************NSKVONotifying_KVOStudent****************");
//    [self printClasses:NSClassFromString(@"NSKVONotifying_KVOStudent")];
    
//    self.student.name = @"fanxing";
//      self.student->age = @"age";
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    self.student.name = @"person";
//    self.student.download += 1;
//    self.student.total += 10;
//    NSLog(@"点击了");
//    [[self.student mutableArrayValueForKey:@"dataArray"] addObject:@"hello"];
    self.student.name = @"fanxing";
    self.student->age = @"age";
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    NSLog(@"KVOViewController -------%@", change);
//    NSLog(@"下载进度:%d/%d", self.student.download,self.student.total);
}

- (void)dealloc {
    
    [self.student fx_removeObserver:self forKeyPath:@"name"];
}

#pragma mark - 遍历方法-ivar-property
- (void)printClassAllMethod:(Class)cls{
    unsigned int count = 0;
    Method *methodList = class_copyMethodList(cls, &count);
    for (int i = 0; i<count; i++) {
        Method method = methodList[i];
        SEL sel = method_getName(method);
        IMP imp = class_getMethodImplementation(cls, sel);
        NSLog(@"%@-%p",NSStringFromSelector(sel),imp);
    }
    free(methodList);
}

#pragma mark - 遍历类以及子类
- (void)printClasses:(Class)cls{
    
    /// 注册类的总数
    int count = objc_getClassList(NULL, 0);
    /// 创建一个数组， 其中包含给定对象
    NSMutableArray *mArray = [NSMutableArray arrayWithObject:cls];
    /// 获取所有已注册的类
    Class* classes = (Class*)malloc(sizeof(Class)*count);
    objc_getClassList(classes, count);
    for (int i = 0; i<count; i++) {
        if (cls == class_getSuperclass(classes[i])) {
            [mArray addObject:classes[i]];
        }
    }
    free(classes);
    NSLog(@"classes = %@", mArray);
}
@end
