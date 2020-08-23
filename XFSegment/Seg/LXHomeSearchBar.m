//
//  LXHomeSearchBar.m
//  Lexuan
//
//  Created by iOS Pro on 2020/5/13.
//  Copyright © 2020 lexuan. All rights reserved.
//

#import "LXHomeSearchBar.h"
#import <objc/runtime.h>
#import "UIView+frame.h"

@interface LXHomeSearchBar ()  <
UITextFieldDelegate
>
{
    struct {
        unsigned shouldBeginEditing: 1;
        unsigned didBeginEditing : 1;
        unsigned didEndingEditing : 1;
        unsigned textDidChange : 1;
        unsigned searchButtonClicked : 1;
        unsigned cancelButtonClicked : 1;
        unsigned shouldChangeTextInRange : 1;
    } _delegateFlag;
    
    unsigned int _methodCount;
    struct objc_method_description *_methodList;
}

@property (nonatomic, strong) UIImageView *background;

@property (nonatomic, strong) UIView *contentView;

@property (nonatomic, strong) UITextField *searchTextField;

@property (nonatomic, strong) UIButton *cancelButton;

@end

@implementation LXHomeSearchBar

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _autoDisplayCancel = YES;
        [self addSubview:self.background];
        [self addSubview:self.contentView];
        [self.contentView addSubview:self.searchTextField];
        [self addSubview:self.cancelButton];
        self.clipsToBounds = YES;
        
        _methodList = protocol_copyMethodDescriptionList(@protocol(UITextInputTraits), NO, YES, &_methodCount);
    }
    return self;
}

- (void)dealloc {
    if (_methodList) {
        free(_methodList);
        _methodList = NULL;
    }
}

- (id)forwardingTargetForSelector:(SEL)aSelector {
    for (int i = 0; i < _methodCount; i++) {
        struct objc_method_description method = _methodList[i];
        if (sel_isEqual(aSelector, method.name)) {
            return self.searchTextField;
        }
    }
    return nil;
}

- (BOOL)becomeFirstResponder {
    return [self.searchTextField becomeFirstResponder];
}

- (BOOL)resignFirstResponder {
    return [self.searchTextField resignFirstResponder];
}

- (BOOL)canBecomeFocused {
    return [self.searchTextField canBecomeFocused];
}

- (BOOL)respondsToSelector:(SEL)aSelector {
    for (int i = 0; i < _methodCount; i++) {
        struct objc_method_description method = _methodList[i];
        if (sel_isEqual(aSelector, method.name)) {
            return YES;
        }
    }
    return [super respondsToSelector:aSelector];
}

+ (BOOL)instancesRespondToSelector:(SEL)aSelector {
    unsigned int methodCount = 0;
    struct objc_method_description *methodList = protocol_copyMethodDescriptionList(@protocol(UITextInputTraits), NO, YES, &methodCount);
    BOOL respond = NO;
    for (int i = 0; i < methodCount; i++) {
        struct objc_method_description method = methodList[i];
        if (sel_isEqual(aSelector, method.name)) {
            respond = YES;
            break;
        }
    }
    free(methodList);
    return respond || [super instancesRespondToSelector:aSelector];
}


- (void)layoutSubviews {
    [super layoutSubviews];
    _background.size = self.size;
    _contentView.layer.cornerRadius = self.height / 2.0;
    _cancelButton.size = CGSizeMake(36.0, self.height);
    
    if (_searchTextField.isEditing && _autoDisplayCancel) {
        [self showCancelAnim:NO];
    } else {
        [self dismissCancelAnim:NO];
    }
}


- (void)showCancelAnim:(BOOL)animated {
    
     void(^block)(void) = ^{
        self.contentView.size = CGSizeMake(self.width - 48.0, self.height);
        self.searchTextField.frame = CGRectInset(self.contentView.bounds, 15.0, 0.0);
        self.cancelButton.right = self.width;
    };
    if (animated) {
        [UIView animateWithDuration:0.2 animations:block];
    } else {
        block();
    }
}

- (void)dismissCancelAnim:(BOOL)animated {
    void(^block)(void) = ^{
        self.contentView.size = self.size;
        self.searchTextField.frame = CGRectInset(self.contentView.bounds, 15.0, 0.0);
        self.cancelButton.left = self.width;
    };
    if (animated) {
        [UIView animateWithDuration:0.2 animations:block];
    } else {
        block();
    }
}

