//
//  XFBaseCollectionView.h
//  XFSegment
//
//  Created by xixi_wen on 2020/8/11.
//  Copyright © 2020 xixi_wen. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XFBaseCollectionView : UICollectionView
@property (nonatomic, strong) NSMutableArray *allowGestureSimultaneouslyViews;
@end

NS_ASSUME_NONNULL_END
