//
//  PVStackLayout.m
//  PhotoViewer
//
//  Created by Yann Bodson on 2/11/12.
//  Copyright (c) 2012 grimfrog. All rights reserved.
//

#import "PVStackLayout.h"
#import <QuartzCore/QuartzCore.h>

@implementation PVStackLayout

- (id)init
{
    self = [super init];
    if (self) {
        self.stackCenter = CGPointMake(120, 120);
        self.viewSize = CGSizeMake(240, 240);
    }
    return self;
}

- (CGSize)collectionViewContentSize
{
    return self.viewSize;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewLayoutAttributes* attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    attributes.size = [self.parent sizeForItemAtIndexPath:indexPath];
    attributes.center = self.stackCenter;
    attributes.zIndex = indexPath.row;
    CATransform3D final = CATransform3DConcat(CATransform3DMakeTranslation(0, 0, -indexPath.row),
                                              CATransform3DMakeRotation([self.parent angleForItemAtIndexPath:indexPath], 0, 0, 1));
    attributes.transform3D = final;
    return attributes;
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSMutableArray* attributes = [NSMutableArray array];
    for (NSInteger i=0 ; i < [self.collectionView numberOfItemsInSection:0]; i++) {
        NSIndexPath* indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        [attributes addObject:[self layoutAttributesForItemAtIndexPath:indexPath]];
    }
    return attributes;
}

@end
