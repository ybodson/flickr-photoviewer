//
//  PVPhotoCell.m
//  PhotoViewer
//
//  Created by Yann Bodson on 1/11/12.
//  Copyright (c) 2012 grimfrog. All rights reserved.
//

#import "PVFeedController.h"
#import "PVPhotoCell.h"
#import "PVFeedCell.h"

@interface PVFeedCell ()

@property (nonatomic, strong) PVStackLayout *stackLayout;

@end

@implementation PVFeedCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentView.backgroundColor = [UIColor clearColor];
        CGRect r = frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
        self.stackLayout = [[PVStackLayout alloc] init];
        self.collectionView = [[UICollectionView alloc] initWithFrame:r collectionViewLayout:self.stackLayout];
        self.collectionView.backgroundColor = [UIColor clearColor];
        [self.collectionView registerClass:[PVPhotoCell class] forCellWithReuseIdentifier:@"PhotoCell"];
        self.collectionView.allowsSelection = NO;
        self.collectionView.userInteractionEnabled = NO;

        self.textField = [[UITextField alloc] initWithFrame:CGRectMake(0, 230, frame.size.width, 30)];
        self.textField.textAlignment = NSTextAlignmentCenter;

        [self.contentView addSubview:self.collectionView];
        [self.contentView addSubview:self.textField];
    }
    return self;
}

- (void)setFeedViewController:(PVFeedController *)feedViewController
{
    self.collectionView.delegate = feedViewController;
    self.collectionView.dataSource = feedViewController;
    self.stackLayout.delegate = feedViewController;
}

@end
