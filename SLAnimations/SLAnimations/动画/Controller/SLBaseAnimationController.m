//
//  SLBaseAnimationController.m
//  SLAnimations
//
//  Created by 光头强 on 16/9/6.
//  Copyright © 2016年 Ls. All rights reserved.
//

#import "SLBaseAnimationController.h"
#import <QuartzCore/QuartzCore.h>

@interface SLBaseAnimationController ()
@property (weak, nonatomic) UIView *myView;
@end

@implementation SLBaseAnimationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIView *myView = [[UIView alloc]initWithFrame:CGRectMake(50, 70, 100, 100)];
    [myView setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:myView];
    self.myView = myView;
}

#pragma mark - 动画代理方法
#pragma mark 动画开始(极少用)
- (void)animationDidStart:(CAAnimation *)anim
{
    NSLog(@"开始动画");
}

#pragma mark 动画结束（通常在动画结束后，做动画的后续处理）
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    NSString *type = [anim valueForKey:@"animationType"];
    
    if ([type isEqualToString:@"translationTo"]) {
        // 1. 通过键值取出需要移动到的目标点
        CGPoint point = [[anim valueForKey:@"targetPoint"]CGPointValue];
        NSLog(@"目标点： %@", NSStringFromCGPoint(point));
        
        // 2. 设置myView的坐标点
        [self.myView setCenter:point];
    }
    
    NSLog(@"结束动画，myView: %@", NSStringFromCGRect(self.myView.frame));
}

#pragma mark - touch事件
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = touches.anyObject;
    CGPoint location = [touch locationInView:self.view];
    
    if ([touch view] == self.myView) {
        NSLog(@"点击myView");
    }
    
    // 将myView平移到手指触摸的目标点 以目标点为中心
    [self translationTo:location];//方法1 CABasic动画
    
    // 方法2 UIView动画
//    [UIView animateWithDuration:1.0f animations:^{
//        [self.myView setCenter:location];
//    } completion:^(BOOL finished) {
//        NSLog(@"%@", NSStringFromCGRect(self.myView.frame));
//    }];
}

#pragma mark - CABasic动画
#pragma mark 平移动画到指定点
- (void)translationTo:(CGPoint)point {
    // 1. 实例化动画
    // 如果没有指定图层的锚点（定位点）postion对应UIView的中心点
    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"position"];
    
    // 2. 设置动画属性
    // 1) fromValue(myView的当前坐标) & toValue
    [anim setToValue:[NSValue valueWithCGPoint:point]];
    
    // 2) 动画的时长
    [anim setDuration:1.0f];
    
    // 3) 设置代理
    [anim setDelegate:self];
    
    // 4) 让动画停留在目标位置
    /*
     提示：通过设置动画在完成后不删除，以及向前填充，可以做到平移动画结束后，
     UIView看起来停留在目标位置，但是其本身的frame并不会发生变化
     */
    [anim setRemovedOnCompletion:NO];
    
    // forwards是逐渐逼近目标点
    [anim setFillMode:kCAFillModeForwards];
    
    // 5) 要修正坐标点的实际位置可以利用setValue方法
    [anim setValue:[NSValue valueWithCGPoint:point] forKey:@"targetPoint"];
    [anim setValue:@"translationTo" forKey:@"animationType"];
    
    // 3. 将动画添加到图层
    // 将动画添加到图层之后，系统会按照定义好的属性开始动画，通常程序员不在与动画进行交互
    [self.myView.layer addAnimation:anim forKey:nil];
}

@end
