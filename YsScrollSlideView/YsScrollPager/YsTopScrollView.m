//
//  YsTopScrollView.m
//  ScrollSlideView
//
//  Created by weiying on 16/3/15.
//  Copyright © 2016年 Yuns. All rights reserved.
//

#import "YsTopScrollView.h"

#define Ys_kTitleTagBase 100
#define Ys_kLineViewHight 2
#define ys_kTitleBtnMargin 20

@implementation YsTopScrollView
{
    NSInteger _lastSelectIndex;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.pagingEnabled = NO;
        self.showsVerticalScrollIndicator = NO;
        self.showsHorizontalScrollIndicator = NO;
        _lastSelectIndex = Ys_kTitleTagBase;
        _normalFont = [UIFont systemFontOfSize:16];
        _selectFont = [UIFont boldSystemFontOfSize:16];
        _normalColor = [UIColor blueColor];
        _selectColor = [UIColor whiteColor];
        _isAVGTopWidth = NO;
    }
    return self;
}

//获取标题数组
- (void)setTitleNameArr:(NSArray *)titleNameArr
{
    _titleNameArr = titleNameArr;
    [self setupNameTitle];
    [self setupSelectLine];
    //调用set方法，选中标题
    self.titleSelectIndex = 0;
}

//创建顶部标题
- (void)setupNameTitle
{
    CGFloat titleScrollW = 0;
    for (NSInteger i = 0; i < _titleNameArr.count; i ++) {
        NSString *titleName = _titleNameArr[i];
        UIButton *titleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        //设置按钮选中状态和普通状态的样式
        NSMutableAttributedString *mAttriNormalStr = [[NSMutableAttributedString alloc] initWithString:titleName];
        [mAttriNormalStr addAttribute:NSFontAttributeName value:_normalFont range:NSMakeRange(0, titleName.length)];
        [mAttriNormalStr addAttribute:NSForegroundColorAttributeName value:_normalColor range:NSMakeRange(0, titleName.length)];
        [titleBtn setAttributedTitle:mAttriNormalStr forState:UIControlStateNormal];
        
        NSMutableAttributedString *mAttriSelectStr = [[NSMutableAttributedString alloc] initWithString:titleName];
        [mAttriSelectStr addAttribute:NSFontAttributeName value:_selectFont range:NSMakeRange(0, titleName.length)];
        [mAttriSelectStr addAttribute:NSForegroundColorAttributeName value:_selectColor range:NSMakeRange(0, titleName.length)];
        [titleBtn setAttributedTitle:mAttriSelectStr forState:UIControlStateSelected];
        //设置按钮的宽度
        CGFloat labelW = 0;
        if (_isAVGTopWidth) {
            labelW = self.frame.size.width / _titleNameArr.count;
        }else{
            CGFloat titleBtnW = [self titleWidthWithString:titleName font:titleBtn.titleLabel.font].width;
            labelW = titleBtnW + ys_kTitleBtnMargin;
        }
        CGFloat lableH = self.frame.size.height;
        CGFloat labelY = 0;
        CGFloat labelX = titleScrollW;
        titleScrollW += labelW;
        titleBtn.frame = CGRectMake(labelX, labelY, labelW, lableH);
        titleBtn.tag = i + Ys_kTitleTagBase;
        if (i == 0) {
            titleBtn.selected = YES;
        }
        [titleBtn addTarget:self action:@selector(titleButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:titleBtn];
    }
    //顶部标题相加的总宽度小于topscroll.frame的宽度
    if (titleScrollW < self.frame.size.width) {
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, titleScrollW, self.frame.size.height);
    }
    self.contentSize = CGSizeMake(titleScrollW, 0);
    
}

//创建选中下划线
- (void)setupSelectLine
{
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = [UIColor whiteColor];
    CGRect lineFrame = lineView.frame;
    lineFrame.size.height = 2;
    lineView.frame = lineFrame;
    [self addSubview:lineView];
    self.self.selectLineView = lineView;
}

//设置默认选中项
- (void)setTitleSelectIndex:(NSInteger)titleSelectIndex
{
    _titleSelectIndex = titleSelectIndex + Ys_kTitleTagBase;
    
    if (_topClickBlock) {
        _topClickBlock(titleSelectIndex);
    }
    
    //将选中的按钮变为非选中状态
    for (NSInteger i = 0; i < self.subviews.count; i ++) {
        if ([self.subviews[i] isKindOfClass:[UIButton class]]) {
            UIButton *titleBtn = (UIButton *)self.subviews[i];
            if (titleBtn.selected) {
                titleBtn.selected = NO;
            }
            self.selectLineView.frame = CGRectMake(titleBtn.frame.origin.x, self.frame.size.height - self.selectLineView.frame.size.height, titleBtn.frame.size.width, self.selectLineView.frame.size.height);
        }
    }
    
    //计算标题下标显示
    if ([self.subviews[titleSelectIndex] isKindOfClass:[UIButton class]]) {
        UIButton *titleBtn = (UIButton *)self.subviews[titleSelectIndex];
        titleBtn.selected = YES;
        self.selectLineView.frame = CGRectMake(titleBtn.frame.origin.x, self.frame.size.height - self.selectLineView.frame.size.height, titleBtn.frame.size.width, self.selectLineView.frame.size.height);
    }
}

//设置顶部滚动条偏移
- (void)topContentOffsetWithIndex:(NSInteger)index
{
    //滚动标题栏
    if ([self.subviews[index] isKindOfClass:[UIButton class]]) {
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
        //计算标题下标显示
        self.selectLineView.frame = CGRectMake(titleBtn.frame.origin.x, self.frame.size.height - self.selectLineView.frame.size.height, titleBtn.frame.size.width, self.selectLineView.frame.size.height);
    }
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
            _topClickBlock(sender.tag - Ys_kTitleTagBase);
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
