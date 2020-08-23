//
//  XFSubListViewController.m
//  XFSegment
//
//  Created by xixi_wen on 2020/8/11.
//  Copyright © 2020 xixi_wen. All rights reserved.
//

#import "XFSubListViewController.h"

@interface XFSubListViewController ()
//<UITableViewDelegate, UITableViewDataSource>
<UICollectionViewDataSource, UICollectionViewDelegate>
@end

@implementation XFSubListViewController

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

-(void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.collectView];
}


- (XFBaseCollectionView *)collectView {
    if (!_collectView) {
        
//        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
//        
//        _collectView = [[XFBaseCollectionView alloc] initWithFrame:SetFrame(0, 50, kScreen_Width, self.frame.size.height - 50 - kNavigationBar_HeightForiOS11 - 44) collectionViewLayout:flowLayout];
//        _collectView.delegate = self;
//        _collectView.dataSource = self;
//        _collectView.backgroundColor = [UIColor redColor];
////        _collectView.showsVerticalScrollIndicator = NO;
//
//        [_collectView registerClass:UICollectionViewCell.class forCellWithReuseIdentifier:UICollectionViewCell.description];
    }
    return _collectView;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
   
        return 16;
    
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

//- (void)viewDidLoad {
//    [super viewDidLoad];
//    // Do any additional setup after loading the view.
//
//    self.tableView = [[XFBaseTableView alloc] initWithFrame:SetFrame(0, 0, kScreen_Width, kScreen_Height)];
//    self.tableView.delegate = self;
//    self.tableView.dataSource = self;
//    self.tableView.showsVerticalScrollIndicator = NO;
//    [self.view addSubview:self.tableView];
//}
//
//#pragma mark
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    return 40;
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"xixixi"];
//    if (!cell) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"xixixi"];
//    }
//    cell.textLabel.text = [NSString stringWithFormat:@"%zd", indexPath.row];
//    return cell;
//}






/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
