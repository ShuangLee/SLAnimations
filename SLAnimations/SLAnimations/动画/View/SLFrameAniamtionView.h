//
//  SLFrameAniamtionView.h
//  SLAnimations
//
//  Created by 光头强 on 16/9/7.
//  Copyright © 2016年 Ls. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface SLFrameAniamtionView : UIView
#pragma mark 摇晃动画
+ (CAKeyframeAnimation *)shakeAnimation;

#pragma mark 贝塞尔曲线，两个控制点
+ (CAKeyframeAnimation *)moveCurveWithDuration:(CFTimeInterval)duration from:(CGPoint)from to:(CGPoint)to;

#pragma mark 贝塞尔曲线，一个控制点
+ (CAKeyframeAnimation *)moveQuadCurveWithDuration:(CFTimeInterval)duration from:(CGPoint)from to:(CGPoint)to;

#pragma mark 按照矩形路径平移动画
+ (CAKeyframeAnimation *)moveRectWithDuration:(CFTimeInterval)duration from:(CGPoint)from to:(CGPoint)to;

#pragma mark 使用随机中心点控制动画平移
+ (CAKeyframeAnimation *)moveWithDuration:(CFTimeInterval)duration from:(CGPoint)from to:(CGPoint)to controlPointCount:(NSInteger)cpCount;

+ (CABasicAnimation *)scaleWithDuration:(CFTimeInterval)duration from:(CGFloat)from to:(CGFloat)to;

+ (CABasicAnimation *)opacityWithDuration:(CFTimeInterval)duration from:(CGFloat)from to:(CGFloat)to;

+ (CABasicAnimation *)rotationWithDuration:(CFTimeInterval)duration from:(CGFloat)from to:(CGFloat)to;

@end
