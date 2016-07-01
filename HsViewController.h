//
//  HsViewController.h
//  HsScrollNavigationDemo
//
//  Created by dcpSsss on 16/6/29.
//  Copyright © 2016年 dcpSsss. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HsViewController : UIViewController

/**
 *  init
 *
 *  @param titles          标题
 *  @param viewControllers 标题对应的控制器数组
 *
 *  @return <#return value description#>
 */
- (instancetype)initWithTitles:(NSArray <NSString *> *)titles withViewControllers:(NSArray <UIViewController *> *)viewControllers;

/**
 *  add
 *
 *  @param childController 子控制器名字
 *  @param title           标题名字
 */
- (void)addChildViewController:(UIViewController *)childController withTitle:(NSString *)title;

@end
