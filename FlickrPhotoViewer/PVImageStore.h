//
//  PVImageStore.h
//  PhotoViewer
//
//  Created by Yann Bodson on 3/11/12.
//  Copyright (c) 2012 grimfrog. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PVImageStore : NSObject

+ (PVImageStore *)sharedStore;

- (void)setImage:(UIImage *)image forKey:(NSString *)key;
- (UIImage *)imageForKey:(NSString *)key;

@end
