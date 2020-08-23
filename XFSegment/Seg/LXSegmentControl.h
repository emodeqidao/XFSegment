//
//  LXSegmentControl.h
//  Lexuan
//
//  Created by iOS Pro on 2020/5/13.
//  Copyright © 2020 lexuan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LXSegmentControl;
@protocol LXSegmentControlDelegate <NSObject>

- (void)lx_segmentControl:(LXSegmentControl *)segment didSelected:(NSInteger)index;

@end

typedef NS_ENUM(NSInteger, LXSegmentControlAdjustMode) {
    LXSegmentControlAdjustModeCenter = 0,
    LXSegmentControlAdjustModeLeft
};


@interface LXSegmentControl : UIView

@property (nonatomic, assign) CGFloat itemWidth;
@property (nonatomic, assign) CGFloat spacing;
@property (nonatomic, assign) CGFloat lineWidth;
@property (nonatomic, strong) UIFont *itemTitleFont;

@property (nonatomic, assign) NSInteger selectedSegmentIndex;

@property (nonatomic, assign) LXSegmentControlAdjustMode adjustMode;

@property (nonatomic, assign) id <LXSegmentControlDelegate> delegate;

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UIView *lineView;

- (instancetype)initWithItems:(NSArray *)items; // items can be NSStrings or UIImages. control is automatically sized to fit content

- (void)setItems:(NSArray *)items;

- (void)setBadge:(NSString *)badge index:(NSInteger)index;

- (void)showBadge:(BOOL)show index:(NSInteger)index;

- (void)setTitleColor:(UIColor *)color forState:(UIControlState)state;




@end


