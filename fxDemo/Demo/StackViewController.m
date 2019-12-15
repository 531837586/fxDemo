//
//  StackViewController.m
//  fxDemo
//
//  Created by 樊星 on 2019/5/27.
//  Copyright © 2019 樊星. All rights reserved.
//

#import "StackViewController.h"

@interface StackViewController ()

@end

@implementation StackViewController{
    
    NSArray *dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configData];
    [self configSubView];
}


-(void)configData{
    dataArray = @[@"UIStackView 是 iOS9 新增的一个布局技术。熟练掌握相当节省布局时间。UIStackView 是 UIView 的子类，是用来约束子控件的一个控件。但他的作用仅限于此，他不能被渲染（即用来呈现自身的内容），类似于 backgroundColor 等。这个控件只有4个属性：Axls: 子控件的布局方向，水平或者垂直；Alignment: 设置非轴方向子视图的对齐方式，类似于 UILabel 的 Alignment 属性；Distribution: 子控件的分布比例；Spacing: 控制子视图之间的间隔大小。",
                  
                  @"因为比较简单，属性具体不作详细解释。下面以实例形式展示 UIStackView 的用法。",
                  
                           @"因为比较简单，属性具体不作详细解释。下面以实例形式展示 UIStackView 的用法。因为比较简单，属性具体不作详细解释。下面以实例形式展示 UIStackView 的用法。因为比较简单，属性具体不作详细解释。下面以实例形式展示 UIStackView 的用法。因为比较简单，属性具体不作详细解释。下面以实例形式展示 UIStackView 的用法。"];
}

-(void)configSubView{
    

    
    UIStackView *containerView = [[UIStackView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1000)];
    containerView.axis = UILayoutConstraintAxisVertical;
    containerView.distribution = UIStackViewDistributionEqualSpacing;
    containerView.spacing = 10;
    containerView.alignment = UIStackViewAlignmentTop;
    
    long index = random();
    for (NSInteger i = index%3; i < dataArray.count; i++) {
        
        UILabel *textLabel = [UILabel new];
        textLabel.text = dataArray[i];
        [containerView addArrangedSubview:textLabel];
    }
    [self.view addSubview:containerView];
}

@end
