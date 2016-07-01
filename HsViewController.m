//
//  HsViewController.m
//  HsScrollNavigationDemo
//
//  Created by dcpSsss on 16/6/29.
//  Copyright © 2016年 dcpSsss. All rights reserved.
//

#import "HsViewController.h"
#import "HsScrollTitleView.h"


#define screenW [UIScreen mainScreen].bounds.size.width
#define screenH [UIScreen mainScreen].bounds.size.height

@interface HsViewController ()<HsScrollTitleViewDelegate>{
    NSMutableArray              *_titlesArray;
    NSMutableArray              *_viewControllers;
    HsScrollTitleView           *_titleView;
    UIView                      *_containerView;
    NSInteger                   *_previousIndex;
    UIViewController            *_previousVC;
}

@end

@implementation HsViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initArray];
    }
    return self;
}

-(instancetype)initWithTitles:(NSArray<NSString *> *)titles withViewControllers:(NSArray<UIViewController *> *)viewControllers{
    if (self == [super init]) {
        [self initArray];
        _titlesArray            = [NSMutableArray arrayWithArray:titles];
        _viewControllers        = [NSMutableArray arrayWithArray:viewControllers];
    }
    return self;
}

-(void)addChildViewController:(UIViewController *)childController withTitle:(NSString *)title{
    [_titlesArray addObject:title];
    [_viewControllers addObject:childController];
}

- (void)initArray{
    _titlesArray                = [NSMutableArray array];
    _viewControllers            = [NSMutableArray array];
}

- (void)customAppearance{
    _titleView                  = [[HsScrollTitleView alloc] initWithFrame:CGRectMake(0, 0, screenW, 40) withTitles:_titlesArray withTitleFont:[UIFont systemFontOfSize:17]];
    _titleView.titleViewDelegate = self;
    [self.view addSubview:_titleView];
    
    _containerView              = [[UIView alloc] initWithFrame:CGRectMake(0, _titleView.frame.size.height, screenW, screenH - _titleView.frame.size.height)];
    _containerView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_containerView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self customAppearance];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (_viewControllers.count) {
        [self addChildViewController:_viewControllers[0]];
        [_containerView addSubview:[_viewControllers[0] view]];
        _previousVC             = _viewControllers[0];
    }
}

- (void)didSelectedTitleAtIndex:(NSInteger)index{
    [self replaceOldVC:_previousVC withNewVC:_viewControllers[index]];
}

- (void)replaceOldVC:(UIViewController *)oldVC withNewVC:(UIViewController *)newVC{
    _previousVC                 = oldVC;
    [self addChildViewController:newVC];
    [self transitionFromViewController:oldVC toViewController:newVC duration:2 options:UIViewAnimationOptionRepeat animations:^{
        
    } completion:^(BOOL finished) {
        
        [newVC didMoveToParentViewController:self];
        [oldVC willMoveToParentViewController:nil];
        [_containerView addSubview:newVC.view];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
