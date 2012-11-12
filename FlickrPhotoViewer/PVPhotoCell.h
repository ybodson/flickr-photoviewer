//
//  PVSecondCell.h
//  PhotoViewer
//
//  Created by Yann Bodson on 6/11/12.
//  Copyright (c) 2012 grimfrog. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PVImageView.h"

@interface PVPhotoCell : UICollectionViewCell

@property (nonatomic, strong) UIImageView *borderView;
@property (nonatomic, strong) PVImageView *imageView;

- (void)setSize:(CGSize)size;

@end
