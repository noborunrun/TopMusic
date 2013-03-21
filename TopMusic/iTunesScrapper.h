//
//  iTunesScrapper.h
//  CollectionPlayground
//
//  Created by Brian Partridge on 6/19/12.
//  Copyright (c) 2012 Brian Partridge. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "iTunesItem.h"

@interface iTunesScrapper : NSObject

+ (iTunesScrapper *)sharedInstance;

- (void)topMovies:(void(^)(NSArray *movies))completion;

@end
