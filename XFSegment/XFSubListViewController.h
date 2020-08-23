//
//  XFSubListViewController.h
//  XFSegment
//
//  Created by xixi_wen on 2020/8/11.
//  Copyright © 2020 xixi_wen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XFBaseTableView.h"
#import "XFBaseCollectionView.h"
#import "HomeViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface XFSubListViewController : UIViewController
@property (nonatomic, strong) XFBaseTableView *tableView;
@property (nonatomic, strong) XFBaseCollectionView *collectView;
@property (nonatomic, weak) HomeViewController *parentVC;
@end

NS_ASSUME_NONNULL_END
