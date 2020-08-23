//
//  LXSegmentControl.m
//  Lexuan
//
//  Created by iOS Pro on 2020/5/13.
//  Copyright © 2020 lexuan. All rights reserved.
//

#import "LXSegmentControl.h"
#import "NSString+WidthHeight.h"
#import <objc/runtime.h>
#import "UIView+frame.h"
#define kDWidth 90.0

@implementation LXSegmentControl
{
    NSMutableDictionary *_titleColorDic;
    NSMutableArray <UIButton *>*_segments;
    NSArray *_items;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]){
        [self prepare];
    }
    return self;
}

- (instancetype)initWithItems:(NSArray *)items
{
    if (self = [super init]){
        [self prepare];
        [self setItems:items];
    }
    return self;
}

- (void)setItems:(NSArray *)items
{
    if (_items != items) {
        _items = items.copy;
    }
    [self.scrollView.subviews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [(UIView *)obj removeFromSuperview];
    }];
    [_segments removeAllObjects];
    
    Class cls = NSString.class;
    BOOL isString = [cls isSubclassOfClass:[NSString class]];
    BOOL isImage = [cls isSubclassOfClass:[UIImage class]];
    
    void (^btnSetContent)(UIButton *btn, id title) = ({
        isString ?
        ^(UIButton *btn, id title) {
            [btn setTitle:title forState:UIControlStateNormal];
        }
        : isImage ?
        ^(UIButton *btn, id image) {
            [btn setImage:image forState:UIControlStateNormal];
        }
        : ^(UIButton *btn, id obj) {};
    });
    
    [self.scrollView addSubview:self.lineView];
    
    UIFont *font = _itemTitleFont ?: [UIFont systemFontOfSize:15.0];
    for (NSInteger idx = 0; idx < items.count; idx ++) {
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_segments addObject:btn];
        btn.titleLabel.font = font;
        [btn setTitleColor:_titleColorDic[@(UIControlStateSelected)] forState:UIControlStateSelected];
        [btn setTitleColor:_titleColorDic[@(UIControlStateNormal)] forState:UIControlStateNormal];
        btnSetContent(btn, items[idx]);
        btn.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        [self layoutItemIndex:idx btn:btn];
        [self.scrollView addSubview:btn];
        btn.selected = idx == 0;
        [btn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    self.scrollView.contentSize = CGSizeMake(self.scrollView.subviews.lastObject.right, 0);
    
    if (self.adjustMode == LXSegmentControlAdjustModeCenter &&
        self.scrollView.contentSize.width > self.frame.size.width) {
        self.adjustMode = LXSegmentControlAdjustModeLeft;
    }
    [self setNeedsLayout];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    //    _lineView.frame = CGRectMake(_lineView.frame.origin.x, self.frame.size.height - 2, _lineView.frame.size.width, 2.0);
    [self updateLineLayer];
    
    [self adjustContentSize];
}

- (void)layoutItemIndex:(NSInteger)index btn:(UIButton *)btn {
    if (_itemWidth > 0.001) {
        CGSize size = CGSizeMake(_itemWidth, self.height);
        btn.frame = CGRectMake( (_itemWidth + _spacing)* index, 7.0, size.width, size.height - 10.0);
    } else {
        UIFont *font = [btn.titleLabel.font fontWithSize:btn.titleLabel.font.pointSize + 3];
        CGFloat width = MAX([btn.currentTitle widthForFont:font], btn.imageView.image.size.width) + 6.0;
        CGSize size = CGSizeMake(width, self.height);
        CGFloat ox = 0.0;
        if (index > 0) {
            ox = (_segments[index - 1]).right + _spacing;
        }
        btn.frame = CGRectMake( ox, 7.0, size.width, size.height - 10.0);
    }
}

- (void)adjustContentSize {
    if (self.scrollView.contentSize.width < self.frame.size.width && (self.adjustMode == LXSegmentControlAdjustModeCenter)) {
        CGFloat left = (self.frame.size.width - self.scrollView.contentSize.width) / 2;
        self.scrollView.contentInset = UIEdgeInsetsMake(0, left, 0, left);
    }  else  {
        self.scrollView.contentInset = UIEdgeInsetsMake(0, 15.0, 0, 15.0);
    }
}


- (void)setItemWidth:(CGFloat)itemWidth {
    _itemWidth = itemWidth;
    [_segments enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self layoutItemIndex:idx btn:obj];
    }];
    self.scrollView.contentSize = CGSizeMake(_segments.lastObject.right, 0);
    [self setNeedsLayout];
}

- (void)setSpacing:(CGFloat)spacing {
    _spacing = spacing;
    
    [_segments enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self layoutItemIndex:idx btn:obj];
    }];
    self.scrollView.contentSize = CGSizeMake(_segments.lastObject.right, 0);
    [self setNeedsLayout];
}

