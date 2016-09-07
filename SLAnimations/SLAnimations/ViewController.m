//
//  ViewController.m
//  SLAnimations
//
//  Created by 光头强 on 16/9/6.
//  Copyright © 2016年 Ls. All rights reserved.
//

#import "ViewController.h"
#import "SLBaseAnimationController.h"
#import "SLAnimationViewController.h"
#import "SLAnimation1ViewController.h"
#import "SLGroupAniamtionViewController.h"
#import "SLTransitionViewController.h"

static NSString * const AppleItemsIdentifier =@"ItemsIdentifier";
@interface ViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, copy) NSArray *titles;
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation ViewController
- (NSArray *)titles {
    return @[@"基本动画",@"旋转和缩放",@"关键帧动画",@"组动画",@"转场动画"];
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:AppleItemsIdentifier];
    }
    
    return _tableView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"Quartz 2D";
    [self.view addSubview:self.tableView];
    
    self.view.backgroundColor = [UIColor whiteColor];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.titles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:AppleItemsIdentifier];
    cell.textLabel.text = self.titles[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:
            [self.navigationController pushViewController:[[SLBaseAnimationController alloc] init] animated:YES];
            break;
        case 1:
            [self.navigationController pushViewController:[[SLAnimationViewController alloc] init] animated:YES];
            break;
        case 2:
            [self.navigationController pushViewController:[[SLAnimation1ViewController alloc] init] animated:YES];
            break;
        case 3:
            [self.navigationController pushViewController:[[SLGroupAniamtionViewController alloc] init] animated:YES];
            break;
        case 4:
            [self.navigationController pushViewController:[[SLTransitionViewController alloc] init] animated:YES];
            break;
                   
        default:
            break;
    }
}

@end
