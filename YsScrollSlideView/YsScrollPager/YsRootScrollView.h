//
//  YsRootScrollView.h
//  ScrollSlideView
//
//  Created by weiying on 16/3/15.
//  Copyright © 2016年 Yuns. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^YsRootScrollBlock)(NSInteger index, UIViewController *VC, BOOL isExistVC);

@interface YsRootScrollView : UIScrollView<UIScrollViewDelegate>
/**子控制器数组*/
@property (nonatomic, strong) NSArray *contentVCArr;
/**底部滚动事件*/
@property (nonatomic, copy) YsRootScrollBlock rootScrollBlock;
/**底部滚动*/
- (void)rootContentOffsetWithIndex:(NSInteger)index;
@end
