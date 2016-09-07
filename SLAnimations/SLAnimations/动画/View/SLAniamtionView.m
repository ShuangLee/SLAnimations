//
//  SLAniamtionView.m
//  SLAnimations
//
//  Created by 光头强 on 16/9/7.
//  Copyright © 2016年 Ls. All rights reserved.
//

#import "SLAniamtionView.h"
#import <QuartzCore/QuartzCore.h>

@implementation SLAniamtionView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor redColor];
    }
    return self;
}

#pragma mark - 动画代理方法
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    // 取出动画类型
    NSString *type = [anim valueForKey:@"animationType"];
    
    if ([type isEqualToString:@"translationTo"]) {
        // 取出目标点 并 设置self.center
        self.center = [[anim valueForKey:@"targetPoint"]CGPointValue];
    }
    
}

#pragma mark - 私有方法
#pragma mark 生成屏幕上的随机点
- (CGPoint)randomPoint
{
    // 获得父视图的大小
    CGSize size = self.superview.bounds.size;
    
    CGFloat x = arc4random_uniform(size.width);
    CGFloat y = arc4random_uniform(size.height);
    
    return CGPointMake(x, y);
}

#pragma mark - 关键帧动画方法
/*
 在做核心动画是，一定记住动画的效果要是随机的，否则，无论多么绚丽的效果，用户都会审美疲劳！
 
 因为核心动画做的效果属于装饰性动画，动画过程中不需要用户的交互，因此动画效果就格外重要。
 */
// 使用屏幕上的随机点作为中间点，指定中间点的数量
#pragma mark 摇晃动画
// 课下练习动画的暂停和恢复
- (void)shakeAnimation
{
    // 1. 实例化关键帧动画
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation"];
    
    // 晃动
    //    [anim setDuration:0.5f];
    
    // 1> 角度
    CGFloat angel = M_PI_4 / 12.0;
    [anim setValues:@[@(angel), @(-angel), @(angel)]];
    
    // 2> 循环晃
    [anim setRepeatCount:HUGE_VALF];
    
    // 3. 将动画添加到图层
    [self.layer addAnimation:anim forKey:nil];
}

#pragma mark 贝塞尔曲线，两个控制点
- (void)moveCurveWithDuration:(CFTimeInterval)duration to:(CGPoint)to
{
    // 1. 实例化关键帧动画
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    
    // 2. 设置路径
    [anim setDuration:duration];
    
    // 中间的控制点使用屏幕上得随机点
    CGPoint cp1 = [self randomPoint];
    CGPoint cp2 = [self randomPoint];
    
    CGMutablePathRef path = CGPathCreateMutable();
    
    // 设置起始点
    CGPathMoveToPoint(path, NULL, self.center.x, self.center.y);
    // 添加带一个控制点的贝塞尔曲线
    CGPathAddCurveToPoint(path, NULL, cp1.x, cp1.y, cp2.x, cp2.y, to.x, to.y);
    
    [anim setPath:path];
    CGPathRelease(path);
    
    // 5) 设置键值记录目标位置，以便动画结束后，修正位置
    [anim setValue:@"translationTo" forKey:@"animationType"];
    [anim setValue:[NSValue valueWithCGPoint:to] forKey:@"targetPoint"];
    [anim setDelegate:self];
    
    // 3. 将动画添加到图层
    [self.layer addAnimation:anim forKey:nil];
}

