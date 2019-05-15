//
//  CustomCollectionReusableView.m
//  InstaKilo
//
//  Created by Frank Chen on 2019-05-15.
//  Copyright © 2019 Frank Chen. All rights reserved.
//

#import "CustomCollectionReusableView.h"

@implementation CustomCollectionReusableView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _label = [[UILabel alloc]initWithFrame:CGRectZero];
        _label.translatesAutoresizingMaskIntoConstraints = 0;
        [self addSubview:_label];
        
        [NSLayoutConstraint activateConstraints:@[
                                                  [self.label.topAnchor constraintEqualToAnchor:self.topAnchor constant:0],
                                                  [self.label.leadingAnchor constraintEqualToAnchor:self.leadingAnchor constant:0],
                                                  [self.label.trailingAnchor constraintEqualToAnchor:self.trailingAnchor constant:0],
                                                  [self.label.bottomAnchor constraintEqualToAnchor:self.bottomAnchor constant:0],
                                                  ]];
    }
    return self;
}

@end
