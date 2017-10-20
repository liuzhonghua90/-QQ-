//
//  LeftViewController.m
//  仿QQ侧滑功能
//
//  Created by LIANGKUNLIN on 2017/8/26.
//  Copyright © 2017年 meilixun. All rights reserved.
//

#import "LeftViewController.h"
#define scremW ([UIScreen mainScreen].bounds.size.width)
#define scremH ([UIScreen mainScreen].bounds.size.height)
@interface LeftViewController ()

@end

@implementation LeftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(scremW-100, 100, 100, 30)];
    label.text = @"我是左视图";
    label.textColor = [UIColor blackColor];
    [self.view addSubview:label];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
