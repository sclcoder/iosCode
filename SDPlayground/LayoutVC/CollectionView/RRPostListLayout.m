//
//  RRPostListLayout.m
//  SDPlayground
//
//  Created by Sun ChunLei (Lofty Team) on 2024/2/20.
//

#import "RRPostListLayout.h"

@interface RRPostListLayout ()

@property (nonatomic, assign) NSInteger cellCount;

@property (nonatomic, assign) CGFloat contentHeight;

@end

@implementation RRPostListLayout

- (void)prepareLayout{
    [super prepareLayout];
    self.cellCount = [self.collectionView numberOfItemsInSection:0];
    self.cellCount = (self.cellCount > 5) ? 5 : self.cellCount;
    self.contentHeight = 0;
}


-(CGSize)collectionViewContentSize{
    return CGSizeMake([self collectionView].frame.size.width, self.contentHeight);
}


- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds{
    return YES;
}


// 设置attributes
- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect{
    NSMutableArray *array = [NSMutableArray array];
    for (NSInteger i = 0; i < self.cellCount; i++) {
        // 生成indexPath
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        
        UICollectionViewLayoutAttributes *attribute = [self layoutAttributesForItemAtIndexPath:indexPath];
        [array addObject:attribute];
    }
    return array;
}

// 获取attributes的方法
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewLayoutAttributes *attribute = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    if(self.cellCount == 1){
        CGFloat width  = [self getCollectionViewWidth];
        CGFloat height = ceil(width * 0.625);
        attribute.frame = CGRectMake(0, 0, width, height);
        
        self.contentHeight = height;
    }
    
    if(self.cellCount == 2){
        CGFloat space_h = self.minimumInteritemSpacing;
        CGFloat width  = ceil(([self getCollectionViewWidth] - space_h) / 2);
        CGFloat height = ceil(width * 0.625);
        switch (indexPath.item) {
            case 0:{
                attribute.frame = CGRectMake(0, 0, width, height);
            }
                break;
            case 1:{
                attribute.frame = CGRectMake(width + space_h, 0, width, height);
            }
                break;
            default:
                break;
        }
        
        self.contentHeight = height;
    }

    if(self.cellCount == 3){
        CGFloat space_h          = self.minimumInteritemSpacing;
        CGFloat space_v          = self.minimumLineSpacing;

        CGFloat container_width  = [self getCollectionViewWidth];
        
        CGFloat first_row_width  = container_width;
        CGFloat first_row_height = ceil(container_width * 0.625);
                                        
        CGFloat second_row_width   = ceil((container_width - space_h) / 2);
        CGFloat second_row_height  = ceil(second_row_width * 0.625);

        switch (indexPath.item) {
            case 0:{
                attribute.frame = CGRectMake(0, 0, first_row_width, first_row_height);
            }
                break;
            case 1:{
                attribute.frame = CGRectMake(0, first_row_height + space_v, second_row_width, second_row_height);
            }
                break;
            case 2:{
                attribute.frame = CGRectMake(second_row_width + space_h, first_row_height + space_v, second_row_width, second_row_height);
            }
                break;
            default:
                break;
        }
        
        self.contentHeight = first_row_height + space_v + second_row_height;

    }
    
    
    if(self.cellCount == 4){
        CGFloat space_h          = self.minimumInteritemSpacing;
        CGFloat space_v          = self.minimumLineSpacing;

        CGFloat row_width  =  ceil([self getCollectionViewWidth] / 2);
        CGFloat row_height =  ceil(row_width * 0.625);
        
        switch (indexPath.item) {
            case 0:{
                attribute.frame = CGRectMake(0, 0, row_width, row_height);
            }
                break;
            case 1:{
                attribute.frame = CGRectMake(row_width + space_h, 0, row_width, row_height);
            }
                break;
            case 2:{
                attribute.frame = CGRectMake(0, row_height + space_v, row_width, row_height);
            }
                break;
            case 3:{
                attribute.frame = CGRectMake(row_width + space_h, row_height + space_v, row_width, row_height);
            }
                break;
            default:
                break;
        }
        self.contentHeight = row_height + space_v + row_height;
    }
    
    if(self.cellCount > 4){
        CGFloat space_h          = self.minimumInteritemSpacing;
        CGFloat space_v          = self.minimumLineSpacing;
        
        CGFloat first_row_width  =  ceil([self getCollectionViewWidth] / 2);
        CGFloat first_row_height =  ceil(first_row_width * 0.625);
                                        
        CGFloat second_row_width   = ceil(([self getCollectionViewWidth] - space_h) / 3);
        CGFloat second_row_height  = ceil(second_row_width * 0.625);
        
        switch (indexPath.item) {
            case 0:{
                attribute.frame = CGRectMake(0, 0, first_row_width, first_row_height);
            }
                break;
            case 1:{
                attribute.frame = CGRectMake(first_row_width + space_h, 0, first_row_width, first_row_height);
            }
                break;
            case 2:{
                attribute.frame = CGRectMake(0, first_row_height + space_v, second_row_width, second_row_height);
            }
                break;
            case 3:{
                attribute.frame = CGRectMake(second_row_width + space_h, first_row_height + space_v, second_row_width, second_row_height);
            }
                break;
            case 4:{
                attribute.frame = CGRectMake((second_row_width + space_h) * 2, first_row_height + space_v, second_row_width, second_row_height);
            }
                break;
            default:
                break;
        }
        
        self.contentHeight = first_row_height + space_v + second_row_height;

    }

    return attribute;
}


- (CGFloat)getCollectionViewWidth{
    /// FIXME: 初始布局时self.collectionView.frame 不准确，因为第一次调用时collectionView没有布局好
//    return [self collectionView].frame.size.width;
    
//    return ceil([UIScreen mainScreen].bounds.size.width - 10);
    
    return [self.delegate collectionViewWidth:self];
}

@end