#pragma mark 贝塞尔曲线，一个控制点
- (void)moveQuadCurveWithDuration:(CFTimeInterval)duration to:(CGPoint)to
{
    // 1. 实例化关键帧动画
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    
    // 2. 设置路径
    [anim setDuration:duration];
    
    // 中间的控制点使用屏幕上得随机点
    CGPoint cp = [self randomPoint];
    
    CGMutablePathRef path = CGPathCreateMutable();
    
    // 设置起始点
    CGPathMoveToPoint(path, NULL, self.center.x, self.center.y);
    // 添加带一个控制点的贝塞尔曲线
    CGPathAddQuadCurveToPoint(path, NULL, cp.x, cp.y, to.x, to.y);
    
    [anim setPath:path];
    CGPathRelease(path);
    
    // 5) 设置键值记录目标位置，以便动画结束后，修正位置
    [anim setValue:@"translationTo" forKey:@"animationType"];
    [anim setValue:[NSValue valueWithCGPoint:to] forKey:@"targetPoint"];
    [anim setDelegate:self];
    
    // 3. 将动画添加到图层
    [self.layer addAnimation:anim forKey:nil];
}

#pragma mark 按照矩形路径平移动画
// 移动的矩形是以当前点为矩形的一个顶点，目标点为矩形的对脚顶点
- (void)moveRectWithDuration:(CFTimeInterval)duration to:(CGPoint)to
{
    // 1. 实例化关键帧动画
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    
    // 2. 按照矩形移动，需要使用到路径
    [anim setDuration:duration];
    
    // 1) 创建路径
    CGMutablePathRef path = CGPathCreateMutable();
    // 2) 设置路径内容
    // 起点，宽、高
    CGFloat w = to.x - self.center.x;
    CGFloat h = to.y - self.center.y;
    CGRect rect = CGRectMake(self.center.x, self.center.y, w, h);
    CGPathAddRect(path, nil, rect);
    
    // 3) 将路径添加到动画
    [anim setPath:path];
    
    // 4) 释放路径
    CGPathRelease(path);
    
    // 3. 将动画添加到图层
    [self.layer addAnimation:anim forKey:nil];
}

#pragma mark 使用随机中心点控制动画平移
- (void)moveWithDuration:(CFTimeInterval)duration to:(CGPoint)to controlPointCount:(NSInteger)cpCount
{
    // 1. 实例化关键帧动画
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    
    // 2. 设置关键帧动画属性
    [anim setDuration:duration];
    
    // 设置values
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:cpCount + 2];
    
    // 1) 将起始点添加到数组
    [array addObject:[NSValue valueWithCGPoint:self.center]];
    
    // 2) 循环生成控制点位置数组
    for (NSInteger i = 0; i < cpCount; i++) {
        CGPoint p = [self randomPoint];
        
        [array addObject:[NSValue valueWithCGPoint:p]];
    }
    
    // 3) 将目标点添加到数组
    [array addObject:[NSValue valueWithCGPoint:to]];
    
    // 4) 设置values
    [anim setValues:array];
    
    // 5) 设置键值记录目标位置，以便动画结束后，修正位置
    [anim setValue:@"translationTo" forKey:@"animationType"];
    [anim setValue:[NSValue valueWithCGPoint:to] forKey:@"targetPoint"];
    [anim setDelegate:self];
    
    // 3. 将动画添加到图层
    [self.layer addAnimation:anim forKey:nil];
}

#pragma mark 移动到目标点
- (void)moveToPoint:(CGPoint)point
{
    // 1. 实例化关键帧动画
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    
    // 2. 设置关键帧动画属性
    // 1) values
    // a. 让视图从当前点移动到屏幕的左上角
    // b. 再由左上角移动到用户点击的位置
    // 当前点
    NSValue *p1 = [NSValue valueWithCGPoint:self.center];
    NSValue *p2 = [NSValue valueWithCGPoint:CGPointMake(0, 0)];
    NSValue *p3 = [NSValue valueWithCGPoint:point];
    
    [anim setValues:@[p1, p2, p3]];
    
    // 2) 时长
    [anim setDuration:1.0f];
    
    // 3) 设置键值记录目标位置，以便动画结束后，修正位置
    [anim setValue:@"translationTo" forKey:@"animationType"];
    [anim setValue:p3 forKey:@"targetPoint"];
    
    // 4) 设置代理
    [anim setDelegate:self];
    
    // 3. 将动画添加到图层
    [self.layer addAnimation:anim forKey:nil];
}

@end
