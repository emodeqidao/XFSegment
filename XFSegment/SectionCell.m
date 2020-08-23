//
//  SectionCell.m
//  XFSegment
//
//  Created by xixi_wen on 2020/8/11.
//  Copyright © 2020 xixi_wen. All rights reserved.
//

#import "SectionCell.h"

@interface SectionCell()
//<UITableViewDelegate, UITableViewDataSource>
<UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, assign) BOOL canContentScroll;
@property (nonatomic, strong) UIScrollView *containerView;
@end

@implementation SectionCell

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"noti" object:nil];
}


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        
        
        UILabel *sectionLabel = [[UILabel alloc] initWithFrame:SetFrame(0, 0, 100, 50)];
        sectionLabel.text = @"我是section";
        sectionLabel.font = [UIFont systemFontOfSize:16.f];
        sectionLabel.backgroundColor = [UIColor yellowColor];
        [self addSubview:sectionLabel];
        
        [self.contentView addSubview:self.containerView];

        [self.containerView addSubview:self.collectView];
        NSLog(@"cell collection:%@", self.collectView);
//        self.tableView = [[XFBaseTableView alloc] initWithFrame:SetFrame(0, 50, frame.size.width, frame.size.height - 50 - kNavigationBar_HeightForiOS11 - 44)];
//        self.tableView.delegate = self;
//        self.tableView.dataSource = self;
//        self.tableView.showsVerticalScrollIndicator = NO;
//        [self.containerView addSubview:self.tableView];
//        self.tableView.tableFooterView = [UIView new];
    }
    return self;
}

-(UIScrollView *)containerView{
    
    if (!_containerView ) {
        _containerView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height)];
        _containerView.backgroundColor = [UIColor purpleColor];
    }
    return _containerView;
}

- (void)setData {
    [NSNotificationCenter.defaultCenter addObserverForName:@"noti" object:self.parentVC.collectView queue:NSOperationQueue.mainQueue usingBlock:^(NSNotification * _Nonnull note) {
        NSLog(@"<>通知滚动!");
        BOOL canScroll = [note.userInfo[@"canScroll"] boolValue];
        self.canContentScroll = canScroll;
    }];
}

- (XFBaseCollectionView *)collectView {
    if (!_collectView) {

        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];

        _collectView = [[XFBaseCollectionView alloc] initWithFrame:SetFrame(0, 50, kScreen_Width, self.frame.size.height - 50 - kNavigationBar_HeightForiOS11 - 44) collectionViewLayout:flowLayout];
        _collectView.delegate = self;
        _collectView.dataSource = self;
        _collectView.backgroundColor = [UIColor redColor];
        _collectView.showsVerticalScrollIndicator = NO;
        _collectView.bounces = YES;

        [_collectView registerClass:UICollectionViewCell.class forCellWithReuseIdentifier:UICollectionViewCell.description];
    }
    return _collectView;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 30;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:UICollectionViewCell.description forIndexPath:indexPath];
    UILabel *tLabel = [cell viewWithTag:99];
    if (!tLabel) {
        tLabel = [[UILabel alloc] initWithFrame:SetFrame(0, 10, 100, 30)];
        tLabel.textColor = [UIColor redColor];
        tLabel.tag = 99;
        [cell.contentView addSubview:tLabel];
    }
    tLabel.text = [NSString stringWithFormat:@"%zd", indexPath.item];
    cell.backgroundColor = [UIColor greenColor];

    return cell;

}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake((kScreen_Width - 2) / 2.f, 100.f);

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
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 40;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"xixi"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"xixi"];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%zd", indexPath.row];
    return cell;
}

#pragma mark

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    NSLog(@"_canContentScroll: %d", _canContentScroll);
//    NSLog(@"_contentOffset: %f", scrollView.contentOffset.y);
    NSLog(@"<>3");
    if (!_canContentScroll) {
        NSLog(@"<>4");
        // 这里通过固定contentOffset，来实现不滚动
        scrollView.contentOffset = CGPointZero;
    } else if (scrollView.contentOffset.y <= 0) {
        NSLog(@"<>5");
        _canContentScroll = NO;
        // 通知容器可以开始滚动
        self.parentVC.canScroll = YES;
    }
}

@end
