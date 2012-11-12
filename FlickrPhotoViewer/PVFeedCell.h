//
//  PVPhotoCell.h
//  PhotoViewer
//
//  Created by Yann Bodson on 1/11/12.
//  Copyright (c) 2012 grimfrog. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "PVStackLayout.h"

@class PVFeedController;

@interface PVFeedCell : UICollectionViewCell

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, weak) PVFeedController *feedViewController;

@end
