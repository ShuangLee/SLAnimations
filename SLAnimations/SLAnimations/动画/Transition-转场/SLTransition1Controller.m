//
//  SLTransition1Controller.m
//  SLAnimations
//
//  Created by 光头强 on 16/9/7.
//  Copyright © 2016年 Ls. All rights reserved.
//

#import "SLTransition1Controller.h"
#import <QuartzCore/QuartzCore.h>
/*
 目标：通过转场动画实现9张图的切换
 通过转场动画，只需要一张imageView即可
 需求：通过轻扫手势实现左右转场效果
 */
@interface SLTransition1Controller ()
@property (copy, nonatomic) NSArray *imageList;
@end

@implementation SLTransition1Controller

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 1. 实例化一个imageView添加到视图
    UIImage *image = [UIImage imageNamed:@"1.jpg"];
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:self.view.bounds];
    [imageView setImage:image];
    
    [self.view addSubview:imageView];
    
    // 2. 添加轻扫手势
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipe:)];
    [swipeLeft setDirection:UISwipeGestureRecognizerDirectionLeft];
    [imageView addGestureRecognizer:swipeLeft];
    
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipe:)];
    [swipeRight setDirection:UISwipeGestureRecognizerDirectionRight];
    [imageView addGestureRecognizer:swipeRight];
    
    // UIImageView 默认不支持用户交互
    [imageView setUserInteractionEnabled:YES];
    
    // 3. 初始化数据
    NSMutableArray *arrayM = [NSMutableArray arrayWithCapacity:9];
    
    for (NSInteger i = 1; i < 10; i++) {
        NSString *fileName = [NSString stringWithFormat:@"%ld.jpg", (long)i];
        UIImage *image = [UIImage imageNamed:fileName];
        
        [arrayM addObject:image];
    }
    
    self.imageList = arrayM;
}

#pragma mark 轻扫手势监听方法
- (void)swipe:(UISwipeGestureRecognizer *)recognizer
{
    // 1. 实例化转场动画 注意不要和CATransaction（动画事务）搞混
    CATransition *transition = [[CATransition alloc]init];
    
    // 1） 设置类型 type
    [transition setType:@"moveIn"];
    
    // 2) 根据轻扫方向设置子类型 subType
    // 2. 判断轻扫的方向
    UIImageView *imageView = (UIImageView *)recognizer.view;
    
    if (UISwipeGestureRecognizerDirectionLeft == recognizer.direction) {
        NSLog(@"向左，图像索引递增");
        [transition setSubtype:kCATransitionFromRight];
        
        imageView.tag = (imageView.tag + 1) % self.imageList.count;
        
        NSLog(@"%ld %lu", (long)imageView.tag, (unsigned long)self.imageList.count);
    } else {
        NSLog(@"向右，图像索引递减");
        [transition setSubtype:kCATransitionFromLeft];
        
        // 针对负数去模，需要注意修正索引
        imageView.tag = (imageView.tag - 1 + self.imageList.count) % self.imageList.count;
        
        NSLog(@"%ld %lu", (long)imageView.tag, (unsigned long)self.imageList.count);
    }
    
    // 3) 设置时长
    [transition setDuration:0.5f];
    
    /**
     在使用转场动画时，在转场动画附加到图层之前，设置视图内容，转场动画会自动完成内容的过渡
     
     可以通过imageView的tag属性来记录当前显示的image索引
     */
    [imageView setImage:self.imageList[imageView.tag]];
    
    // 3. 动画添加到图层
    [recognizer.view.layer addAnimation:transition forKey:nil];
}
@end
