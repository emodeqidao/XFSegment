//
//  HomeViewController.h
//  XFSegment
//
//  Created by xixi_wen on 2020/8/11.
//  Copyright © 2020 xixi_wen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XFBaseCollectionView.h"


NS_ASSUME_NONNULL_BEGIN

@interface HomeViewController : UIViewController

@property (nonatomic, strong) XFBaseCollectionView *collectView;
@property (nonatomic, assign) BOOL canScroll;


@end

NS_ASSUME_NONNULL_END
