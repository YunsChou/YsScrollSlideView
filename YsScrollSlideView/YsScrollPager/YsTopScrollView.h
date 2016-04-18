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
/**顶部滚动栏点击事件*/
@property (nonatomic, copy) YsTopClickBlock topClickBlock;
/**顶部栏滚动*/
- (void)topContentOffsetWithIndex:(NSInteger)index;

@end
