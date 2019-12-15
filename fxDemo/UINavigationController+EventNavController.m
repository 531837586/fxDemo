//
//  UINavigationController+EventNavController.m
//  fxDemo
//
//  Created by 樊星 on 2019/4/11.
//  Copyright © 2019 樊星. All rights reserved.
//

#import "UINavigationController+EventNavController.h"

@implementation UINavigationController (EventNavController)

//- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
//    
////    UINavigationController invo
//    NSLog(@"Invoke Category pushViewController");
////    [ViewController invokeOriginalMethod:self selector:_cmd];
//}
//
//
//+ (void)invokeOriginalMethod:(id)target selector:(SEL)selector {
//    // Get the class method list
//    uint count;
//    Method *list = class_copyMethodList([target class], &count);
//    
//    // Find and call original method .
//    for ( int i = count - 1 ; i >= 0; i--) {
//        Method method = list[i];
//        SEL name = method_getName(method);
//        IMP imp = method_getImplementation(method);
//        if (name == selector) {
//            ((void (*)(id, SEL))imp)(target, name);
//            break;
//        }
//    }
//    free(list);
//}
 
@end
