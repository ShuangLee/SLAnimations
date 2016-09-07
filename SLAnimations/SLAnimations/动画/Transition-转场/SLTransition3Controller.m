//
//  SLTransition3Controller.m
//  SLAnimations
//
//  Created by 光头强 on 16/9/7.
//  Copyright © 2016年 Ls. All rights reserved.
//

#import "SLTransition3Controller.h"

@interface SLTransition3Controller ()
@property (strong, nonatomic) UIView *subView1;
@property (strong, nonatomic) UIView *subView2;
@end

@implementation SLTransition3Controller

/*
 双视图转场时，转出视图的父视图会被释放
 
 强烈建议使用但视图转场，如果单视图转场无法满足需求，通常可以考虑视图控制器的切换
 */
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIView *view2 = [[UIView alloc]initWithFrame:self.view.bounds];
    [view2 setBackgroundColor:[UIColor blueColor]];
    self.subView2 = view2;
    
    UIView *view1 = [[UIView alloc]initWithFrame:self.view.bounds];
    [view1 setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:view1];
    self.subView1 = view1;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    // 在双视图转场时，我们可以根据是否有父视图，来判断谁进谁出
    UIView *fromView = nil;
    UIView *toView = nil;
    
    if (self.subView1.superview == nil) {
        // 说明subView1要转入
        toView = self.subView1;
        fromView = self.subView2;
    } else {
        // 说明subView2要转入
        toView = self.subView2;
        fromView = self.subView1;
    }
    
    [UIView transitionFromView:fromView toView:toView duration:1.0f options:UIViewAnimationOptionTransitionFlipFromTop completion:^(BOOL finished) {
        
        NSLog(@"转场完成");
        // 每次转场后，会调整参与转场视图的父视图，因此，参与转场视图的属性，需要是强引用
        // 转场之后，入场的视图会有两个强引用，一个是视图控制器，另一个是视图
        NSLog(@"sub view 1 %@", self.subView1.superview);
        NSLog(@"sub view 2 %@", self.subView2.superview);
    }];
}

@end
