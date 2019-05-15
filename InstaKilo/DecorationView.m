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
        _backgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"floral"]];
    }
    return self;
}
@end
