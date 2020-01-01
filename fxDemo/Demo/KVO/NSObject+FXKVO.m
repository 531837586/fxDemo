//
//  NSObject+FXKVO.m
//  fxDemo
//
//  Created by 樊星 on 2019/12/21.
//  Copyright © 2019 樊星. All rights reserved.
//

#import "NSObject+FXKVO.h"
#import <objc/message.h>
 

static NSString *const FXKVOPrefix = @"FXKVONotifying_";
static NSString *const FXKVOAssiociateKey = @"FXKVO_AssiociateKey";

@implementation NSObject (FXKVO)
//- (void)fx_addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(FXKeyValueObservingOptions)options context:(nullable void *)context{
//    //1. 验证set方法
//    [self judgeSetterMethodFromKeyPath:keyPath];
//    //2. 动态生成子类
//    Class newClass = [self creatChildClass:keyPath];
//    //3. 当前对象的类，isa指向newClass
//    object_setClass(self, newClass);
//    //4. 保存KVO信息
//    //集合 --> add map
//    FXKVOInfo *info = [[FXKVOInfo alloc] initWithObserver:observer forKeyPath:keyPath options:options];
//    NSMutableArray *infoArray = objc_getAssociatedObject(self, (__bridge const void * _Nonnull)(FXKVOAssiociateKey));
//    if(!infoArray) {
//      //数组 -> 成员 强引用
//        //self(vc) -> person ISA -> 数组 -> info -/weak/-> self(VC) ?
//        //self.person -> FXKVO -> //内存问题，这里为什么没有形成循环引用？
//        infoArray = [NSMutableArray arrayWithCapacity:1];
//        objc_setAssociatedObject(self, (__bridge const void * _Nonnull)(FXKVOAssiociateKey), infoArray, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
//    }
//    [infoArray addObject:info];
//}

- (void)fx_addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(FXKeyValueObservingOptions)options context:(nullable void *)context handBlock:(FXKVOBlock)handBlock{
    //1. 验证set方法
        [self judgeSetterMethodFromKeyPath:keyPath];
        //2. 动态生成子类
        Class newClass = [self creatChildClass:keyPath];
        //3. 当前对象的类，isa指向newClass
        object_setClass(self, newClass);
        //4. 保存KVO信息
        //集合 --> add map
        FXKVOInfo *info = [[FXKVOInfo alloc] initWithObserver:observer forKeyPath:keyPath options:options handBlock:handBlock];
        NSMutableArray *infoArray = objc_getAssociatedObject(self, (__bridge const void * _Nonnull)(FXKVOAssiociateKey));
        if(!infoArray) {
          //数组 -> 成员 强引用
            //self(vc) -> person ISA -> 数组 -> info -/weak/-> self(VC) ?
            //self.person -> FXKVO -> //内存问题，这里为什么没有形成循环引用？
            infoArray = [NSMutableArray arrayWithCapacity:1];
            objc_setAssociatedObject(self, (__bridge const void * _Nonnull)(FXKVOAssiociateKey), infoArray, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }
        [infoArray addObject:info];
    
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        Method m1 = class_getInstanceMethod([self class], NSSelectorFromString(@"dealloc"));
//        Method m2 = class_getInstanceMethod([self class], @selector(fx_dealloc));
//        method_exchangeImplementations(m1, m2);
//    });
}

//- (void)fx_observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
//    
//}

//- (void)fx_removeObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath{
//    
//    NSMutableArray *infoArray = objc_getAssociatedObject(self, (__bridge const void * _Nonnull)(FXKVOAssiociateKey));
//    [infoArray enumerateObjectsUsingBlock:^(FXKVOInfo *info, NSUInteger idx, BOOL * _Nonnull stop) {
//        if([info.keyPath isEqualToString:keyPath]
//           &&(observer == info.observer)) {
//            [infoArray removeObject:info];
//            *stop = YES;
//        }
//    }];
//    //如果关联数组没有KVO信息->清空
//    if(infoArray.count == 0){
//        objc_removeAssociatedObjects(infoArray);
//    }
//    //指回父类
//    Class superClass = [self class];//KVOStudent
//    object_setClass(self, superClass);
//}

//- (void)fx_dealloc {
//
//    [self fx_dealloc];
//
//    Class superClass = [self class];//KVOStudent
//    object_setClass(self, superClass);
//}

//- (void)dealloc{
//    //指回父类
//    Class superClass = [self class];//KVOStudent
//    object_setClass(self, superClass);
//}

#pragma mark - 动态生成子类
- (Class)creatChildClass:(NSString *)keyPath{
 // LGKVO_LGPerson
    
    // 2. 动态生成子类
     
    NSString *oldName = NSStringFromClass([self class]);
    NSString *newName = [NSString stringWithFormat:@"%@%@", FXKVOPrefix, oldName];
    Class newClass    = objc_allocateClassPair([self class], newName.UTF8String, 0);
    
    if(newClass) return newClass;
    
    newClass = objc_allocateClassPair([self class], newName.UTF8String, 0);
    
    //申请注册到内存中
    objc_registerClassPair(newClass);
    
    // 2.1 子类添加一些方法 class setter
    // class
    SEL classSEL = NSSelectorFromString(@"class");
    Method classM = class_getInstanceMethod([self class], classSEL);
    const char *type = method_getTypeEncoding(classM);
    class_addMethod(newClass, classSEL, (IMP)fx_class, type);
    
    // setter
    SEL setterSEL = NSSelectorFromString(setterForGetter(keyPath));
    Method setterM = class_getInstanceMethod([self class], setterSEL);
    const char *settertype = method_getTypeEncoding(setterM);
    class_addMethod(newClass, setterSEL, (IMP)fx_setter, settertype);
    
    // 添加dealloc -- 为什么系统给KVO添加dealloc
    SEL deallocSEL = NSSelectorFromString(@"dealloc");
    Method deallocM = class_getInstanceMethod([self class], deallocSEL);
    const char *deallocType = method_getTypeEncoding(deallocM);
    class_addMethod(newClass, setterSEL, (IMP)fx_dealloc, deallocType);
    
    return newClass;
}

static void fx_dealloc(id self, SEL _cmd, id newValue){
    Class superClass = [self class];//KVOStudent
    object_setClass(self, superClass);
}

#pragma mark - 函数部分

static void fx_setter(id self, SEL _cmd, id newValue) {

    NSString *keyPath = getterForSetter(NSStringFromSelector(_cmd));
    id oldValue = [self valueForKey:keyPath];
    // 消息发送 setName:
//    [self willChangeValueForKey:keyPath];

    // newValue给谁， newClass KVOPerson
    // 给父类发送消息
    void (*fx_msgSendSuper)(void *,SEL , id) = (void *)objc_msgSendSuper;
    struct objc_super fx_objc_super = {
        .receiver = self,
        .super_class = [self class],
    };
    fx_msgSendSuper(&fx_objc_super, _cmd,newValue);

//    objc_msgSendSuper(nil, _cmd, newValue);

    [self didChangeValueForKey:keyPath];

    //响应回调 -- KVOVC（观察者） --调用某个方法 -- obbser
    //把观察者存起来,先用属性存起来（关联存储）
//    id observer = objc_getAssociatedObject(self, (__bridge const void * _Nonnull)(FXKVOAssiociateKey));
    //响应
    //sel
    NSMutableArray *infoArray = objc_getAssociatedObject(self, (__bridge const void * _Nonnull)(FXKVOAssiociateKey));
    for (FXKVOInfo *info in infoArray) {
        if([info.keyPath isEqualToString:keyPath]){
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
                //枚举--新值+旧值
                NSMutableDictionary<NSKeyValueChangeKey,id> *change = [NSMutableDictionary dictionaryWithCapacity:1];
                //新值 0x0001 代表新值
                // &0x0001, 如果都相同则为1
                if (info.options & FXKeyValueObservingOptionNew) {
                    [change setObject:newValue?:@"" forKey:NSKeyValueChangeNewKey];
                }
                if (info.options & FXKeyValueObservingOptionOld) {
                    [change setObject:oldValue?:@"" forKey:NSKeyValueChangeOldKey];
                }
                if(info.handBlock) {
                    info.handBlock(info.observer, keyPath, oldValue, newValue);
                }
//                SEL obserSEL = @selector(observeValueForKeyPath:ofObject:change:context:);
//                ((id (*)(id, SEL, id, id, id, id))objc_msgSend)(info.observer, obserSEL, keyPath, self, change, NULL);
            });
        }
    }
    
    
