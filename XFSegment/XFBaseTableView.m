//
//  XFBaseTableView.m
//  XFSegment
//
//  Created by xixi_wen on 2020/8/11.
//  Copyright © 2020 xixi_wen. All rights reserved.
//

#import "XFBaseTableView.h"

@implementation XFBaseTableView

- (BOOL) gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    UIView *view = otherGestureRecognizer.view;
    NSLog(@"XFBaseTableView:%@", view);
    return YES;
}


@end
