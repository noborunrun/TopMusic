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
//    NSData *aData;
    NSArray *mainArray;
    NSArray *mapList;
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
    self.title = @"";
//    [(TSAppDelegate *)[[UIApplication sharedApplication] delegate] setRootViewController:self];
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
////    DummyData
//    NSError *error;
//    NSString *pathString = [[NSBundle mainBundle] pathForResource:@"sampleJsonData" ofType:@"json"];
//    NSString *dataString = [NSString stringWithContentsOfFile:pathString encoding:NSStringEncodingConversionAllowLossy error:&error];
//    id obj = [NSJSONSerialization JSONObjectWithData:[dataString dataUsingEncoding:NSStringEncodingConversionAllowLossy] options:NSJSONReadingAllowFragments error:&error];
//    
//    if (error) {
//        NSLog(@"%@",error);
//    }else {
//        mainArray = [NSArray arrayWithArray:obj];
////        NSLog(@"%@",mainArray);
////        NSLog(@"%@",[obj class]);
//        
//    }
    //    get Data from server
//    mainArray = [NSArray arrayWithArray:[[GBServerController sharedManager] getServerDataWithTracks:@"chr1-0|chr1-1" Scale:500 TileIndex:0 TileCount:10 Format:@"json"]];
//    NSLog(@"%d",[mainArray count]);
    
    
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
    // Return the number of sections.
//    return [mainArray count];
    return [mapList count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if (indexPath.section == 0) {
        static NSString *CellIdentifier = @"MainCell";
        
        UINib *nib = [UINib nibWithNibName:@"GBMainTableViewCell" bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:CellIdentifier];
        
        TSMainTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        
        // Configure the cell...
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        cell.protData = [[mainArray objectAtIndex:indexPath.section] objectForKey:@"val"];
        cell.track = [mapList objectAtIndex:indexPath.section];
        [cell performSelector:@selector(setCollectionView)];
    
        return cell;

//    }else {
//        static NSString *CellIdentifier = @"Cell";
//        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
//        // Configure the cell...
//        
//        return cell;
//    }
//    return nil;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
//    if (section == 0) {
//        return [[[mainArray objectAtIndex:0] allKeys] objectAtIndex:0];
//    }
//    NSLog(@"%d,%@",section,[[mainArray objectAtIndex:section] objectForKey:@"key"]);
    return [mapList objectAtIndex:section];
//    return @"";
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}

- (IBAction)selectScale:(id)sender {
    [self.tableView reloadData];
}

- (NSInteger)scale
{
    NSInteger scale = 500;
    if (self.scaleSegment.selectedSegmentIndex == 0) {
        scale = 500;
    }
    if (self.scaleSegment.selectedSegmentIndex == 1) {
        scale = 1000;
    }
    if (self.scaleSegment.selectedSegmentIndex == 2) {
        scale = 2000;
    }
    if (self.scaleSegment.selectedSegmentIndex == 3) {
        scale = 5000;
    }
    if (self.scaleSegment.selectedSegmentIndex == 4) {
        scale = 10000;
    }

    return scale;
}

-(void)slideAllCollecetionViewOffset:(CGPoint)offset
{
    for (int i = 0; i < [[self.tableView visibleCells] count]; i++ ) {
        TSMainCollectionViewController *aViewCon = [(TSMainTableViewCell *)[[self.tableView visibleCells] objectAtIndex:i] collectionViewCon];
        [aViewCon.collectionView setContentOffset:offset];
    }
}

@end
