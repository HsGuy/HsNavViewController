//
//  Created by dcpSsss on 16/4/11.
//  Copyright © 2016年 dcpSsss. All rights reserved.
//

#import "HsScrollTitleView.h"

#define kScreenWidth                        [[UIScreen mainScreen] bounds].size.width
#define kScreenHeight                       [[UIScreen mainScreen] bounds].size.height

@interface HsScrollTitleView(){
    CGFloat         _customH;
    CGFloat         _customW;
    CGFloat         _totalW;//所有title文字的宽度
    CGFloat         _margin;
    NSArray         *_titles;
    NSMutableArray  *_titleWidths;//titleWidth
    UIFont          *_kFont; //font of title
    UIView          *_line;
    NSMutableArray  *_xLines;//xOriginal of line
    CGFloat         _kWidth;//如果把本视图当做navigation的titleView 那么左右总是会各有10.f的偏移；
}

@end

@implementation HsScrollTitleView

- (instancetype)initWithFrame:(CGRect)frame withTitles:(NSArray *)titles withTitleFont:(UIFont *)font
{
    self = [super initWithFrame:frame];
    if (self) {
        _kWidth = kScreenWidth - 20;
        _titles = [NSArray arrayWithArray:titles];
        _titleWidths = [NSMutableArray array];
        _xLines = [NSMutableArray array];
        _customH = frame.size.height;
        _customW = frame.size.width ;
        _kFont = font;
        [self getTitleWidths];
        [self customAppearance];
    }
    return self;
}

- (void)customAppearance{
    self.contentSize = CGSizeMake(_customW , _customH);
    self.showsVerticalScrollIndicator = NO;
    self.showsHorizontalScrollIndicator = NO;
    CGFloat btnH = _customH - 2;
    CGFloat xOffset = _margin;
    for (NSInteger i = 0; i < _titles.count; i++) {
        CGFloat btnW = [_titleWidths[i] floatValue];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(xOffset, 0, btnW, btnH)];
        label.userInteractionEnabled = YES;
        label.textColor = [UIColor blackColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = _kFont;
        label.text = _titles[i];
        label.tag = i;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(titleButtonClick:)];
        [label addGestureRecognizer:tap];
        [self addSubview:label];
        
        [_xLines addObject:[NSString stringWithFormat:@"%.2f",xOffset]];
        xOffset = xOffset + btnW +_margin;
    }
    _line = [[UIView alloc] initWithFrame:CGRectMake(_margin, _customH - 2, [_titleWidths[0] floatValue], 2)];
    _line.backgroundColor = [UIColor orangeColor];
    [self addSubview:_line];
}

- (void)titleButtonClick:(UITapGestureRecognizer *)sender{
    if (self.titleViewDelegate && [self.titleViewDelegate respondsToSelector:@selector(didSelectedTitleAtIndex:)]) {
        [self.titleViewDelegate didSelectedTitleAtIndex:sender.view.tag];
    }
    [self setTitleIndex:sender.view.tag withAnimations:YES];
}

- (void)getTitleWidths{
    for (NSString *str in _titles) {
        CGSize strSize = [str sizeWithAttributes:@{NSFontAttributeName:_kFont}];
        [_titleWidths addObject:[NSString stringWithFormat:@"%.2f",strSize.width + 2]];
        _totalW += strSize.width + 2;
    }
    _margin = 10.f;
    _customW = _totalW + _margin * (_titles.count);
}

-(void)setTitleIndex:(NSInteger)index withAnimations:(BOOL)animation{
    
    if (animation) {
        
        [UIView animateWithDuration:0.3 animations:^{
            [self movieTitleToIndex:index];
        }];
    }else{
        [self movieTitleToIndex:index];
    }
}

- (void)movieTitleToIndex:(NSInteger)index{
    CGFloat xOriginalOffset = [_xLines[index] floatValue];
    CGRect bottomLineRect = _line.frame;
    bottomLineRect.origin.x = xOriginalOffset;
    bottomLineRect.size.width = [_titleWidths[index] floatValue];
    _line.frame = bottomLineRect;
    CGFloat xOffset = xOriginalOffset + _line.frame.size.width / 2 - _kWidth / 2;
    if (xOriginalOffset > _kWidth /2  && xOffset + _kWidth / 2 <_customW - _kWidth/2 ) {
        self.contentOffset = CGPointMake( xOffset , 0);
    }else if (xOffset + _kWidth / 2 >= _customW - _kWidth/2){
        self.contentOffset = CGPointMake(_customW - _kWidth, 0);
    }else{
        self.contentOffset = CGPointZero;
    }
}

@end
