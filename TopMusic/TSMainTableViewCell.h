//
//  GBMainTableViewCell.h
//  GenomBrowser
//
//  Created by noboru on 2/21/13.
//  Copyright (c) 2013 NineDrafts In. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TSMainCollectionViewController.h"

@interface TSMainTableViewCell : UITableViewCell
{

}

@property (nonatomic,strong) IBOutlet TSMainCollectionViewController *collectionViewCon;
@property (nonatomic, strong) NSArray *dataArray;

-(void)setCollectionView;
@end
