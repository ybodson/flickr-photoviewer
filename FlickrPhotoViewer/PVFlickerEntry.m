//
//  PVFlickerEntry.m
//  PhotoViewer
//
//  Created by Yann Bodson on 1/11/12.
//  Copyright (c) 2012 grimfrog. All rights reserved.
//

#import "PVFlickerEntry.h"

@implementation PVFlickerEntry

- (id)init
{
    self = [super init];
    if (self) {
        self.angle = (arc4random() % 6 / 10.0) - 0.3;
    }
    return self;
}

- (CGSize)size
{
    return CGSizeMake(_size.width * 0.8, _size.height * 0.8);
}

- (NSString *)description
{
    NSString *desc = [NSString stringWithFormat:@"title: %@\nthumbnail: %@\n", self.title, self.thumbnail];
    return desc;
}

@end
