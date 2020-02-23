//
//  JSCoreVC.m
//  fxDemo
//
//  Created by 樊星 on 2020/2/2.
//  Copyright © 2020 樊星. All rights reserved.
//

#import "JSCoreVC.h"
#import "KC_JSObject.h"

@interface JSCoreVC ()<UIWebViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) UILabel *showLabel;
@property (nonatomic, strong) JSContext *jsContext;
@property (nonatomic,strong) UIImagePickerController *imagePicker;
@end

@implementation JSCoreVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, STATUS_AND_NAV_BAR_HEIGHT, self.view.bounds.size.width, self.view.bounds.size.height-STATUS_AND_NAV_BAR_HEIGHT)];
       self.webView.delegate        = self;
       [self.view addSubview:self.webView];
       
       NSURL *url = [[NSBundle mainBundle] URLForResource:@"index2.html" withExtension:nil];;
       NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
       [self.webView loadRequest:request];
       
       self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"点我" style:UIBarButtonItemStyleDone target:self action:@selector(didClickRightAction)];
}

- (void)didClickRightAction{
    NSLog(@"rightBarButtonItem");
    [self.jsContext evaluateScript:@"showAlert()"];
}

#pragma mark - UIWebViewDelegate
// 加载完成
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    
    NSString *titlt = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    self.title = titlt;
    
    //JSContext就为其提供着运行环境 H5上下文
    JSContext *jsContext = [self.webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    self.jsContext = jsContext;
//    oc调用js
    [jsContext evaluateScript:@"var arr = ['Hank','Cooci','Kody','CC']"];
    
//    jsContext[@"showMessage"] = ^{
//        NSLog(@"来了");
//    };
    
//    KC_JSObject *obj = [[KC_JSObject alloc] init];
//    jsContext evaluateScript:<#(NSString *)#>
    
    // 执行下面的业务逻辑
    [self setupJS];
}

- (void)setupJS{
    
        __weak typeof(self) weakSelf = self;
    
    // OC - swift -- 后台 - 前端
    // JS-OC - 闭包会封装 - 地址
    
//    如果js也有showMessage,不会调用js的方法，会调用Context的方法，覆盖了js的方法
    self.jsContext[@"showMessage"] = ^{
        NSLog(@"来了");
        // 参数 (JS 带过来的)
        NSArray *args = [JSContext currentArguments];
        NSLog(@"args = %@",args);
        NSLog(@"currentThis   = %@",[JSContext currentThis]);
        NSLog(@"currentCallee = %@",[JSContext currentCallee]);//闭包
        
        // OC-JS
        NSDictionary *dict = @{@"name":@"cooci",@"age":@18};
        //如果使用self.jsContext会循环引用，就使用[JSContext currentContext]
        [[JSContext currentContext][@"ocCalljs"] callWithArguments:@[dict,@"咸鱼"]];//调用JS方法，传OC对象

    };
    
    // 因为是全局变量 可以直接获取
     JSValue *arrValue = self.jsContext[@"arr"];
     NSLog(@"arrValue == %@",arrValue);

    //JS-OC
    self.jsContext[@"showDict"] = ^{
        NSLog(@"来了");
        // 参数 (JS 带过来的)
        NSArray *args = [JSContext currentArguments];
        JSValue *dictValue = args[0];
        NSDictionary *dict = dictValue.toDictionary;
        NSLog(@"%@",dict);
        NSLog(@"args = %@",args);
        
        // 模拟用
       int num = [[arrValue.toArray objectAtIndex:0] intValue];
       num += 10;
       NSLog(@"arrValue == %@   num == %d",arrValue.toArray,num);
       dispatch_async(dispatch_get_main_queue(), ^{
//           weakSelf.showLabel.text = dict[@"name"];主线程刷新UI
       });
    };
    

    //异常收集
    self.jsContext.exceptionHandler = ^(JSContext *context, JSValue *exception) {
        weakSelf.jsContext.exception = exception;
       NSLog(@"exception == %@",exception);
    };
        
    // JS 操作对象
    KC_JSObject *kcObject = [[KC_JSObject alloc] init];
    self.jsContext[@"kcObject"] = kcObject;
    NSLog(@"kcObject == %d",[kcObject getSum:20 num2:40]);
    
    // 打开相册
    self.jsContext[@"getImage"] = ^() {
        dispatch_async(dispatch_get_main_queue(), ^{
            weakSelf.imagePicker = [[UIImagePickerController alloc] init];
            weakSelf.imagePicker.delegate = weakSelf;
            weakSelf.imagePicker.allowsEditing = YES;
            weakSelf.imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            [weakSelf presentViewController:weakSelf.imagePicker animated:YES completion:nil];
        });
    };
    
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
