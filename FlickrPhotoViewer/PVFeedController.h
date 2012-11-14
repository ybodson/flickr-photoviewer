//
//  PVFeedViewController.h
//  PhotoViewer
//
//  Created by Yann Bodson on 8/11/12.
//  Copyright (c) 2012 grimfrog. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PVFeedController : NSObject <UICollectionViewDataSource, UICollectionViewDelegate, UITextFieldDelegate>

@property (nonatomic, weak) UICollectionView *stackCollectionView;
@property (nonatomic, weak) UICollectionView *gridCollectionView;
@property (nonatomic, strong) UIRefreshControl *refreshControl;
@property (nonatomic) NSString *tag;

- (id)initWithTag:(NSString *)tag;
- (void)refreshFeed;

@end
