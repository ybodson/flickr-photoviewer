//
//  PVFlickerEntry.h
//  PhotoViewer
//
//  Created by Yann Bodson on 1/11/12.
//  Copyright (c) 2012 grimfrog. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PVFlickerEntry : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *thumbnail;
@property (nonatomic) CGSize size;
@property (nonatomic) CGFloat angle;

- (NSString *)description;

@end
