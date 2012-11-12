//
//  PVStackLayout.h
//  PhotoViewer
//
//  Created by Yann Bodson on 2/11/12.
//  Copyright (c) 2012 grimfrog. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PVStackLayoutDelegate

- (CGSize)sizeForItemAtIndexPath:(NSIndexPath *)indexPath;
- (CGFloat)angleForItemAtIndexPath:(NSIndexPath *)indexPath;

@end


@interface PVStackLayout : UICollectionViewLayout

@property (nonatomic, weak) id <PVStackLayoutDelegate> parent;
@property CGPoint stackCenter;
@property CGSize viewSize;

@end
