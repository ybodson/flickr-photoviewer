//
//  PVFlickerFeed.h
//  PhotoViewer
//
//  Created by Yann Bodson on 1/11/12.
//  Copyright (c) 2012 grimfrog. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol PVFlickerFeedDelegate

- (void)feedFetched;

@end


@interface PVFlickerFeed : NSObject

@property (nonatomic, weak) id <PVFlickerFeedDelegate> delegate;
@property (nonatomic, copy) NSString *tag;
@property (nonatomic, strong) NSMutableArray *entries;

- (id)initWithTag:(NSString *)tag;
- (void)fetchEntries;
- (NSString *)description;

@end
