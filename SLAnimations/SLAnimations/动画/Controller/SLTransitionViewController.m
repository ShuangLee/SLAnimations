//
//  SLTransitionViewController.m
//  SLAnimations
//
//  Created by 光头强 on 16/9/7.
//  Copyright © 2016年 Ls. All rights reserved.
//

#import "SLTransitionViewController.h"
#import "SLTransition1Controller.h"
#import "SLTransition2Controller.h"
#import "SLTransition3Controller.h"

@interface SLTransitionViewController ()

@end

@implementation SLTransitionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn1.frame = CGRectMake(10, 300, 100, 30);
    [btn1 setTitle:@"平滑" forState:UIControlStateNormal];
    [btn1 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.view addSubview:btn1];
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn2.frame = CGRectMake(120, 300, 100, 30);
    [btn2 setTitle:@"单视图反转" forState:UIControlStateNormal];
    [btn2 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.view addSubview:btn2];
    
    UIButton *btn3 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn3.frame = CGRectMake(230, 300, 100, 30);
    [btn3 setTitle:@"双视图转场" forState:UIControlStateNormal];
    [btn3 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.view addSubview:btn3];
    
    [btn1 addTarget:self action:@selector(transion1) forControlEvents:UIControlEventTouchUpInside];
    [btn2 addTarget:self action:@selector(transion2) forControlEvents:UIControlEventTouchUpInside];
    [btn3 addTarget:self action:@selector(transion3) forControlEvents:UIControlEventTouchUpInside];
}

- (void)transion1 {
    [self.navigationController pushViewController:[[SLTransition1Controller alloc] init] animated:YES];
}

- (void)transion2 {
    [self.navigationController pushViewController:[[SLTransition2Controller alloc] init] animated:YES];
}

- (void)transion3 {
    [self.navigationController pushViewController:[[SLTransition3Controller alloc] init] animated:YES];
}
@end
