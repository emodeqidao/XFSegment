//
//  NewSectionCell.h
//  XFSegment
//
//  Created by xixi_wen on 2020/8/24.
//  Copyright © 2020 xixi_wen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LXSegmentControl.h"
#import "XFSubListViewController.h"


NS_ASSUME_NONNULL_BEGIN

@interface NewSectionCell : UICollectionViewCell
<UIPageViewControllerDataSource, UIPageViewControllerDelegate>
@property (nonatomic, assign) NSInteger selectedIndex;
@property (nonatomic, strong) LXSegmentControl *segment;
@property (nonatomic, strong) UIScrollView *containerView;
@property (nonatomic, strong) NSMutableArray *viewControllers;

@property (nonatomic, assign) NSInteger pageIndex;

@property (nonatomic, strong) UIPageViewController *pageController;
@property (nonatomic, weak) UIViewController *parentVC;
@end

NS_ASSUME_NONNULL_END
