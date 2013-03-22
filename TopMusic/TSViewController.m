//
//  GBGenomViewController.m
//  GenomBrowser
//
//  Created by noboru on 2/21/13.
//  Copyright (c) 2013 NineDrafts In. All rights reserved.
//

#import "TSViewController.h"
#import "TSMainTableViewCell.h"

@interface TSViewController ()
{
    NSArray *mainArray;
    NSArray *storeList;
}

@end

@implementation TSViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Uncomment the following line to preserve selection between presentations.
    [(TSAppDelegate *)[[UIApplication sharedApplication] delegate] setRootViewController:self];
    self.title = @"MusicStoreRanking";
    
    NSString* path = [[NSBundle mainBundle] pathForResource:@"storeList" ofType:@"plist"];
    storeList = [NSArray arrayWithContentsOfFile:path];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"MainCell"];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
//#warning Potentially incomplete method implementation.
    return [storeList count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//#warning Incomplete method implementation.
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
        static NSString *CellIdentifier = @"MainCell";
        UINib *nib = [UINib nibWithNibName:@"TSMainTableViewCell" bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:CellIdentifier];
        TSMainTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        // Configure the cell...
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0);
    dispatch_async(queue, ^{
        NSArray *songs = [NSArray arrayWithArray:[[TSServerController sharedManager] getSongRankingWithCountry:[storeList objectAtIndex:indexPath.section] Count:100]];
        cell.dataArray = [NSArray arrayWithArray:songs];
        dispatch_sync(dispatch_get_main_queue(), ^{
            [cell performSelector:@selector(setCollectionView)];
        });
    });
        return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [storeList objectAtIndex:section];
}

-(void)slideAllCollecetionViewOffset:(CGPoint)offset
{
    for (int i = 0; i < [[self.tableView visibleCells] count]; i++ ) {
        TSMainCollectionViewController *aViewCon = [(TSMainTableViewCell *)[[self.tableView visibleCells] objectAtIndex:i] collectionViewCon];
        [aViewCon.collectionView setContentOffset:offset];
    }
}

@end
