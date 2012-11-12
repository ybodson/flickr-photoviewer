//
//  PVFeedViewController.h
//  PhotoViewer
//
//  Created by Yann Bodson on 8/11/12.
//  Copyright (c) 2012 grimfrog. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PVStackLayout.h"

@interface PVFeedController : NSObject <UICollectionViewDataSource, UICollectionViewDelegate, PVStackLayoutDelegate>

@property (nonatomic, weak) UICollectionView *collectionView;
@property (nonatomic) NSString *tag;

- (id)initWithTag:(NSString *)tag;

@end
