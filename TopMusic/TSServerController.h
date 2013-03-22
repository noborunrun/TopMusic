//
//  GBServerController.h
//  GenomBrowser
//
//  Created by noboru on 3/8/13.
//  Copyright (c) 2013 NineDrafts In. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TSServerController : NSObject
+(TSServerController *) sharedManager;

//Get
-(NSArray *)getSongRankingWithCountry:(NSString *)countryCode Count:(NSInteger)count;

@end
