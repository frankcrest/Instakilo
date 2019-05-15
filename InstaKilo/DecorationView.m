//
//  DecorationView.m
//  InstaKilo
//
//  Created by Frank Chen on 2019-05-15.
//  Copyright © 2019 Frank Chen. All rights reserved.
//

#import "DecorationView.h"

@implementation DecorationView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIImage* image = [UIImage imageNamed:@"floral"];
        _backgroundView = [[UIImageView alloc]initWithFrame:frame];
        _backgroundView.translatesAutoresizingMaskIntoConstraints = 0;
        [_backgroundView setImage:image];
        [self addSubview:_backgroundView];
        
        [NSLayoutConstraint activateConstraints:@[
                                                  [self.backgroundView.topAnchor constraintEqualToAnchor:self.topAnchor constant:0],
                                                  [self.backgroundView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor constant:0],
                                                  [self.backgroundView.trailingAnchor constraintEqualToAnchor:self.trailingAnchor constant:0],
                                                  [self.backgroundView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor constant:0],
                                                  ]];
    }
    return self;
}
@end
