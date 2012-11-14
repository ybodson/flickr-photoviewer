//
//  PVFlickerEntry.h
//  PhotoViewer
//
//  Created by Yann Bodson on 1/11/12.
//  Copyright (c) 2012 grimfrog. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PVFlickerEntry;
@protocol PVFlickerEntryDownloadDelegate

- (void)thumbnailDowloadedForEntry:(PVFlickerEntry *)flickerEntry;

@end


@interface PVFlickerEntry : NSObject

@property (nonatomic, copy) NSString *key;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *thumbnail;
@property (nonatomic) CGSize size;
@property (nonatomic) CGFloat angle;
@property (nonatomic, weak) id<PVFlickerEntryDownloadDelegate> delegate;

- (NSString *)description;
- (void)loadThumbnail;

@end
