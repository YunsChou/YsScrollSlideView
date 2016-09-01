//
//  FirstController.m
//  YsScrollSlideView
//
//  Created by weiying on 16/3/22.
//  Copyright © 2016年 Yuns. All rights reserved.
//

#import "FirstController.h"
#import "YsTopScrollView.h"
#import "YsRootScrollView.h"
#import "BaseTestController.h"

@interface FirstController ()
@property (nonatomic, strong) YsTopScrollView *topScroll;
@property (nonatomic, strong) YsRootScrollView *rootScroll;
@end

@implementation FirstController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupRoot];
    [self setupTop];
}

- (void)setupTop
{
    YsTopScrollView *topScroll = [[YsTopScrollView alloc] initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, 40)];
    topScroll.backgroundColor = [UIColor redColor];
    topScroll.titleNameArr = @[@"网易新闻", @"新浪微博新闻", @"搜狐", @"头条新闻", @"本地动态", @"精美图片集"];
    topScroll.topClickBlock = ^(NSInteger index){
        [self.rootScroll rootContentOffsetWithIndex:index];
    };
    [self.view addSubview:topScroll];
    self.topScroll = topScroll;
}

- (void)setupRoot
{
    YsRootScrollView *rootScroll = [[YsRootScrollView alloc] initWithFrame:CGRectMake(0, 60, self.view.frame.size.width, self.view.frame.size.height - 60)];
    rootScroll.rootScrollBlock = ^(NSInteger index, UIViewController *VC, BOOL isExistVC){
        [self.topScroll topContentOffsetWithIndex:index];
    };
    
    rootScroll.backgroundColor = [UIColor whiteColor];
    NSMutableArray *arr = [NSMutableArray array];
    for (NSInteger i = 0; i < 6; i ++) {
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
