//
//  GBMainCollectionViewController.m
//  GenomBrowser
//
//  Created by noboru on 3/10/13.
//  Copyright (c) 2013 NineDrafts Inc. All rights reserved.
//

#import "TSMainCollectionViewController.h"
#import "TSMainCollectionViewCell.h"
#import "TSLineDrawView.h"

@interface TSMainCollectionViewController ()

@end

@implementation TSMainCollectionViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.collectionView registerClass:[TSMainCollectionViewCell class] forCellWithReuseIdentifier:@"MAIN_CELL"];
    [self.view setBackgroundColor:[UIColor clearColor]];
    
    //    TODO: 全長をサーバから取得
//    self.allIndexCount = 249240621;
//    self.scale = [[(TSAppDelegate *)[[UIApplication sharedApplication] delegate] rootViewController] scale];

    self.collectionView.contentSize = CGSizeMake(self.allIndexCount/self.scale, self.view.frame.size.height);
    [super viewDidLoad];
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(receiveScrollNotification:) name:@"SCROLL_NOTIFICATION" object:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UICollectionViewDelegate
- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section;
{
    return self.allIndexCount/self.scale;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath;
{
    TSMainCollectionViewCell *cell = [cv dequeueReusableCellWithReuseIdentifier:@"MAIN_CELL" forIndexPath:indexPath];
    [cell setBackgroundColor:[UIColor clearColor]];
    
    TSLineDrawView *aView = [[TSLineDrawView alloc] initWithFrame:CGRectMake(0, 0, cell.frame.size.width, cell.frame.size.height)];
    [aView setBackgroundColor:[UIColor clearColor]];
    aView.indexPath = indexPath;
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0);
    dispatch_async(queue, ^{
//        データ取得
//        NSArray *aArray = [NSArray arrayWithArray:[[TSServerController sharedManager] getServerDataWithTracks:self.track Scale:self.scale TileIndex:indexPath.row TileCount:1 Format:@"json"]];
//        aView.protData = [NSArray arrayWithArray:[[[aArray objectAtIndex:0] objectForKey:@"val"] objectAtIndex:0]];

        dispatch_sync(dispatch_get_main_queue(), ^{
            [cell addSubview:aView];
            [aView setNeedsDisplay];
//            NSLog(@"index:%d::frame:%f,%f",indexPath.row,aView.frame.size.width,aView.frame.size.height);
        });
    });
    
    return cell;
}

#pragma mark - UIScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    //enshore that the end of scroll is fired.
    //    [self performSelector:@selector(scrollViewDidEndScrollingAnimation:) withObject:nil afterDelay:0.3];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"SCROLL_NOTIFICATION" object:scrollView];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
	// フリック操作によるスクロール終了
    //	[self endScroll];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
	if(!decelerate) {
		// ドラッグ終了 かつ 加速無し
        //		[self endScroll];
	}
}

- (void)receiveScrollNotification:(NSNotification *)notification {
    
    UIScrollView *stockTableView = notification.object;
//    NSLog(@"%f",stockTableView.contentOffset.x);
//    [[(TSAppDelegate *)[[UIApplication sharedApplication] delegate] rootViewController] slideAllCollecetionViewOffset:stockTableView.contentOffset];
//    self.tableView.contentOffset = stockTableView.contentOffset;
}

@end
