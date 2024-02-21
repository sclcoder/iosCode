//
//  RRPostTableViewCell.m
//  SDPlayground
//
//  Created by Sun ChunLei (Lofty Team) on 2024/2/20.
//

#import "RRPostTableViewCell.h"
#import "RRPostListLayout.h"


@interface RRPostTableViewCell ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (strong, nonatomic) UICollectionView *collectionView;

@property (strong, nonatomic) IBOutlet UIView *layoutView;


@end

@implementation RRPostTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    [self setupCollectionView];
}


- (void)setupCollectionView{
    [self.layoutView addSubview:self.collectionView];
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.layoutView).insets(UIEdgeInsetsMake(5, 5, 5, 5));
    }];
}


- (void)setItemCount:(NSUInteger)itemCount{
    _itemCount = itemCount;
    [self.collectionView reloadData];
    [self.collectionView layoutIfNeeded];
}


- (CGSize)systemLayoutSizeFittingSize:(CGSize)targetSize withHorizontalFittingPriority:(UILayoutPriority)horizontalFittingPriority verticalFittingPriority:(UILayoutPriority)verticalFittingPriority{
    
    CGSize size = [super systemLayoutSizeFittingSize:targetSize withHorizontalFittingPriority:horizontalFittingPriority verticalFittingPriority:verticalFittingPriority];
    
//    [self.collectionView layoutIfNeeded];
    CGFloat collectionH = self.collectionView.collectionViewLayout.collectionViewContentSize.height;
    CGFloat height = size.height + collectionH;
    
    return CGSizeMake(size.width, height);
}

#pragma mark - UICollection dataSource 、delegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.itemCount;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"imageCell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor redColor];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma mark - collectionView
- (UICollectionView *)collectionView{
    if (_collectionView == nil) {
        CGFloat spacing = 0;
        UIEdgeInsets contentInsets = UIEdgeInsetsMake(spacing, spacing, spacing, spacing);
        
        RRPostListLayout *flowLayout = [[RRPostListLayout alloc] init];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        flowLayout.minimumLineSpacing = 5;
        flowLayout.minimumInteritemSpacing = 5;
        flowLayout.itemSize = CGSizeMake(0, 0);
        
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) collectionViewLayout:flowLayout];

        collectionView.contentInset = contentInsets;
        collectionView.scrollEnabled = NO;
        collectionView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        
        [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"imageCell"];
        
        collectionView.dataSource = self;
        collectionView.delegate = self;
        collectionView.backgroundColor = [UIColor systemBlueColor];
        
        collectionView.layer.cornerRadius = 10;
        collectionView.layer.masksToBounds = YES;
        
        _collectionView = collectionView;
    }
    return _collectionView;
}

@end
