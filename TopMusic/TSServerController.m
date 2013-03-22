//
//  GBServerController.m
//  GenomBrowser
//
//  Created by noboru on 3/8/13.
//  Copyright (c) 2013 NineDrafts In. All rights reserved.
//

#import "TSServerController.h"

@implementation TSServerController
static TSServerController *_sharedInstance = nil;

+(TSServerController *) sharedManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^{
        _sharedInstance = [[TSServerController alloc] init];
    });
    return _sharedInstance;
}

-(NSArray *)getSongRankingWithCountry:(NSString *)countryCode Count:(NSInteger)count
{
    NSString *paramString = [NSString stringWithFormat:@"/%@/rss/topsongs/limit=%d/json",countryCode,count];
    NSURL *url = [[NSURL alloc] initWithString:[NSString stringWithFormat:@"%@%@",kSERVERURL,paramString]];
    NSMutableArray *result = [NSMutableArray array];
    NSError *jsonError = nil;
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfURL:url] options:0 error:&jsonError];
    NSDictionary *feed = [json objectForKey:@"feed"];
    NSArray *entries = [feed objectForKey:@"entry"];
    for (NSDictionary *entry in entries) {
        iTunesItem *item = [[iTunesItem alloc] init];
        NSDictionary *imName = [entry objectForKey:@"im:name"];
        item.name = [imName objectForKey:@"label"];
        NSArray *imImages = [entry objectForKey:@"im:image"];
        NSDictionary *imImage = [imImages lastObject];
        NSString *url = [imImage objectForKey:@"label"];
        item.imageURL = [NSURL URLWithString:url];
        NSDictionary *idField = [entry objectForKey:@"id"];
        NSDictionary *attributes = [idField objectForKey:@"attributes"];
        item.trackId = [attributes objectForKey:@"im:id"];
        [result addObject:item];
    }
    
    return result;
}
@end
