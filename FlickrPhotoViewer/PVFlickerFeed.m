//
//  PVFlickerFeed.m
//  PhotoViewer
//
//  Created by Yann Bodson on 1/11/12.
//  Copyright (c) 2012 grimfrog. All rights reserved.
//

#import "PVFlickerFeed.h"
#import "PVFlickerEntry.h"

@interface PVFlickerFeed ()

@property (nonatomic, strong) NSURLConnection *urlConnection;
@property (nonatomic, strong) NSMutableData *xmlData;

@end


@implementation PVFlickerFeed

- (id)initWithTag:(NSString *)tag
{
    self = [super init];
    if (self) {
        self.entries = [[NSMutableArray alloc] init];
        self.tag = tag;
    }
    return self;
}

- (NSString *)description
{
    NSString *desc = nil;
    for (PVFlickerEntry *entry in self.entries) {
        desc = [desc stringByAppendingString:entry.description];
    }
    return desc;
}

- (void)fetchEntries
{
    //self.entries = nil;
    self.xmlData = [[NSMutableData alloc] init];
    static NSString *flickrFeed = @"http://api.flickr.com/services/feeds/photos_public.gne?format=json&tags=";
    
    NSString *st = [flickrFeed stringByAppendingString:self.tag];
    NSURL *url = [NSURL URLWithString:st];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    self.urlConnection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [self.xmlData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSRange range;
    range.location = 15;
    range.length = self.xmlData.length - 16;
    
    NSData *realData = [self.xmlData subdataWithRange:range];

    NSString *s = [[NSString alloc] initWithData:realData encoding:NSUTF8StringEncoding];
    NSString *s2 = [s stringByReplacingOccurrencesOfString:@"\\'" withString:@"'"];
    
    NSError *error = nil;
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:[s2 dataUsingEncoding:NSUTF8StringEncoding]
                                                         options:NSJSONReadingAllowFragments
                                                           error:&error];
    self.xmlData = nil;
    self.urlConnection = nil;
    if (error) {
        NSLog(@"%@", error);
        return;
    }
    
    NSArray *array = [dict objectForKey:@"items"];
    
    for (NSDictionary *dic in array) {
        NSString *title = [dic objectForKey:@"title"];
        
        NSString *desc = [dic objectForKey:@"description"];
        PVFlickerEntry *entry = [[PVFlickerEntry alloc] init];

        NSRegularExpression *wre = [[NSRegularExpression alloc] initWithPattern:@"width=\"([0-9]+)\""
                                                                        options:NSRegularExpressionCaseInsensitive
                                                                          error:nil];
        NSArray *wm = [wre matchesInString:desc options:0 range:NSMakeRange(0, desc.length)];
        if ([wm count] > 0) {
            NSTextCheckingResult *result = [wm objectAtIndex:0];
            NSRange range = [result rangeAtIndex:0];
            CGSize size = entry.size;
            size.width = [[[desc substringWithRange:range] substringWithRange:NSMakeRange(7, 3)] intValue];
            entry.size = size;
        }
        NSRegularExpression *hre = [[NSRegularExpression alloc] initWithPattern:@"height=\"([0-9]+)\""
                                                                        options:NSRegularExpressionCaseInsensitive
                                                                          error:nil];
        NSArray *hm = [hre matchesInString:desc options:0 range:NSMakeRange(0, desc.length)];
        if ([hm count] > 0) {
            NSTextCheckingResult *result = [hm objectAtIndex:0];
            NSRange range = [result rangeAtIndex:0];
            CGSize size = entry.size;
            size.height = [[[desc substringWithRange:range] substringWithRange:NSMakeRange(8, 3)] intValue];
            entry.size = size;
        }
        
        NSDictionary *dic2 = [dic objectForKey:@"media"];
        NSString *u = [dic2 objectForKey:@"m"];
        entry.title = title;
        entry.thumbnail = u;
        [self.entries insertObject:entry atIndex:0];
    }
    [self.delegate feedFetched];
}

@end
