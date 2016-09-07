//
//  SLAnimationViewController.m
//  SLAnimations
//
//  Created by 光头强 on 16/9/7.
//  Copyright © 2016年 Ls. All rights reserved.
//

#import "SLAnimationViewController.h"

@interface SLAnimationViewController ()
@property (weak, nonatomic) UIView *myView;
@end

/**
 基本动画简单小结
 1. 通过对CALayer的可动画属性进行修改，实现动画
 2. fromValue和toValue
 3. 动画使用的步骤：
 1> 实例化
 2> 定义属性
 3> 添加到图层
 
 注意点：
 1> 循环播放的动画，如果需要在恢复焦点后继续，一定将RemovedOnCompletion属性设置为NO
 2> 针对平移动画，需要在动画结束的代理方法中，调整对象的位置
 3> 如果要做无线循环动画，可以如下设置 [anim setRepeatCount:HUGE_VALF];
 4> 关于暂停和继续动画，可以参照代码
 */
@implementation SLAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIView *myView = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    [myView setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:myView];
    self.myView = myView;
    
    UIButton *rotationBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rotationBtn.frame = CGRectMake(10, 300, 80, 30);
    [rotationBtn setTitle:@"旋转" forState:UIControlStateNormal];
    [rotationBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.view addSubview:rotationBtn];
    
    UIButton *scaleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    scaleBtn.frame = CGRectMake(100, 300, 80, 30);
    [scaleBtn setTitle:@"缩放" forState:UIControlStateNormal];
    [scaleBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.view addSubview:scaleBtn];
    
    UIButton *pauseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    pauseBtn.frame = CGRectMake(190, 300, 80, 30);
    [pauseBtn setTitle:@"暂停" forState:UIControlStateNormal];
    [pauseBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.view addSubview:pauseBtn];
    
    UIButton *resumeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    resumeBtn.frame = CGRectMake(280, 300, 80, 30);
    [resumeBtn setTitle:@"恢复" forState:UIControlStateNormal];
    [resumeBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.view addSubview:resumeBtn];
    
    [rotationBtn addTarget:self action:@selector(rotation) forControlEvents:UIControlEventTouchUpInside];
    [scaleBtn addTarget:self action:@selector(scale) forControlEvents:UIControlEventTouchUpInside];
    [pauseBtn addTarget:self action:@selector(pauseAnimation) forControlEvents:UIControlEventTouchUpInside];
    [resumeBtn addTarget:self action:@selector(resumeAnimation) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark 旋转动画
- (void)rotation {
    // 默认按照z轴旋转
    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    [self.myView.layer setAnchorPoint:CGPointMake(0, 0)];
    
    // 设置动画属性
    // 不停的旋转
    // 1) 旋转一周
    [anim setToValue:@(2 * M_PI)];
    // 2) 不停的旋转 - 动画循环播放
    // HUGE_VALF 是一个非常大得浮点数，指定此数值可以认为动画无限循环
    // MAXFLOAT
    [anim setRepeatCount:HUGE_VALF];
    
    [anim setDuration:0.5f];
    // 3) 动画完成时删除
    // 对于循环播放的动画效果，一定要将removedOnCompletion设置为NO，否则无法恢复动画
    [anim setRemovedOnCompletion:NO];
    
    // 3. 添加动画
    // key可以随便指定，用于判断图层中是否存在该动画
    [self.myView.layer addAnimation:anim forKey:@"rotationAnim"];
}

#pragma mark 缩放动画
- (void)scale {
    // 1. 实例化基本动画
    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    
    // 2. 设置动画属性
    // fromValue & toValue
    [anim setFromValue:@(1.0)];
    // 从当前大小缩小到一半，然后恢复初始大小
    [anim setToValue:@(0.5)];
    // 自动翻转动画
    [anim setAutoreverses:YES];
    
    // 动画时长
    [anim setDuration:0.5f];
    
    // 3. 将动画添加到图层
    [self.myView.layer addAnimation:anim forKey:nil];
}

#pragma mark 动画暂停
- (void)pauseAnimation {
    // 1. 取出当前的动画的时间点，就是要暂停的时间点
    CFTimeInterval pauseTime = [self.myView.layer convertTime:CACurrentMediaTime() fromLayer:nil];
    // 2. 设置动画的时间偏移量，指定时间偏移量的目的是让动画定格在该时间点
    [self.myView.layer setTimeOffset:pauseTime];
    
    // 3. 将动画的运行速度设置为0，动画默认的运行速度是1.0
    [self.myView.layer setSpeed:0.0];
}

#pragma mark 恢复动画
- (void)resumeAnimation {
    // 1. 将动画的时间偏移量作为暂停时的时间点
    CFTimeInterval pauseTime = self.myView.layer.timeOffset;
    // 2. 根据媒体时间计算出准确的启动动画时间，对之前暂停动画的时间进行修正
    CFTimeInterval beginTime = CACurrentMediaTime() - pauseTime;
    
    // 3. 要把偏移时间清零
    [self.myView.layer setTimeOffset:0.0];
    // 4. 设置图层的开始动画时间
    [self.myView.layer setBeginTime:beginTime];
    
    [self.myView.layer setSpeed:1.0];
}

@end
