//
//  SectionCell.m
//  XFSegment
//
//  Created by xixi_wen on 2020/8/11.
//  Copyright © 2020 xixi_wen. All rights reserved.
//

#import "SectionCell.h"

@interface SectionCell()
<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, assign) BOOL canContentScroll;
@end

@implementation SectionCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [NSNotificationCenter.defaultCenter addObserverForName:@"xixi_noti" object:self.parentVC.collectView queue:NSOperationQueue.mainQueue usingBlock:^(NSNotification * _Nonnull note) {
            BOOL canScroll = [note.userInfo[@"canScroll"] boolValue];
            self.canContentScroll = canScroll;
        }];
        
        self.tableView = [[XFBaseTableView alloc] initWithFrame:SetFrame(0, 50, frame.size.width, frame.size.height - 50)];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.showsVerticalScrollIndicator = NO;
        [self addSubview:self.tableView];
        
//        self.tableView.tableFooterView = [UIView new];
    }
    return self;
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
    if (!_canContentScroll) {
        // 这里通过固定contentOffset，来实现不滚动
        scrollView.contentOffset = CGPointZero;
    } else if (scrollView.contentOffset.y <= 0) {
        _canContentScroll = NO;
        // 通知容器可以开始滚动
        self.parentVC.canScroll = YES;
    }
}

@end
