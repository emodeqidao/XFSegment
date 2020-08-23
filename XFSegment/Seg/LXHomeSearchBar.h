//
//  LXHomeSearchBar.h
//  Lexuan
//
//  Created by iOS Pro on 2020/5/13.
//  Copyright © 2020 lexuan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LXHomeSearchBar;
@protocol LXHomeSearchBarDelegate <NSObject>

@optional;
- (BOOL)lx_searchBarShouldBeginEditing:(LXHomeSearchBar *)searchBar;                      // return NO to not become first responder

- (void)lx_searchBarTextDidBeginEditing:(LXHomeSearchBar *)searchBar;                     // called when text starts editing

- (void)lx_searchBarTextDidEndEditing:(LXHomeSearchBar *)searchBar;                       // called when text ends editing

- (void)lx_searchBar:(LXHomeSearchBar *)searchBar textDidChange:(NSString *)searchText;   // called when text changes (including clear)

- (void)lx_searchBarSearchButtonClicked:(LXHomeSearchBar *)searchBar;                     // called when keyboard search button pressed

- (void)lx_searchBarCancelButtonClicked:(LXHomeSearchBar *)searchBar ;   // called when cancel button pressed

- (BOOL)lx_searchBar:(LXHomeSearchBar *)searchBar shouldChangeTextInRange:(NSRange)range replacementString:(NSString *)string;

@end


@interface LXHomeSearchBar : UIView <UITextInputTraits>

@property (nonatomic,copy)   NSString               *text;                  // current/starting search text

@property (nonatomic,copy)   NSString               *placeholder;

@property (nonatomic,copy)   NSAttributedString     *attributedPlaceholder;

@property (nonatomic, readonly) UIButton *cancelButton;

@property (nonatomic, assign) BOOL autoDisplayCancel;

@property (nonatomic, weak) id <LXHomeSearchBarDelegate>delegate;

@end


