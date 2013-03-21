//
//  GBMainTableViewCell.m
//  GenomBrowser
//
//  Created by noboru on 2/21/13.
//  Copyright (c) 2013 NineDrafts In. All rights reserved.
//

#import "TSMainTableViewCell.h"

@implementation TSMainTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code

    }
    return self;
}

//-(void)setScrollViewSetting
//{
//    self.scrollView_.delegate = scrollViewDelegate;
////    self.scrollView_.contentSize = CGSizeMake(self.frame.size.width+200, self.frame.size.height);
//    self.scrollView_.protData = [self.protData objectAtIndex:0];
//    [self addSubview:self.scrollView_];
//    
//}

-(void)setCollectionView
{
    self.collectionViewCon = [[TSMainCollectionViewController alloc] initWithNibName:@"GBMainCollectionViewController" bundle:nil];
    self.collectionViewCon.track = self.track;
    self.collectionViewCon.view.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    [self addSubview:self.collectionViewCon.view];
    
}

-(void)layoutSubviews
{
    [super layoutSubviews];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
