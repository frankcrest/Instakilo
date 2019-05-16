//
//  CustomFlowLayout.h
//  InstaKilo
//
//  Created by Frank Chen on 2019-05-15.
//  Copyright © 2019 Frank Chen. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CustomFlowLayout : UICollectionViewFlowLayout

@property (nonatomic,assign) CGFloat pinchedCellScale;
@property (nonatomic,assign) CGPoint pinchedCellCenter;
@property (nonatomic,strong) NSIndexPath* pinchedCellPath;

@end

NS_ASSUME_NONNULL_END
