//
//  BaseTestController.m
//  YsScrollSlideView
//
//  Created by weiying on 16/3/22.
//  Copyright © 2016年 Yuns. All rights reserved.
//

/**
 *  颜色的R,G,B,A
 */
#define RGBA(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a]
/**
 *  随机色
 */
#define RandomColor RGBA(arc4random_uniform(256),arc4random_uniform(256),arc4random_uniform(256),1.0)

#import "BaseTestController.h"

@interface BaseTestController ()

@end

@implementation BaseTestController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RandomColor;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
