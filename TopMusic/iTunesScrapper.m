//
//  iTunesScrapper.m
//  CollectionPlayground
//
//  Created by Brian Partridge on 6/19/12.
//  Copyright (c) 2012 Brian Partridge. All rights reserved.
//

#import "iTunesScrapper.h"

static NSString * const moviesFeed = @"http://itunes.apple.com/jp/rss/topsongs/limit=25/json";

@implementation iTunesScrapper

+ (iTunesScrapper *)sharedInstance {
   static iTunesScrapper *instance = nil;
   static dispatch_once_t onceToken;
   dispatch_once(&onceToken, ^{
      instance = [[iTunesScrapper alloc] init];
   });
   return instance;
}

- (void)topMovies:(void(^)(NSArray *movies))completion {
   NSURL *url = [NSURL URLWithString:moviesFeed];
   NSURLRequest *req = [NSURLRequest requestWithURL:url];
   [NSURLConnection sendAsynchronousRequest:req
                                      queue:[NSOperationQueue mainQueue]
                          completionHandler:^(NSURLResponse *resp, NSData *data, NSError *error) {
                             NSMutableArray *result = [NSMutableArray array];

                             if (error == nil) {
                                NSError *jsonError = nil;
                                NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
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
                             }

                             if (completion != nil) {
                                completion(result);
                             }
                          }];
}

@end

