//
//  GBMainCollectionViewController.h
//  GenomBrowser
//
//  Created by noboru on 3/10/13.
//  Copyright (c) 2013 NineDrafts Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TSMainCollectionViewController : UICollectionViewController

@property (nonatomic, strong) NSArray *protArray;
@property (nonatomic, strong) NSString *track;
@property (nonatomic) NSInteger scale;
@property (nonatomic) NSInteger titleIndex;
@property (nonatomic) NSInteger titleCount;
@property (nonatomic) NSInteger allIndexCount;
//@property (nonatomic) NSInteger index;
@end