//    SEL obserSEL = @selector(observeValueForKeyPath:ofObject:change:context:);
//    ((id (*)(id, SEL, id, id, id, id))objc_msgSend)(observer, obserSEL, keyPath,self,@{keyPath:newValue},NULL);
//    objc_msgSend(observer,obserSEL,keyPath,@{keyPath:newValue},NULL);
}

Class fx_class(id self,SEL _cmd){
    return class_getSuperclass(object_getClass(self));
}

#pragma mark - 从get方法获取set方法的名称 key ===>>> setKey:
static NSString *setterForGetter(NSString *getter){
    
    if (getter.length <= 0) { return nil;}
    
    NSString *firstString = [[getter substringToIndex:1] uppercaseString];
    NSString *leaveString = [getter substringFromIndex:1];
    
    return [NSString stringWithFormat:@"set%@%@:",firstString,leaveString];
}

#pragma mark - 验证是否存在setter方法
- (void)judgeSetterMethodFromKeyPath:(NSString *)keyPath{
    Class superclass = object_getClass(self);
    SEL setterSelector = NSSelectorFromString(setterForGetter(keyPath));
    Method setterMethod = class_getInstanceMethod(superclass, setterSelector);
    if(!setterMethod) {
        @throw [NSException exceptionWithName:NSInvalidArgumentException reason:[NSString stringWithFormat:@"老铁没有当前%@的setter", keyPath] userInfo:nil];
    }
}

#pragma mark - 从set方法获取getter方法的名称 set<Key>:===> key
static NSString *getterForSetter(NSString *setter){
    
    if (setter.length <= 0 || ![setter hasPrefix:@"set"] || ![setter hasSuffix:@":"]) { return nil;}
    
    NSRange range = NSMakeRange(3, setter.length-4);
    NSString *getter = [setter substringWithRange:range];
    NSString *firstString = [[getter substringToIndex:1] lowercaseString];
    return  [getter stringByReplacingCharactersInRange:NSMakeRange(0, 1) withString:firstString];
}

@end
