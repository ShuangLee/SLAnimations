//
//  SLAnimation1ViewController.m
//  SLAnimations
//
//  Created by 光头强 on 16/9/7.
//  Copyright © 2016年 Ls. All rights reserved.
//

#import "SLAnimation1ViewController.h"
#import "SLAniamtionView.h"

@interface SLAnimation1ViewController ()
@property (weak, nonatomic) SLAniamtionView *myView;
@end

@implementation SLAnimation1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // 实例化动画视图
    SLAniamtionView *view = [[SLAniamtionView alloc]initWithFrame:CGRectMake(50, 50, 100, 100)];
    [self.view addSubview:view];
    self.myView = view;
    
    // 手势识别监听
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
    [self.view addGestureRecognizer:tap];
    
    // 长按手势监听
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longTapAction:)];
    [self.myView addGestureRecognizer:longPress];

}

#pragma mark - 手势识别监听方法
- (void)longTapAction:(UILongPressGestureRecognizer *)recognizer
{
    [(SLAniamtionView *)recognizer.view shakeAnimation];
}

- (void)tapAction:(UITapGestureRecognizer *)recognizer
{
    // 取出手势的触摸点
    CGPoint location = [recognizer locationInView:self.view];
    
    [self.myView moveCurveWithDuration:0.8f to:location];
}


@end