- (void)setItemTitleFont:(UIFont *)itemTitleFont {
    _itemTitleFont = itemTitleFont;
    [self setItems:_items];
}

- (void)setLineWidth:(CGFloat)lineWidth {
    _lineWidth = lineWidth;
    [self updateLineLayer];
}

- (void)setAdjustMode:(LXSegmentControlAdjustMode)adjustMode {
    _adjustMode = adjustMode;
    [_segments enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self layoutItemIndex:idx btn:obj];
    }];
    self.scrollView.contentSize = CGSizeMake(_segments.lastObject.right, 0);
    [self setNeedsLayout];
}

- (void)clickBtn:(UIButton *)sender {
    self.selectedSegmentIndex = [_segments indexOfObject:sender];
    if ([self.delegate respondsToSelector:@selector(lx_segmentControl:didSelected:)]) {
        [self.delegate lx_segmentControl:self didSelected:self.selectedSegmentIndex];
    }
}

- (void)setSelectedSegmentIndex:(NSInteger)selectedSegmentIndex{
    _selectedSegmentIndex = selectedSegmentIndex;

//    if (selectedSegmentIndex >= _segments.count) {
//        return;
//    }
//    UIButton *btn = (UIButton *)[_segments objectAtIndex:selectedSegmentIndex];
//    [_segments enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
//        [(UIButton *)obj setSelected:NO];
//    }];
//    [btn setSelected:YES];
//    [self updateLineLayer];

    
    if (_segments.count && selectedSegmentIndex < _segments.count) {

        UIFont *font = _itemTitleFont ?: [UIFont systemFontOfSize:15.0];
        
        UIButton *btn = (UIButton *)[_segments objectAtIndex:selectedSegmentIndex];
        [_segments enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            [(UIButton *)obj setSelected:NO];
            [(UIButton *)obj titleLabel].font = font;
        }];
        btn.titleLabel.font = [font fontWithSize:font.pointSize + 3];
        [btn setSelected:YES];
        [self updateLineLayer];
        
        if (btn.right > _scrollView.contentOffset.x + _scrollView.width) {
            [_scrollView setContentOffset:CGPointMake(btn.right - _scrollView.width, 0.0) animated:YES];
        } else if (btn.left < _scrollView.contentOffset.x) {
            [_scrollView setContentOffset:CGPointMake(btn.left, 0.0) animated:YES];
        }
    }
}

- (void)setBadge:(NSString *)badge index:(NSInteger)index {
}

- (void)showBadge:(BOOL)show index:(NSInteger)index {
}

- (void)setTitleColor:(nullable UIColor *)color forState:(UIControlState)state {
    if (!color) {
        return;
    }
    _titleColorDic[@(state)] = color;
    if (state == UIControlStateSelected) {
        [self.lineView setBackgroundColor:color];
    }
    [_segments enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [(UIButton *)obj setTitleColor:color forState:state];
    }];
}

- (void)prepare
{
    _spacing = 8.0;
    _segments = [NSMutableArray array];
    _titleColorDic = [@{
        @(UIControlStateSelected):[UIColor whiteColor],
        @(UIControlStateNormal):[[UIColor whiteColor] colorWithAlphaComponent:0.5]
    } mutableCopy];
    [self addSubview:self.scrollView];
    [self.scrollView addSubview:self.lineView];
}

- (void)updateLineLayer
{
    self.lineView.hidden = !_segments.count;
    if (!_segments.count || self.selectedSegmentIndex >= _segments.count) {
        return;
    }
    
    UIButton *btn = [_segments objectAtIndex:self.selectedSegmentIndex];
    CGFloat lineWidth = _lineWidth;
    if (lineWidth <= 0.0001) {
        lineWidth = [btn.currentTitle widthForFont:btn.titleLabel.font] + 10.0;
    }
    self.lineView.width = lineWidth;
    
    CGPoint center = self.lineView.center;
    center.x = [btn center].x;
    
    [UIView beginAnimations:nil context:nil];
    self.lineView.center = center;
    [UIView commitAnimations];
}

- (UIScrollView *)scrollView
{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
    }
    return _scrollView;
}

- (UIView *)lineView
{
    if (!_lineView) {
        _lineView = [UIView new];
        _lineView.backgroundColor = [UIColor whiteColor];
        _lineView.frame = CGRectMake(0.0, self.frame.size.height - 4.0, 47.0, 2.0);
        _lineView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
        _lineView.layer.cornerRadius = 1.0;
        _lineView.clipsToBounds = YES;
    }
    return _lineView;
}


@end
