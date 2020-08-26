//
//  NewSectionCell.m
//  XFSegment
//
//  Created by xixi_wen on 2020/8/24.
//  Copyright © 2020 xixi_wen. All rights reserved.
//

#import "NewSectionCell.h"
#import "UIView+frame.h"

@implementation NewSectionCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        [self.contentView addSubview:self.segment];
//        [self.contentView addSubview:self.containerView];

    }
    return self;
}

- (LXSegmentControl *)segment {
    if (!_segment) {
        _segment = [LXSegmentControl new];
        _segment.itemTitleFont = kFont(13);

        _segment.spacing = 12.0;
        _segment.lineWidth = 28.0;
        _segment.adjustMode = LXSegmentControlAdjustModeLeft;
        _segment.size = CGSizeMake(kScreen_Width, 44.0);
        _segment.top = 0;
        [_segment setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_segment setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        _segment.delegate = (id)self;
    }
    return _segment;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    _segment.frame = CGRectMake(0.0, 0.0, self.width, 50.0);
    _pageController.view.frame = UIEdgeInsetsInsetRect(self.contentView.bounds, UIEdgeInsetsMake(50.0, 0.0, 0.0, 0.0));
}

- (void)setViewControllers:(NSArray<UIViewController *> *)viewControllers {
    _viewControllers = viewControllers.copy;
    
    if (!self.pageController.view.superview) {
        [self.contentView addSubview:self.pageController.view];
    }
    [self setPageIndex:_pageIndex];
}

- (void)setPageIndex:(NSInteger)pageIndex {
    NSInteger count = self.viewControllers.count;
    
    self.segment.selectedSegmentIndex = pageIndex;
    if (count && pageIndex >= 0 && pageIndex < count)
    {
        
        [self.pageController setViewControllers:@[self.viewControllers[pageIndex]]
                                  direction:UIPageViewControllerNavigationDirectionForward
                                   animated:NO
                                 completion:NULL];
        _pageIndex = pageIndex;
    }
}


- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSInteger index = [self.viewControllers indexOfObject:viewController];
    
    if (_viewControllers.count && index > 0) {
        return [self.viewControllers objectAtIndex:index - 1];
    }
    return nil;
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSInteger count = self.viewControllers.count;
    NSInteger index = [self.viewControllers indexOfObject:viewController];
    if (_viewControllers.count && index < count - 1) {
        return [self.viewControllers objectAtIndex:index + 1];
    }
    return nil;
}

- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray *)previousViewControllers transitionCompleted:(BOOL)completed
{
    if (completed && _viewControllers.count) {
        UIViewController * vc = pageViewController.viewControllers.firstObject;
        _pageIndex = [self.viewControllers indexOfObject:vc];
        _segment.selectedSegmentIndex = _pageIndex;
    }
}

- (void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray *)pendingViewControllers
{
//    [self.navigationController setToolbarHidden:YES animated:YES];
}

- (void)lx_segmentControl:(LXSegmentControl *)segment didSelected:(NSInteger)index {
    [self setPageIndex:index];
}

- (UIPageViewController *)pageController {
    if (!_pageController) {
        _pageController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:@{UIPageViewControllerOptionInterPageSpacingKey:@0.f}];
        _pageController.delegate = self;
        _pageController.dataSource = self;
        
        _pageController.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    }
    return _pageController;
}

@end
