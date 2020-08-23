//
//  TopViewController.h
//  XFSegment
//
//  Created by xixi_wen on 2020/8/22.
//  Copyright © 2020 xixi_wen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LXSegmentControl.h"
#import "HomeViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface TopViewController : UIViewController

@property (nonatomic, strong) LXSegmentControl *segment;
@property (nonatomic, strong) UIViewController *child;
@property (nonatomic, strong) NSMutableArray<UIViewController *> *viewControllerArray;

@end

NS_ASSUME_NONNULL_END
