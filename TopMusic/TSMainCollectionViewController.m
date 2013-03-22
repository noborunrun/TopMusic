//
//  GBMainCollectionViewController.m
//  GenomBrowser
//
//  Created by noboru on 3/10/13.
//  Copyright (c) 2013 NineDrafts Inc. All rights reserved.
//

#import "TSMainCollectionViewController.h"
#import "TSMainCollectionViewCell.h"
#import "TSServerController.h"
#import "iTunesItem.h"

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
    
    self.collectionView.contentSize = CGSizeMake([self.storeData count] * 50, self.view.frame.size.height);
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
    return [self.storeData count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath;
{
    TSMainCollectionViewCell *cell = [cv dequeueReusableCellWithReuseIdentifier:@"MAIN_CELL" forIndexPath:indexPath];
    cell.titleLabel = [[UILabel alloc] init];
    cell.jacketImage = [[UIImageView alloc] init];

    [cell setBackgroundColor:[UIColor blueColor]];
    cell.titleLabel.backgroundColor = [UIColor whiteColor];
    cell.jacketImage.backgroundColor = [UIColor redColor];
    
    cell.titleLabel.frame = CGRectMake(0, 0, cell.frame.size.width, cell.frame.size.height);
    cell.jacketImage.frame = CGRectMake(0, 0, 175, 175);
    
    cell.titleLabel.text = [[self.storeData objectAtIndex:indexPath.row] name];
    [cell addSubview:cell.titleLabel];
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0);
    dispatch_async(queue, ^{
        NSURL *url = [[self.storeData objectAtIndex:indexPath.row] imageURL];
        NSData *data = [NSData dataWithContentsOfURL:url];
        UIImage *aImage = [UIImage imageWithData:data];

        dispatch_sync(dispatch_get_main_queue(), ^{
            cell.jacketImage.image = aImage;
            [cell addSubview:cell.jacketImage];
            [cell layoutIfNeeded];
        });
    });
    
    return cell;
}

#pragma mark - UIScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    //enshore that the end of scroll is fired.
    [[NSNotificationCenter defaultCenter] postNotificationName:@"SCROLL_NOTIFICATION" object:scrollView];
}

- (void)receiveScrollNotification:(NSNotification *)notification {
    
    UIScrollView *stockTableView = notification.object;
    [[(TSAppDelegate *)[[UIApplication sharedApplication] delegate] rootViewController] slideAllCollecetionViewOffset:stockTableView.contentOffset];
}

@end
