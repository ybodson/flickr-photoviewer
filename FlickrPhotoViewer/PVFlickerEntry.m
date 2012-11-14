//
//  PVFlickerEntry.m
//  PhotoViewer
//
//  Created by Yann Bodson on 1/11/12.
//  Copyright (c) 2012 grimfrog. All rights reserved.
//

#import "PVFlickerEntry.h"
#import "PVImageStore.h"

@interface PVFlickerEntry ()

@property (nonatomic, strong) NSURLConnection *urlConnection;
@property (nonatomic, strong) NSMutableData *data;

@end


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
    NSString *desc = [NSString stringWithFormat:@"title: %@\nthumbnail: %@\n", self.title, self.thumbnailURL];
    return desc;
}

- (void)loadThumbnail
{
    UIImage *image = [[PVImageStore sharedStore] imageForKey:self.thumbnailURL];

    if (image)
        return;
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.thumbnailURL]
                                             cachePolicy:NSURLRequestReloadRevalidatingCacheData
                                         timeoutInterval:30.0];
    self.urlConnection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)incrementalData
{
    if (self.data == nil)
        self.data = [[NSMutableData alloc] init];
    [self.data appendData:incrementalData];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"%@", error);
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    UIImage *image = [UIImage imageWithData:self.data];
    if (image)
        [[PVImageStore sharedStore] setImage:image forKey:self.thumbnailURL];
    self.data = nil;
    self.urlConnection = nil;
    [self.delegate thumbnailDowloadedForEntry:self];
}

@end
