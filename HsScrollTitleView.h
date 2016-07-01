//
//  Created by dcpSsss on 16/4/11.
//  Copyright © 2016年 dcpSsss. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HsScrollTitleViewDelegate <NSObject>

- (void)didSelectedTitleAtIndex:(NSInteger)index;

@end

@interface HsScrollTitleView : UIScrollView

@property (nonatomic,weak) id <HsScrollTitleViewDelegate>titleViewDelegate;

-(instancetype)initWithFrame:(CGRect)frame withTitles:(NSArray *)titles withTitleFont:(UIFont *)font;

- (void)setTitleIndex:(NSInteger)index withAnimations:(BOOL)animation;

@end
