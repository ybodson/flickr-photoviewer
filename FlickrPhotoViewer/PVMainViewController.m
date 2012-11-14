//
//  PVViewController.m
//  PhotoViewer
//
//  Created by Yann Bodson on 1/11/12.
//  Copyright (c) 2012 grimfrog. All rights reserved.
//

#import "PVMainViewController.h"
#import "PVScrollableLayout.h"
#import "PVFeedController.h"
#import "PVFeedCell.h"
#import "PVPhotoCell.h"


@interface PVMainViewController () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) NSArray *feedControllers;
@property (nonatomic, strong) UIView *midView;
@property (nonatomic, strong) UICollectionView *frontView;
@property (nonatomic, strong) PVStackLayout *stackLayout;
@property (nonatomic, strong) UIBarButtonItem *backButton;
@property (nonatomic, weak) PVFeedCell *selectedCell;

@end


@implementation PVMainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.feedControllers = @[[[PVFeedController alloc] initWithTag:@"Wildlife"],
        [[PVFeedController alloc] initWithTag:@"Flowers"],
        [[PVFeedController alloc] initWithTag:@"Nature"],
        [[PVFeedController alloc] initWithTag:@"Beach"]
    ];

    self.navigationItem.title = @"Flickr Photo Viewer";
    self.collectionView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"paper.jpg"]];
    [self.collectionView registerClass:[PVFeedCell class] forCellWithReuseIdentifier:@"FeedCell"];

    UIColor *brownish = [UIColor colorWithRed:147.0/255 green:133.0/255 blue:116.0/255 alpha:1.0];
    
    [[UINavigationBar appearance] setTintColor:brownish];
    [[UIRefreshControl appearance] setTintColor:brownish];
    
    self.backButton = [[UIBarButtonItem alloc] initWithTitle:@"Back"
                                                       style:UIBarButtonItemStyleBordered
                                                      target:self
                                                      action:@selector(backPressed:)];
}

- (void)stackPressed
{
    PVScrollableLayout *flow = [[PVScrollableLayout alloc] init];
    flow.sectionInset = UIEdgeInsetsMake(20, 20, 20, 20);
    self.selectedCell.alpha = 0.0;
    self.navigationItem.title = self.selectedCell.textField.text;
    [self.navigationItem setRightBarButtonItem:self.backButton animated:YES];
    
    [UIView animateWithDuration:0.4
                          delay:0
                        options:UIViewAnimationCurveEaseOut
                     animations:^{
                         self.frontView.collectionViewLayout = flow;
                         self.midView.alpha = 1.0;
                     }
                     completion:^(BOOL finished){
                         self.stackLayout.viewSize = self.frontView.bounds.size;
                     }];
}

- (void)backPressed:(id)sender
{
    [self.navigationItem setRightBarButtonItem:nil animated:YES];
    self.navigationItem.title = @"Flickr Photo Viewer";

    [UIView animateWithDuration:0.4
                          delay:0
                        options:UIViewAnimationCurveEaseOut
                     animations:^{
                         self.frontView.collectionViewLayout = self.stackLayout;
                         self.midView.alpha = 0.0;
                     }
                     completion:^(BOOL finished){
                         self.frontView.alpha = 0.0;
                         self.frontView = nil;
                         self.midView.alpha = 0.0;
                         self.stackLayout = nil;
                         self.selectedCell.alpha = 1.0;
                     }];
}

- (void)createMiddleView
{
    if (self.midView)
        return;

    self.midView = [[UIView alloc] initWithFrame:self.view.frame];
    self.midView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"paper.jpg"]];
    self.midView.alpha = 0.0;
    [self.view addSubview:self.midView];

}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section
{
    return self.feedControllers.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PVFeedCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FeedCell" forIndexPath:indexPath];
    PVFeedController *feedController = [self.feedControllers objectAtIndex:indexPath.row];
    feedController.stackCollectionView = cell.collectionView;
    cell.feedViewController = feedController;
    cell.textField.text = feedController.tag;
    return cell;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    self.selectedCell = (PVFeedCell *)[self.collectionView cellForItemAtIndexPath:indexPath];

    CGPoint p;
    p.x = CGRectGetMidX(self.selectedCell.frame);
    p.y = CGRectGetMidY(self.selectedCell.frame) - collectionView.contentOffset.y;
    
    self.stackLayout = [[PVStackLayout alloc] init];
    self.stackLayout.stackCenter = p;
    self.stackLayout.viewSize = self.collectionView.bounds.size;
    self.frontView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:self.stackLayout];
    
    PVFeedController *feedController = [self.feedControllers objectAtIndex:indexPath.row];

    if (feedController.refreshControl == nil)
        feedController.refreshControl = [[UIRefreshControl alloc] init];
    [feedController.refreshControl addTarget:feedController action:@selector(refreshFeed) forControlEvents:UIControlEventValueChanged];
    [self.frontView addSubview:feedController.refreshControl];
    
    self.frontView.backgroundColor = [UIColor clearColor];
    [self.frontView registerClass:[PVPhotoCell class] forCellWithReuseIdentifier:@"PhotoCell"];
    
    feedController.gridCollectionView = self.frontView;
    self.frontView.dataSource = feedController;
    self.stackLayout.delegate = feedController;
    self.frontView.delegate = feedController;
    [self createMiddleView];
    [self.view addSubview:self.frontView];
    
    [NSTimer scheduledTimerWithTimeInterval:0.0 target:self selector:@selector(stackPressed) userInfo:nil repeats:NO];
}


#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(240, 240);
}

@end
