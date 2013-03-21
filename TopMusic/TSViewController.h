//
//  GBGenomViewController.h
//  GenomBrowser
//
//  Created by noboru on 2/21/13.
//  Copyright (c) 2013 NineDrafts In. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TSViewController : UITableViewController
@property (strong, nonatomic) IBOutlet UISegmentedControl *scaleSegment;
- (NSInteger)scale;

- (IBAction)selectScale:(id)sender;
-(void)slideAllCollecetionViewOffset:(CGPoint)offset;

@end
