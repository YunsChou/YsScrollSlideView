//
//  YsTopScrollView.m
//  ScrollSlideView
//
//  Created by weiying on 16/3/15.
//  Copyright © 2016年 Yuns. All rights reserved.
//

#import "YsTopScrollView.h"

#define Ys_KTitleTagBase 100

@implementation YsTopScrollView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.pagingEnabled = NO;
        self.showsVerticalScrollIndicator = NO;
        self.showsHorizontalScrollIndicator = NO;
        _titleSelectIndex = Ys_KTitleTagBase;
    }
    return self;
}

- (void)setTitleNameArr:(NSArray *)titleNameArr
{
    _titleNameArr = titleNameArr;
    [self setupNameTitle];
}

- (void)setupNameTitle
{
    CGFloat titleScrollW = 0;
    for (NSInteger i = 0; i < _titleNameArr.count; i ++) {
        NSString *titleName = _titleNameArr[i];
        UIButton *titleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [titleBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [titleBtn setTitleColor:[UIColor blueColor] forState:UIControlStateSelected];
        [titleBtn setTitle:titleName forState:UIControlStateNormal];
        CGFloat titleBtnW = [self titleWidthWithString:titleName font:titleBtn.titleLabel.font].width;
        CGFloat labelW = titleBtnW + 16;
        CGFloat lableH = 40;
        CGFloat labelY = 0;
        CGFloat labelX = titleScrollW;
        titleScrollW += labelW;
        titleBtn.frame = CGRectMake(labelX, labelY, labelW, lableH);
        titleBtn.tag = i + Ys_KTitleTagBase;
        if (i == 0) {
            titleBtn.selected = YES;
        }
        [titleBtn addTarget:self action:@selector(titleButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:titleBtn];
    }
    if (titleScrollW < self.frame.size.width) {
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, titleScrollW, self.frame.size.height);
    }
    self.contentSize = CGSizeMake(titleScrollW, 40);
    //调用set方法，选中标题
    self.titleSelectIndex = 0;
}

- (void)setTitleSelectIndex:(NSInteger)titleSelectIndex
{
    _titleSelectIndex = titleSelectIndex + Ys_KTitleTagBase;
    if (_topClickBlock) {
        _topClickBlock(titleSelectIndex);
    }
}

- (void)topContentOffsetWithIndex:(NSInteger)index
{
    //滚动标题栏
    UIButton *titleBtn = (UIButton *)self.subviews[index];
    if (!titleBtn.selected) {
        titleBtn.selected = YES;
    }
    [self titleButtonClick:titleBtn];
    //计算标题栏显示
    CGFloat offsetX = titleBtn.center.x - self.frame.size.width / 2;
    CGFloat offsetMax = self.contentSize.width - self.frame.size.width;
    if (offsetX < 0) {
        offsetX = 0;
    }else if (offsetX > offsetMax){
        offsetX = offsetMax;
    }
    CGPoint offset = CGPointMake(offsetX, self.contentOffset.y);
    [self setContentOffset:offset animated:YES];
}

#pragma mark - 按钮点击事件
- (void)titleButtonClick:(UIButton *)sender
{
    //更换按钮
    if (sender.tag != _titleSelectIndex) {
        //取消之前的按钮
        UIButton *lastBtn = (UIButton *)[self viewWithTag:_titleSelectIndex];
        lastBtn.selected = NO;
        _titleSelectIndex = sender.tag;
    }
    
    if (!sender.selected) {
        sender.selected = YES;
        //设置rootscroll滚动
        if (_topClickBlock) {
            _topClickBlock(sender.tag - Ys_KTitleTagBase);
        }
    }
}

//计算文本的自适应高度
- (CGSize)titleWidthWithString:(NSString *)string font:(UIFont *)font
{
    //设置号文字的属性
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    attributes[NSFontAttributeName] = font;
    //设置好文字的区域范围，最大宽度固定，高度默认无限高
    CGSize maxSize = CGSizeMake(MAXFLOAT, MAXFLOAT);
    //将文字的区域范围传入，选择属性，传入文字的属性
    CGSize realSize = [string boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    //取出size返回
    return realSize;
}

@end
