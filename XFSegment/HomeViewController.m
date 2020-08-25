//
//  HomeViewController.m
//  XFSegment
//
//  Created by xixi_wen on 2020/8/11.
//  Copyright © 2020 xixi_wen. All rights reserved.
//

#import "HomeViewController.h"
#import "SectionCell.h"
#import "NewSectionCell.h"
#import "XFSubListViewController.h"


@interface HomeViewController ()
<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) XFSubListViewController *tbVC;
@end


@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor blueColor];
    self.canScroll = YES;
    [self.view addSubview:self.collectView];
    NSLog(@"main collection: %@", self.collectView);
}

- (XFBaseCollectionView *)collectView {
    if (!_collectView) {
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        
        _collectView = [[XFBaseCollectionView alloc] initWithFrame:SetFrame(0, 0, kScreen_Width, kScreen_Height) collectionViewLayout:flowLayout];
        _collectView.delegate = self;
        _collectView.dataSource = self;
        _collectView.backgroundColor = [UIColor redColor];
        _collectView.showsVerticalScrollIndicator = NO;

        [_collectView registerClass:UICollectionViewCell.class forCellWithReuseIdentifier:UICollectionViewCell.description];
//        [_collectView registerClass:SectionCell.class forCellWithReuseIdentifier:SectionCell.description];
        [_collectView registerClass:NewSectionCell.class forCellWithReuseIdentifier:NewSectionCell.description];

    }
    return _collectView;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 2;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (section == 1) {
        return 1;
    } else {
        return 4;
    }
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        NewSectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NewSectionCell.description forIndexPath:indexPath];
        [self addChildViewController:self.tbVC];
        self.tbVC.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height -120 );
        self.tbVC.parentVC = self;
        [cell.containerView addSubview:self.tbVC.view];

        
        return cell;
        
//        SectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:SectionCell.description forIndexPath:indexPath];
//        cell.parentVC = self;
//        [cell setData];
//        cell.backgroundColor = [UIColor blackColor];
//        self.collectView.allowGestureSimultaneouslyViewsArray = [NSMutableArray arrayWithArray:@[cell.collectView]];
//        return cell;
    } else {
        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:UICollectionViewCell.description forIndexPath:indexPath];
        cell.backgroundColor = [UIColor greenColor];
        return cell;
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return CGSizeMake((kScreen_Width - 2) / 2.f, 100.f);
    } else {
        return CGSizeMake(kScreen_Width, self.collectView.frame.size.height);
    }
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 1;
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 1;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

#pragma mark
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (self.collectView.visibleCells.count) {
        CGFloat y = [self.collectView layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]].frame.origin.y;
        CGFloat contentOffset = y ? y : scrollView.frame.size.height;
//        if (scrollView.contentOffset.y >= contentOffset) {
//            scrollView.contentOffset = CGPointMake(0, contentOffset);
//            if (self.canScroll) {
//                self.canScroll = NO;
//                [NSNotificationCenter.defaultCenter postNotificationName:@"noti" object:self.collectView userInfo:@{@"canScroll": @YES}];
//            }
//        } else {
//            if (!self.canScroll) {
//                scrollView.contentOffset = CGPointMake(0, contentOffset);
//            }
//        }
        
        NSLog(@"<>0");
        if (!_canScroll) {
            NSLog(@"<>1");
            scrollView.contentOffset = CGPointMake(0, contentOffset);
        } else if (scrollView.contentOffset.y >= contentOffset) {
            NSLog(@"<>2");
            scrollView.contentOffset = CGPointMake(0, contentOffset);
            self.canScroll = NO;
            [NSNotificationCenter.defaultCenter postNotificationName:@"noti" object:self.collectView userInfo:@{@"canScroll": @YES}];
        }
    }
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

- (XFSubListViewController *)tbVC {
    if (!_tbVC) {
        _tbVC = [[XFSubListViewController alloc] init];
    }
    return _tbVC;
}

@end
