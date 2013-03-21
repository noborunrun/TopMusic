//
//  GBMainTableViewCell.h
//  GenomBrowser
//
//  Created by noboru on 2/21/13.
//  Copyright (c) 2013 NineDrafts In. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "GBMainCellScrollView.h"
#import "TSMainCollectionViewController.h"

@interface TSMainTableViewCell : UITableViewCell
{
//    GBMainScrollViewDelegate *scrollViewDelegate;

}

//@property (nonatomic,strong) IBOutlet GBMainCellScrollView *scrollView_;
@property (nonatomic,strong) IBOutlet TSMainCollectionViewController *collectionViewCon;
@property (nonatomic, strong) NSArray *protData;
@property (nonatomic, strong) NSString *track;

-(void)setScrollVIewSetting;
-(void)setCollectionView;
@end
