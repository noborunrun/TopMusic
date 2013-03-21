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

//-(NSArray *)getServerDataWithTracks:(NSString *)tracks Scale:(NSInteger)scale TileIndex:(NSInteger)tindex TileCount:(NSInteger)n Format:(NSString *)format
//{
//    NSError *error;
//    NSString *paramString = [NSString stringWithFormat:@"tracks=%@&scale=%d&tindex=%d&n=%d&format=%@",tracks,scale,tindex,n,format];
//    
//    NSString *escapedString = (__bridge NSString *)CFURLCreateStringByAddingPercentEscapes(
//                                                                                 kCFAllocatorDefault,
//                                                                                 (__bridge CFStringRef)paramString,
//                                                                                 NULL,
//                                                                                 (__bridge CFStringRef)@"!*'();:@+$,/?%#[]",
//                                                                                 kCFStringEncodingUTF8);
//    NSURL *url = [[NSURL alloc] initWithString:[NSString stringWithFormat:@"%@?%@",kSERVERURL,escapedString]];
////    NSLog(@"%@",url);
//    NSArray *aArray = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfURL:url] options:NSJSONReadingAllowFragments error:&error];
////    NSDictionary *dict = [NSJSONSerialization JSONObjectWithStream:[NSInputStream inputStreamWithURL:url] options:NSJSONReadingAllowFragments error:&error];
////    NSLog(@"%@",dict);
//    return aArray;
//}


@end
