//
//  SLGroupAniamtionViewController.m
//  SLAnimations
//
//  Created by 光头强 on 16/9/7.
//  Copyright © 2016年 Ls. All rights reserved.
//

#import "SLGroupAniamtionViewController.h"
#import "SLFrameAniamtionView.h"

@interface SLGroupAniamtionViewController ()
@property (weak, nonatomic) SLFrameAniamtionView *myView;
@end

@implementation SLGroupAniamtionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 实例化动画视图
    SLFrameAniamtionView *view = [[SLFrameAniamtionView alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
    [self.view addSubview:view];
    self.myView = view;
    
    // 给myView 添加一个image
    UIImage *image = [UIImage imageNamed:@"userIcon"];
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:view.bounds];
    [imageView setImage:image];
    [view addSubview:imageView];
    
    // 给myView 添加一个button
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button setFrame:CGRectMake(10, 30, 80, 40)];
    [button setTitle:@"hello" forState:UIControlStateNormal];
    [view addSubview:button];
    
    // 手势识别监听
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
    [self.view addGestureRecognizer:tap];
    
    // 长按手势监听
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longTapAction:)];
    [self.myView addGestureRecognizer:longPress];
}

#pragma mark - 动画代理方法
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    // 取出动画类型
    NSString *type = [anim valueForKey:@"animationType"];
    
    if ([type isEqualToString:@"translationTo"]) {
        // 取出目标点 并 设置self.center
        self.myView.center = [[anim valueForKey:@"targetPoint"]CGPointValue];
    }
}

#pragma mark - 手势识别监听方法
- (void)longTapAction:(UILongPressGestureRecognizer *)recognizer
{
    //    [(AnimationView *)recognizer.view shakeAnimation];
    CAKeyframeAnimation *anim = [SLFrameAniamtionView shakeAnimation];
    
    [self.myView.layer addAnimation:anim forKey:nil];
}

- (void)tapAction:(UITapGestureRecognizer *)recognizer
{
    // 取出手势的触摸点
    CGPoint location = [recognizer locationInView:self.view];
    
    // 1. 实例化动画组
    CAAnimationGroup *group = [[CAAnimationGroup alloc]init];
    
    CFTimeInterval duration = 2.0;
    
    // 2. 定义动画组中的动画
    //    CAKeyframeAnimation *anim1 = [AnimationView moveRectWithDuration:duration from:self.myView.center to:location];
    CAKeyframeAnimation *anim1 = [SLFrameAniamtionView moveWithDuration:duration from:self.myView.center to:location controlPointCount:4];
    CABasicAnimation *anim2 = [SLFrameAniamtionView rotationWithDuration:duration from:0.0 to:2 * M_PI];
    
    CABasicAnimation *scale = [SLFrameAniamtionView scaleWithDuration:duration from:2.0 to:0.5];
    CABasicAnimation *opacity = [SLFrameAniamtionView opacityWithDuration:duration from:0.1 to:1.0];
    
    // 3. 将定义的动画添加到动画组
    [group setAnimations:@[anim1, anim2, scale, opacity]];
    
    // 定义动画组执行的时间长度
    [group setDuration:duration];
    
    // 5) 设置键值记录目标位置，以便动画结束后，修正位置
    // 并不是所有的动画方法都需要设置目标点
    [group setValue:@"translationTo" forKey:@"animationType"];
    [group setValue:[NSValue valueWithCGPoint:location] forKey:@"targetPoint"];
    [group setDelegate:self];
    
    // 4. 将动画组添加到视图的图层
    [self.myView.layer addAnimation:group forKey:nil];
}

@end
