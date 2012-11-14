//
//  PVSecondCell.m
//  PhotoViewer
//
//  Created by Yann Bodson on 6/11/12.
//  Copyright (c) 2012 grimfrog. All rights reserved.
//

#import "PVPhotoCell.h"

@interface PVPhotoCell ()

@property (nonatomic, strong) UIImageView *borderView;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIActivityIndicatorView *busyIndicator;

@end

@implementation PVPhotoCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        CGRect r = CGRectMake(10, 9, frame.size.width - 20, frame.size.height - 20);
        self.imageView = [[UIImageView alloc] initWithFrame:r];
        self.imageView.backgroundColor = [UIColor lightGrayColor];

        CGRect border = CGRectMake(0, 0, frame.size.width, frame.size.height);
        self.borderView = [[UIImageView alloc] initWithFrame:border];
        UIEdgeInsets insets = UIEdgeInsetsMake(20, 20, 20, 20);
        UIImage *image = [[UIImage imageNamed:@"frame.png"] resizableImageWithCapInsets:insets];
        self.borderView.image = image;

        self.busyIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        self.busyIndicator.center = self.imageView.center;
        [self.busyIndicator startAnimating];
        
        [self.contentView addSubview:self.borderView];
        [self.contentView addSubview:self.imageView];
        [self.contentView addSubview:self.busyIndicator];
    }
    return self;
}

- (void)setSize:(CGSize)size
{
    CGRect f = CGRectMake(0, 0, size.width, size.height);
    self.frame = f;
    CGRect r = CGRectMake(10, 9, size.width - 20, size.height - 20);
    self.imageView.frame = r;
    CGRect border = CGRectMake(0, 0, size.width, size.height);
    self.borderView.frame = border;
    self.busyIndicator.center = self.imageView.center;
}

- (void)setImage:(UIImage *)image;
{
    if (image)
        [self.busyIndicator stopAnimating];
    else
        [self.busyIndicator startAnimating];
    self.imageView.image = image;
}

@end
