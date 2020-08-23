//
//  XFBaseCollectionView.m
//  XFSegment
//
//  Created by xixi_wen on 2020/8/11.
//  Copyright © 2020 xixi_wen. All rights reserved.
//

#import "XFBaseCollectionView.h"

@implementation XFBaseCollectionView

- (BOOL) gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    UIView *view = otherGestureRecognizer.view;
////    NSLog(@"%@", view);
////    if ([[view superview] isKindOfClass:[WKWebView class]]) {
////        view = [view superview];
////    }
////    NSLog(@"!! array: %@", _allowGestureSimultaneouslyViewsArray);
////    NSLog(@"!!: %@", view);
    if ([_allowGestureSimultaneouslyViewsArray containsObject:view]) {
        return YES;
    } else {
        return NO;
    }
}

@end
