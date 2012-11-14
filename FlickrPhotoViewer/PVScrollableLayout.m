//
//  PVMainViewLayout.m
//  FlickrPhotoViewer
//
//  Created by Yann Bodson on 14/11/12.
//  Copyright (c) 2012 grimfrog. All rights reserved.
//

#import "PVScrollableLayout.h"

@implementation PVScrollableLayout

- (CGSize)collectionViewContentSize
{
    CGSize size = [super collectionViewContentSize];
    if (size.height < self.collectionView.bounds.size.height)
        size.height = self.collectionView.bounds.size.height + 1;
    return size;
}

@end
