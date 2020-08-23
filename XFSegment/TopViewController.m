//
//  TopViewController.m
//  XFSegment
//
//  Created by xixi_wen on 2020/8/22.
//  Copyright © 2020 xixi_wen. All rights reserved.
//

#import "TopViewController.h"
#import "UIView+frame.h"
#import "LXHomeSearchBar.h"

@interface TopViewController ()
<LXSegmentControlDelegate, LXHomeSearchBarDelegate>

@property (nonatomic) NSUInteger selectedIndex;
@property (nonatomic, strong) LXHomeSearchBar *searchBar;

@end

@implementation TopViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.translucent = YES;
    [self.navigationController.navigationBar setBackgroundImage:UIImage.new forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.navigationItem.titleView = self.searchBar;
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.selectedIndex = NSNotFound;

    [self.view addSubview:self.segment];
    [self initData];

}

- (void)initData {
    NSArray *arr = @[@"abc", @"def", @"ghi"];
    [self.segment setItems:arr];
    
    NSMutableArray *tempV = [NSMutableArray array];
    for (int i = 0; i < arr.count; i++) {
        HomeViewController *vc = [HomeViewController new];
        [tempV addObject:vc];
    }
    self.segment.selectedSegmentIndex = 0;
    self.viewControllerArray = tempV.copy;

    self.selectedIndex = 0;
    [self displayContentController:_viewControllerArray[self.selectedIndex]];
    self.child = _viewControllerArray[self.selectedIndex];

}

- (void)setSelectedIndex:(NSUInteger)selectedIndex {
    if (_viewControllerArray.count &&
        _selectedIndex != selectedIndex) {
        _selectedIndex = selectedIndex;
        
        if (self.child) {
            [self hideContentController:self.child];
        }
        
        [self displayContentController:_viewControllerArray[selectedIndex]];
        self.child = _viewControllerArray[selectedIndex];
    } else if (_viewControllerArray.count) {
        _viewControllerArray[selectedIndex].view.frame = [self frameForContentController];
    }
}

- (CGRect)frameForContentController {
    return UIEdgeInsetsInsetRect(self.view.bounds, (UIEdgeInsets){self.segment.superview ? self.segment.bottom + 4 : _segment.top, 0.0, 0.0, 0.0});
}

- (void)hideContentController:(UIViewController*)content {
    [content willMoveToParentViewController:nil];
    [content.view removeFromSuperview];
    [content removeFromParentViewController];
}


- (void)displayContentController:(UIViewController*)content {
    [self addChildViewController:content];
    content.view.frame = [self frameForContentController];
    content.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight ;
    [self.view addSubview:content.view];
    [content didMoveToParentViewController:self];
    [self.view bringSubviewToFront:self.segment];
}

- (LXSegmentControl *)segment {
    if (!_segment) {
        _segment = [LXSegmentControl new];
        _segment.itemTitleFont = kFont(13);

        _segment.spacing = 12.0;
        _segment.lineWidth = 28.0;
        _segment.adjustMode = LXSegmentControlAdjustModeLeft;
        _segment.size = CGSizeMake(kScreen_Width, 44.0);
        _segment.top = kNavigationBar_HeightForiOS11;
        [_segment setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_segment setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        _segment.delegate = self;
    }
    return _segment;
}

- (void)lx_segmentControl:(LXSegmentControl *)segment didSelected:(NSInteger)index
{
    self.selectedIndex = index;
    NSLog(@"select index: %zd", index);
}

#pragma mark
- (LXHomeSearchBar *)searchBar {
    if (!_searchBar) {
        _searchBar = [LXHomeSearchBar new];
        _searchBar.delegate = self;
        _searchBar.placeholder = @"请输入您要搜索的商品";
        _searchBar.size = CGSizeMake(kScreen_Width - 70.0, 28.0);
        
        _searchBar.returnKeyType = UIReturnKeyDone;
    }
    return _searchBar;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
