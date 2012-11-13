//
//  PVFeedViewController.m
//  PhotoViewer
//
//  Created by Yann Bodson on 8/11/12.
//  Copyright (c) 2012 grimfrog. All rights reserved.
//

#import "PVFeedController.h"
#import "PVFlickerFeed.h"
#import "PVFlickerEntry.h"
#import "PVPhotoCell.h"
#import "PVAppDelegate.h"
#import "PVMainViewController.h"

@interface PVFeedController () <PVFlickerFeedDelegate>

@property (nonatomic, strong) PVFlickerFeed *feed;

@end


@implementation PVFeedController

@dynamic tag;

- (id)initWithTag:(NSString *)tag
{
    self = [super init];
    if (self) {
        self.feed = [[PVFlickerFeed alloc] initWithTag:tag];
        self.feed.delegate = self;
        [self.feed fetchEntries];
    }
    return self;
}

- (CGSize)sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.feed.entries) {
        PVFlickerEntry *entry = [self.feed.entries objectAtIndex:indexPath.row];
        return entry.size;
    }
    return CGSizeMake(100, 100);
}

- (CGFloat)angleForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.feed.entries) {
        PVFlickerEntry *entry = [self.feed.entries objectAtIndex:indexPath.row];
        return entry.angle;
    }
    return 0.0;
}

- (void)feedFetched
{
    [self.collectionView reloadData];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.feed.entries) {
        PVFlickerEntry *entry = [self.feed.entries objectAtIndex:indexPath.row];
        return entry.size;
    }
    return CGSizeMake(100, 100);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PVPhotoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PhotoCell" forIndexPath:indexPath];
    
    if (self.feed.entries) {
        PVFlickerEntry *entry = [self.feed.entries objectAtIndex:indexPath.row];
        [cell setSize:entry.size];
        [cell.imageView loadImageFromURLString:entry.thumbnail];
    }
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (self.feed.entries)
        return self.feed.entries.count;
    return 0;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
}

- (void)setTag:(NSString *)tag
{
    self.feed.tag = tag;
}

- (NSString *)tag
{
    return self.feed.tag;
}

@end
