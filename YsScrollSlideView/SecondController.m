//
//  SecondController.m
//  YsScrollSlideView
//
//  Created by weiying on 16/3/22.
//  Copyright © 2016年 Yuns. All rights reserved.
//

#import "SecondController.h"
#import "YsTopScrollView.h"
#import "YsRootScrollView.h"
#import "BaseTestController.h"

@interface SecondController ()
@property (nonatomic, strong) NSArray *titleArr;
@property (nonatomic, strong) YsTopScrollView *topScroll;
@property (nonatomic, strong) YsRootScrollView *rootScroll;
@end

@implementation SecondController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titleArr = @[@"五代火影", @"漩涡鸣人", @"佐助", @"小樱", @"copy忍者卡卡西", @"沙爆我爱罗"];
    [self setupTop];
    [self setupRoot];
}

- (void)setupTop
{
    YsTopScrollView *topScroll = [[YsTopScrollView alloc] initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, 40)];
    topScroll.backgroundColor = [UIColor purpleColor];
    topScroll.titleNameArr = self.titleArr;
    topScroll.topClickBlock = ^(NSInteger index){
        [self.rootScroll rootContentOffsetWithIndex:index];
    };
//    [topScroll topContentOffsetWithIndex:2];//先创建
    [self.view addSubview:topScroll];
    self.topScroll = topScroll;
}

- (void)setupRoot
{
    YsRootScrollView *rootScroll = [[YsRootScrollView alloc] initWithFrame:CGRectMake(0, 60, self.view.frame.size.width, self.view.frame.size.height - 60)];
    rootScroll.rootScrollBlock = ^(NSInteger index, UIViewController *VC, BOOL isExistVC){
        [self.topScroll topContentOffsetWithIndex:index];
    };
    [rootScroll rootContentOffsetWithIndex:2];//后创建
    rootScroll.backgroundColor = [UIColor whiteColor];
    NSMutableArray *arr = [NSMutableArray array];
    for (NSInteger i = 0; i < self.titleArr.count; i ++) {
        BaseTestController *vc = [[BaseTestController alloc] init];
        [self addChildViewController:vc];
        [arr addObject:vc];
    }
    rootScroll.contentVCArr = arr;
    [self.view addSubview:rootScroll];
    self.rootScroll = rootScroll;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
