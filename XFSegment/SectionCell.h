//
//  SectionCell.h
//  XFSegment
//
//  Created by xixi_wen on 2020/8/11.
//  Copyright © 2020 xixi_wen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeViewController.h"
#import "XFBaseTableView.h"

NS_ASSUME_NONNULL_BEGIN

@interface SectionCell : UICollectionViewCell
@property (nonatomic, strong) XFBaseTableView *tableView;
@property (nonatomic, strong) HomeViewController *parentVC;
@end

NS_ASSUME_NONNULL_END
