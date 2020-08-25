//
//  NewSectionCell.m
//  XFSegment
//
//  Created by xixi_wen on 2020/8/24.
//  Copyright © 2020 xixi_wen. All rights reserved.
//

#import "NewSectionCell.h"

@implementation NewSectionCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        UILabel *sectionLabel = [[UILabel alloc] initWithFrame:SetFrame(0, 0, 200, 50)];
        sectionLabel.text = @"我是new section";
        sectionLabel.font = [UIFont systemFontOfSize:16.f];
        sectionLabel.backgroundColor = [UIColor yellowColor];
        [self addSubview:sectionLabel];
        
        [self.contentView addSubview:self.containerView];

    }
    return self;
}

- (UIScrollView *)containerView{
    if (!_containerView ) {
        _containerView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height)];
        _containerView.backgroundColor = [UIColor purpleColor];
    }
    return _containerView;
}

@end
