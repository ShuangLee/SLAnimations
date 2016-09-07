//
//  SLAniamtionView.h
//  SLAnimations
//
//  Created by 光头强 on 16/9/7.
//  Copyright © 2016年 Ls. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SLAniamtionView : UIView
#pragma mark 摇晃动画
- (void)shakeAnimation;

#pragma mark 贝塞尔曲线，两个控制点
- (void)moveCurveWithDuration:(CFTimeInterval)duration to:(CGPoint)to;

#pragma mark 贝塞尔曲线，一个控制点
- (void)moveQuadCurveWithDuration:(CFTimeInterval)duration to:(CGPoint)to;

#pragma mark 按照矩形路径平移动画
- (void)moveRectWithDuration:(CFTimeInterval)duration to:(CGPoint)to;

#pragma mark 使用随机中心点控制动画平移
- (void)moveWithDuration:(CFTimeInterval)duration to:(CGPoint)to controlPointCount:(NSInteger)cpCount;

#pragma mark 移动到目标点
- (void)moveToPoint:(CGPoint)point;
@end
