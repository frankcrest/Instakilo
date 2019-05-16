//
//  CustomFlowLayout.m
//  InstaKilo
//
//  Created by Frank Chen on 2019-05-15.
//  Copyright © 2019 Frank Chen. All rights reserved.
//

#import "CustomFlowLayout.h"
#import "DecorationView.h"

@implementation CustomFlowLayout

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self registerClass:[DecorationView class] forDecorationViewOfKind:@"customDecoration"];
    }
    return self;
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
    NSMutableArray* array = [[NSMutableArray alloc]initWithArray:[super layoutAttributesForElementsInRect:rect]];
    
//    for (UICollectionViewLayoutAttributes *attr in array) {
//        if (attr.representedElementCategory != UICollectionElementCategoryCell) {
//            continue;
//        }
//    }
//    
    UICollectionViewLayoutAttributes* deatts = [self layoutAttributesForDecorationViewOfKind:@"customDecoration" atIndexPath:[NSIndexPath indexPathForItem:0 inSection:0]];
    if (CGRectIntersectsRect(rect, deatts.frame)) {
        [array addObject:deatts];
    }
    return array;
}

- (UICollectionViewLayoutAttributes *)finalLayoutAttributesForDisappearingItemAtIndexPath:(NSIndexPath *)itemIndexPath{
    UICollectionViewLayoutAttributes* attribute = [super finalLayoutAttributesForDisappearingItemAtIndexPath:itemIndexPath];
    
    attribute.transform = CGAffineTransformTranslate(attribute.transform, 0 ,self.collectionView.frame.size.height);
    attribute.alpha = 0;
    
    return attribute;
}

@end
