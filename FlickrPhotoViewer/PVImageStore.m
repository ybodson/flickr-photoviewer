//
//  PVImageStore.m
//  PhotoViewer
//
//  Created by Yann Bodson on 3/11/12.
//  Copyright (c) 2012 grimfrog. All rights reserved.
//

#import "PVImageStore.h"

@interface PVImageStore ()

@property (nonatomic, strong) NSMutableDictionary *images;

@end


@implementation PVImageStore

+ (PVImageStore *)sharedStore
{
    static PVImageStore *sharedStore = nil;
    if (sharedStore == nil)
        sharedStore = [[PVImageStore alloc] init];
    return sharedStore;
}

- (id)init
{
    self = [super init];
    if (self) {
        self.images = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (void)setImage:(UIImage *)image forKey:(NSString *)key
{
    if (image)
        [self.images setObject:image forKey:key];
    else
        [self.images setObject:[[UIImage alloc] init] forKey:key];
}

- (UIImage *)imageForKey:(NSString *)key
{
    return [self.images objectForKey:key];
}

@end
