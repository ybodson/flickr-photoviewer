//
//  PVViewController.h
//  PhotoViewer
//
//  Created by Yann Bodson on 1/11/12.
//  Copyright (c) 2012 grimfrog. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PVStackLayout;

@interface PVMainViewController : UICollectionViewController

@property (nonatomic, strong) UIView *midView;
@property (nonatomic, strong) UICollectionView *frontView;
@property (nonatomic, strong) PVStackLayout *stackLayout;

@end
