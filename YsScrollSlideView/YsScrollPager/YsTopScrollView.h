//
//  YsTopScrollView.h
//  ScrollSlideView
//
//  Created by weiying on 16/3/15.
//  Copyright © 2016年 Yuns. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^YsTopClickBlock)(NSInteger index);

@interface YsTopScrollView : UIScrollView
/**标题数组*/
@property (nonatomic, strong) NSArray *titleNameArr;
/**选中下标*/
@property (nonatomic, assign) NSInteger titleSelectIndex;
/**选中标题下标*/
@property (nonatomic, strong) UIView *selectLineView;
/**标题选中字体*/
@property (nonatomic, strong) UIFont *selectFont;
/**标题普通字体*/
@property (nonatomic, strong) UIFont *normalFont;
/**标题选中颜色*/
@property (nonatomic, strong) UIColor *selectColor;
/**标题普通颜色*/
@property (nonatomic, strong) UIColor *normalColor;
/**是否平分一个屏幕的宽度*/
@property (nonatomic, assign) BOOL isAVGTopWidth;
/**顶部滚动栏点击事件*/
@property (nonatomic, copy) YsTopClickBlock topClickBlock;
/**顶部栏滚动*/
- (void)topContentOffsetWithIndex:(NSInteger)index;

@end
