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

NS_ASSUME_NONNULL_BEGIN

@interface XFSubListViewController : UIViewController
@property (nonatomic, strong) XFBaseTableView *tableView;
@property (nonatomic, strong) XFBaseCollectionView *collectView;
@end

NS_ASSUME_NONNULL_END
