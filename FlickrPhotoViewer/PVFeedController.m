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
#import "PVImageStore.h"
#import "PVStackLayout.h"

@interface PVFeedController () <PVFlickerFeedDelegate, PVFlickerEntryDownloadDelegate, PVStackLayoutDelegate>

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

- (void)refreshFeed
{
    [self.feed fetchEntries];
}

- (void)setTag:(NSString *)tag
{
    self.feed.tag = tag;
    [self.feed fetchEntries];
}

- (NSString *)tag
{
    return self.feed.tag;
}

#pragma mark - UICollectionView

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
    
    if (self.feed.entries && self.feed.entries.count > 0) {
        PVFlickerEntry *entry = [self.feed.entries objectAtIndex:indexPath.row];
        entry.delegate = self;
        [cell setSize:entry.size];
        cell.imageView.image = [[PVImageStore sharedStore] imageForKey:entry.thumbnail];
    }
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (self.feed.entries)
        return self.feed.entries.count;
    return 0;
}

#pragma mark - PVFlickerFeedDelegate

- (void)feedFetched
{
    [self.stackCollectionView reloadData];
    if (self.gridCollectionView) {
        [self.gridCollectionView reloadData];
        [self.refreshControl endRefreshing];
    }
}

#pragma mark - PVStackLayoutDelegate

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

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    self.tag = textField.text;
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - PVFlickerEntryDownloadDelegate

- (void)thumbnailDowloadedForEntry:(PVFlickerEntry *)flickerEntry
{
    int index = [self.feed.entries indexOfObject:flickerEntry];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
    PVPhotoCell *cell = (PVPhotoCell *)[self.stackCollectionView cellForItemAtIndexPath:indexPath];
    cell.imageView.image = [[PVImageStore sharedStore] imageForKey:flickerEntry.thumbnail];
    if (self.gridCollectionView) {
        PVPhotoCell *cell = (PVPhotoCell *)[self.gridCollectionView cellForItemAtIndexPath:indexPath];
        cell.imageView.image = [[PVImageStore sharedStore] imageForKey:flickerEntry.thumbnail];
    }
}


@end
