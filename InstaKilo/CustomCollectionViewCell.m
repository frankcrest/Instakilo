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
        _imageView.transform = CGAffineTransformMakeRotation(M_PI_4 / arc4random_uniform(45));
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview: _imageView];
        [NSLayoutConstraint activateConstraints:@[
                                                  [self.imageView.topAnchor constraintEqualToAnchor:self.topAnchor constant:10],
                                                  [self.imageView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor constant:10],
                                                  [self.imageView.trailingAnchor constraintEqualToAnchor:self.trailingAnchor constant:-10],
                                                  [self.imageView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor constant:-10],
                                                  ]];
    }
    return self;
}

@end
