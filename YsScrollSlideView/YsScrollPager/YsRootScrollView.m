//
//  YsRootScrollView.m
//  ScrollSlideView
//
//  Created by weiying on 16/3/15.
//  Copyright © 2016年 Yuns. All rights reserved.
//

#import "YsRootScrollView.h"

@implementation YsRootScrollView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.delegate = self;
        self.pagingEnabled = YES;
        self.userInteractionEnabled = YES;
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
    }
    return self;
}

- (void)setContentVCArr:(NSArray *)contentVCArr
{
    _contentVCArr = contentVCArr;
    [self setupContentVC];
}

- (void)setupContentVC
{
    CGFloat contentScrollW = _contentVCArr.count * self.frame.size.width;
    self.contentSize = CGSizeMake(contentScrollW, 40);
    UIViewController *contentVC = _contentVCArr[0];
    contentVC.view.frame = self.bounds;
    contentVC.view.backgroundColor = [UIColor redColor];
    [self addSubview:contentVC.view];
}

- (void)rootContentOffsetWithIndex:(NSInteger)index
{
    CGFloat offsetX = index * self.frame.size.width;
    CGFloat offsetY = self.contentOffset.y;
    CGPoint offset = CGPointMake(offsetX, offsetY);
    [self setContentOffset:offset animated:YES];
}

#pragma mark - scrollview代理方法
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self scrollViewDidEndScrollingAnimation:scrollView];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    //获得当前索引
    NSInteger index = scrollView.contentOffset.x / scrollView.frame.size.width;
    UIViewController *newsVC = _contentVCArr[index];
    if (index == 2) {
        newsVC.view.backgroundColor = [UIColor yellowColor];
    }
    BOOL isExistVc = YES;
    if (!newsVC.view.superview) {
        NSLog(@"scrollView.bounds -- %@", NSStringFromCGRect(scrollView.bounds));
        newsVC.view.frame = scrollView.bounds;
        [self addSubview:newsVC.view];
        isExistVc = NO;
    }
    //设置topscroll滚动
    if (_rootScrollBlock) {
        _rootScrollBlock(index,newsVC,isExistVc);
    }
}

@end
