//
//  PVSecondCell.m
//  PhotoViewer
//
//  Created by Yann Bodson on 6/11/12.
//  Copyright (c) 2012 grimfrog. All rights reserved.
//

#import "PVPhotoCell.h"

@implementation PVPhotoCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        CGRect r = CGRectMake(10, 10, frame.size.width - 20, frame.size.height - 20);
        self.imageView = [[PVImageView alloc] initWithFrame:r];
        self.imageView.backgroundColor = [UIColor clearColor];

        CGRect border = CGRectMake(0, 0, frame.size.width, frame.size.height);
        self.borderView = [[UIImageView alloc] initWithFrame:border];
        UIEdgeInsets insets = UIEdgeInsetsMake(20, 20, 20, 20);
        UIImage *image = [[UIImage imageNamed:@"frame.png"] resizableImageWithCapInsets:insets];
        self.borderView.image = image;

        [self.contentView addSubview:self.borderView];
        [self.contentView addSubview:self.imageView];
    }
    return self;
}

- (void)setSize:(CGSize)size
{
    CGRect f = CGRectMake(0, 0, size.width, size.height);
    self.frame = f;
    CGRect r = CGRectMake(10, 10, size.width - 20, size.height - 20);
    self.imageView.frame = r;
    CGRect border = CGRectMake(0, 0, size.width, size.height);
    self.borderView.frame = border;
}

@end
