//
//  ViewController.m
//  仿QQ侧滑功能
//
//  Created by LIANGKUNLIN on 2017/8/26.
//  Copyright © 2017年 meilixun. All rights reserved.
//



#import "ViewController.h"
#import "UIView+Common.h"
#import "LeftViewController.h"
#import "RightViewController.h"



#define scremW ([UIScreen mainScreen].bounds.size.width)
#define scremH ([UIScreen mainScreen].bounds.size.height)
#define pushX 150.f
@interface ViewController ()<UIGestureRecognizerDelegate>

@property (nonatomic, strong) UIView *mainView;
@property (nonatomic, strong) LeftViewController *leftCtl;
@property (nonatomic, strong) RightViewController *rightCtl;
@property (nonatomic, strong) UIButton *pushBtn;
@property (nonatomic, strong) UIPanGestureRecognizer *pan;
@property (nonatomic, strong) UITapGestureRecognizer *tap;
@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.mainView];
    
    LeftViewController *leftCtl = [[LeftViewController alloc] init];
    leftCtl.view.frame = CGRectMake(-scremW, 0, scremW, scremH);
    
    RightViewController *rightCtl = [[RightViewController alloc] init];
    rightCtl.view.frame = CGRectMake(0, 0, scremW, scremH);
    

    [self.mainView addSubview:leftCtl.view];
    [self.mainView addSubview:rightCtl.view];
    
    
    UIButton *pushBtn = [[UIButton alloc] initWithFrame:CGRectMake(20, 30, 50, 30)];
    [pushBtn setTitle:@"展开" forState:UIControlStateNormal];
    pushBtn.backgroundColor = [UIColor greenColor];
    [pushBtn addTarget:self action:@selector(pushClick) forControlEvents:UIControlEventTouchUpInside];
    
    [rightCtl.view addSubview:pushBtn];
    
    self.pushBtn = pushBtn;
    

    
    //在rightView上添加一个tap手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGest:)];
    tap.delegate = self;
    [rightCtl.view addGestureRecognizer:tap];
    tap.enabled = NO;
    self.tap = tap;
    
    //在rightView加一个拖动收拾
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGest:)];
    self.pan = pan;
    [rightCtl.view addGestureRecognizer:pan];
    self.leftCtl = leftCtl;
    self.rightCtl = rightCtl;

}

#pragma 处理按钮点击和手势之间的冲突
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch

{
    CGPoint location = [touch locationInView:self.rightCtl.view];
    if(CGRectContainsPoint(self.pushBtn.frame, location)){
        return NO;
    }
    return YES;
    
}
-(void)panGest:(UIPanGestureRecognizer *)gest
{
//    NSLog(@"panGest拖动了");
    [gest.view.superview bringSubviewToFront:gest.view];
    CGPoint velocity = [gest velocityInView:self.view];
    if (gest.state == UIGestureRecognizerStateChanged) {
       
        if (velocity.x>0 && velocity.x <100.0f && self.leftCtl.view.x < 150.f) {
            [UIView animateWithDuration:0.1 animations:^{
                self.rightCtl.view.x = velocity.x;
                self.leftCtl.view.x = -scremW + velocity.x;
                NSLog(@"velocity.x%f",velocity.x);
                NSLog(@"self.leftCtl%f",self.leftCtl.view.x);
            }];
        }
    }else if (gest.state == UIGestureRecognizerStateEnded){
        if (velocity.x > 100.f) {
            self.pushBtn.enabled = NO;
            self.pan.enabled = NO;
            self.tap.enabled = YES;
            [self open];
        }else{
            [UIView animateWithDuration:0.25 animations:^{
                self.rightCtl.view.x = 0;
                self.leftCtl.view.x = -scremW;
                self.tap.enabled = NO;
                self.pushBtn.enabled = YES;
            }];
        }
    }
}


-(void)tapGest:(UIGestureRecognizer *)gest
{
    self.pushBtn.enabled = YES;
    [self closed];
}

-(void)pushClick
{
    [self open];
    self.tap.enabled = YES;
}


-(void)closed
{
    self.tap.enabled = NO;
    self.pan.enabled = YES;
    [UIView animateWithDuration:0.25 animations:^{
        self.leftCtl.view.x = self.leftCtl.view.x - pushX;
        self.rightCtl.view.x = self.rightCtl.view.x - pushX;
        
    }];
}

-(void)open
{
    self.pushBtn.enabled = NO;
    self.pan.enabled = YES;
    [UIView animateWithDuration:0.25 animations:^{
        self.rightCtl.view.x = pushX;
        self.leftCtl.view.x = -scremW + pushX;
        
    }];
}

-(UIView *)mainView
{
    if (!_mainView) {
        _mainView = [[UIView alloc] initWithFrame:self.view.bounds];
        _mainView.backgroundColor = [UIColor grayColor];
    }
    return _mainView;
}



@end
