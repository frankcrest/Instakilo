//
//  CustomCollectionViewCell.m
//  InstaKilo
//
//  Created by Frank Chen on 2019-05-15.
//  Copyright © 2019 Frank Chen. All rights reserved.
//

#import "CustomCollectionViewCell.h"

@implementation CustomCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        _imageView = [[UIImageView alloc]initWithFrame:CGRectZero];
        _imageView.translatesAutoresizingMaskIntoConstraints = 0;
        _imageView.transform = CGAffineTransformMakeRotation(M_PI_2 / arc4random_uniform(40));
        CGFloat diagonal = sqrt(self.frame.size.width + self.frame.size.height);
        [self addSubview: _imageView];
        
        [NSLayoutConstraint activateConstraints:@[
                                                  [self.imageView.topAnchor constraintEqualToAnchor:self.topAnchor constant:diagonal - self.imageView.frame.size.height],
                                                  [self.imageView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor constant:diagonal - self.imageView.frame.size.height],
                                                  [self.imageView.trailingAnchor constraintEqualToAnchor:self.trailingAnchor constant:-(diagonal - self.imageView.frame.size.height)],
                                                  [self.imageView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor constant:-(diagonal - self.imageView.frame.size.height)],
                                                  ]];
    }
    return self;
}

@end
