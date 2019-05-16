//
//  CustomFlowLayout.m
//  InstaKilo
//
//  Created by Frank Chen on 2019-05-15.
//  Copyright © 2019 Frank Chen. All rights reserved.
//

#import "CustomFlowLayout.h"
#import "DecorationView.h"

@interface CustomFlowLayout ()

@property (nonatomic,strong) NSMutableArray* deleteIndexPaths;
@property (nonatomic,strong) NSMutableArray* insertIndexPaths;

@end
@implementation CustomFlowLayout

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self registerClass:[DecorationView class] forDecorationViewOfKind:@"customDecoration"];
        _pinchedCellPath = [[NSIndexPath alloc]init];
    }
    return self;
}

- (void)prepareForCollectionViewUpdates:(NSArray<UICollectionViewUpdateItem *> *)updateItems{
    
    
    // Keep track of insert and delete index paths
    [super prepareForCollectionViewUpdates:updateItems];
    
    self.deleteIndexPaths = [NSMutableArray array];
    self.insertIndexPaths = [NSMutableArray array];
    
    for (UICollectionViewUpdateItem *update in updateItems)
    {
        if (update.updateAction == UICollectionUpdateActionDelete)
        {
            [self.deleteIndexPaths addObject:update.indexPathBeforeUpdate];
        }
        else if (update.updateAction == UICollectionUpdateActionInsert)
        {
            [self.insertIndexPaths addObject:update.indexPathAfterUpdate];
        }
    }
}

- (void)finalizeCollectionViewUpdates
{
    [super finalizeCollectionViewUpdates];
    // release the insert and delete index paths
    self.deleteIndexPaths = nil;
    self.insertIndexPaths = nil;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForDecorationViewOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath{

    if ([elementKind isEqualToString:@"customDecoration"]) {
        UICollectionViewLayoutAttributes* atts = [UICollectionViewLayoutAttributes layoutAttributesForDecorationViewOfKind:@"customDecoration" withIndexPath:indexPath];
        atts.frame = self.collectionView.frame;
        atts.zIndex = -1;
        return atts;
    }
    return nil;
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    NSMutableArray* allAttributesInRect = [[NSMutableArray alloc]initWithArray:[super layoutAttributesForElementsInRect:rect]];
    
    UICollectionViewLayoutAttributes* deatts = [self layoutAttributesForDecorationViewOfKind:@"customDecoration" atIndexPath:[NSIndexPath indexPathForItem:0 inSection:0]];
    if (CGRectIntersectsRect(rect, deatts.frame)) {
        [allAttributesInRect addObject:deatts];
    }
    
    for (UICollectionViewLayoutAttributes *attr in allAttributesInRect) {
        if (attr.representedElementKind == UICollectionElementCategoryCell) {
            [self applyPinchLayoutAttribute:attr];
        }
    }
    
    return allAttributesInRect;
}

- (UICollectionViewLayoutAttributes *)finalLayoutAttributesForDisappearingItemAtIndexPath:(NSIndexPath *)itemIndexPath{
    
    UICollectionViewLayoutAttributes* attribute = [super finalLayoutAttributesForDisappearingItemAtIndexPath:itemIndexPath];
    
    if ([self.deleteIndexPaths containsObject:itemIndexPath]) {
        attribute.transform = CGAffineTransformTranslate(attribute.transform, 0 ,self.collectionView.frame.size.height);
        attribute.alpha = 0;
    }
    return attribute;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewLayoutAttributes *attributes = [super layoutAttributesForItemAtIndexPath:indexPath];
    
    [self applyPinchLayoutAttribute:attributes];
    
    return attributes;
}

-(void)applyPinchLayoutAttribute:(UICollectionViewLayoutAttributes*)layoutAttributes{
    if ([layoutAttributes.indexPath isEqual:self.pinchedCellPath]) {
        layoutAttributes.transform3D = CATransform3DMakeScale(self.pinchedCellScale, self.pinchedCellScale, 1);
        layoutAttributes.center = self.pinchedCellCenter;
        layoutAttributes.zIndex = 1;
    }
}

-(void)setPinchedCellScale:(CGFloat)pinchedCellScale{
    _pinchedCellScale = pinchedCellScale;
    [self invalidateLayout];
}

- (void)setPinchedCellCenter:(CGPoint)pinchedCellCenter{
    _pinchedCellCenter = pinchedCellCenter;
    [self invalidateLayout];
}

@end