- (void)clickCancelSearch:(id)sender {
    if (_autoDisplayCancel) {
        [self dismissCancelAnim:YES];
    }
    [_searchTextField resignFirstResponder];
    if (_delegateFlag.cancelButtonClicked) {
        [_delegate lx_searchBarCancelButtonClicked:self];
    }
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if (_delegateFlag.shouldBeginEditing) {
        return [_delegate lx_searchBarShouldBeginEditing:self];
    }
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (_delegateFlag.didEndingEditing) {
        [_delegate lx_searchBarTextDidEndEditing:self];
    }
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if (_autoDisplayCancel) {
        [self showCancelAnim:YES];
    }
    if (_delegateFlag.didBeginEditing) {
        [_delegate lx_searchBarTextDidBeginEditing:self];
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (_delegateFlag.shouldChangeTextInRange) {
        return [_delegate lx_searchBar:self shouldChangeTextInRange:range replacementString:string];
    }
    return YES;
}

- (void)textFieldDidChangedText:(UITextField *)textField {
    _text = textField.text;
    if (_delegateFlag.textDidChange) {
        [_delegate lx_searchBar:self textDidChange:textField.text];
    }
}

- (void)textFieldDidSearch:(UITextField *)textField {
    if (_delegateFlag.searchButtonClicked) {
        [_delegate lx_searchBarSearchButtonClicked:self];
    }
}

- (void)setDelegate:(id<LXHomeSearchBarDelegate>)delegate {
    _delegate = delegate;
    
    _delegateFlag.shouldBeginEditing = [delegate respondsToSelector:@selector(lx_searchBarShouldBeginEditing:)];
    _delegateFlag.cancelButtonClicked = [delegate respondsToSelector:@selector(lx_searchBarCancelButtonClicked:)];
    _delegateFlag.didBeginEditing = [delegate respondsToSelector:@selector(lx_searchBarTextDidBeginEditing:)];
    _delegateFlag.didEndingEditing = [delegate respondsToSelector:@selector(lx_searchBarTextDidEndEditing:)];
    _delegateFlag.searchButtonClicked = [delegate respondsToSelector:@selector(lx_searchBarSearchButtonClicked:)];
    _delegateFlag.shouldChangeTextInRange = [delegate respondsToSelector:@selector(lx_searchBar:shouldChangeTextInRange:replacementString:)];
    _delegateFlag.textDidChange = [_delegate respondsToSelector:@selector(lx_searchBar:textDidChange:)];
}

- (void)setText:(NSString *)text {
    _text = text;
    _searchTextField.text = text;
}

- (void)setPlaceholder:(NSString *)placeholder {
    _placeholder = placeholder;
    _searchTextField.placeholder = placeholder;
}

- (void)setAttributedPlaceholder:(NSAttributedString *)attributedPlaceholder {
    _attributedPlaceholder = attributedPlaceholder;
    _searchTextField.attributedPlaceholder = attributedPlaceholder;
}


- (UIImageView *)background {
    if (!_background) {
        _background = [UIImageView new];
        _background.clipsToBounds = YES;
    }
    return _background;
}

- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [UIView new];
        _contentView.backgroundColor = [UIColor.whiteColor colorWithAlphaComponent:0.8];

    }
    return _contentView;
}

- (UITextField *)searchTextField {
    if (!_searchTextField) {
        _searchTextField = [[UITextField alloc] init];
        UIView *leftView = [UIView new];
        leftView.size = CGSizeMake(26.0, 22.0);
        UIImageView *sicon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_search_b"]];
        sicon.center = CGPointMake(11.0, 11.0);
        [leftView addSubview:sicon];
        
        
        _searchTextField.leftView = leftView;
        _searchTextField.leftViewMode = UITextFieldViewModeAlways;
        _searchTextField.delegate = self;
        _searchTextField.text = self.text;
        _searchTextField.placeholder = self.placeholder;
        _searchTextField.attributedPlaceholder = self.attributedPlaceholder;
        _searchTextField.font = [UIFont systemFontOfSize:13.0];
        _searchTextField.textColor = UIColor.darkTextColor;
        _searchTextField.returnKeyType = UIReturnKeyDone;
//        _searchTextField.tintColor = [UIColor whiteColor];
        _searchTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        [_searchTextField addTarget:self action:@selector(textFieldDidChangedText:) forControlEvents:UIControlEventEditingChanged];
        [_searchTextField addTarget:self action:@selector(textFieldDidSearch:) forControlEvents:UIControlEventEditingDidEndOnExit];
    }
    return _searchTextField;
}


- (UIButton *)cancelButton {
    if (!_cancelButton) {
        _cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _cancelButton.titleLabel.font = [UIFont systemFontOfSize:17.0];
        [_cancelButton setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        [_cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelButton addTarget:self action:@selector(clickCancelSearch:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelButton;
}



@end
