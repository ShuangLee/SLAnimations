//
//  SLTransition2Controller.m
//  SLAnimations
//
//  Created by 光头强 on 16/9/7.
//  Copyright © 2016年 Ls. All rights reserved.
//

#import "SLTransition2Controller.h"

@interface SLTransition2Controller ()
@property (weak, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) NSArray *imageList;
@end

@implementation SLTransition2Controller

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 实例化imageView
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:self.view.bounds];
    UIImage *image = [UIImage imageNamed:@"1.jpg"];
    [imageView setImage:image];
    
    [self.view addSubview:imageView];
    
    self.imageView = imageView;
    
    // 3. 初始化数据
    NSMutableArray *arrayM = [NSMutableArray arrayWithCapacity:9];
    
    for (NSInteger i = 1; i < 10; i++) {
        NSString *fileName = [NSString stringWithFormat:@"%ld.jpg", (long)i];
        UIImage *image = [UIImage imageNamed:fileName];
        
        [arrayM addObject:image];
    }
    
    self.imageList = arrayM;

}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [UIView transitionWithView:self.imageView duration:1.0f options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
        
        // 在此设置视图反转之后显示的内容
        
        self.imageView.tag = (self.imageView.tag + 1) % self.imageList.count;
        [self.imageView setImage:self.imageList[self.imageView.tag]];
    } completion:^(BOOL finished) {
        NSLog(@"反转完成");
    }];
    
}

@end
