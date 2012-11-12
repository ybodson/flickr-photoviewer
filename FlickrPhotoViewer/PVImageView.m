//
//  PVImageView.m
//  PhotoViewer
//
//  Created by Yann Bodson on 1/11/12.
//  Copyright (c) 2012 grimfrog. All rights reserved.
//

#import "PVImageView.h"
#import "PVImageStore.h"

@interface PVImageView () <NSURLConnectionDelegate>

@property (nonatomic, strong) NSURLConnection *urlConnection;
@property (nonatomic, strong) NSMutableData *data;
@property (nonatomic, copy) NSString *url;

@end


@implementation PVImageView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

- (void)loadImageFromURLString:(NSString *)urlString
{
    self.image = [[PVImageStore sharedStore] imageForKey:urlString];
    
    if (self.image)
        return;
    
    self.url = urlString;
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]
                                             cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData
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
    self.image = [UIImage imageWithData:self.data];
    if (self.image)
        [[PVImageStore sharedStore] setImage:self.image forKey:self.url];
    else
        self.image = [[UIImage alloc] init];
    self.data = nil;
    self.urlConnection = nil;
    [self setNeedsDisplay];
}

@end
