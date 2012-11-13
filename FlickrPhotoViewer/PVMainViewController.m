//
//  PVViewController.m
//  PhotoViewer
//
//  Created by Yann Bodson on 1/11/12.
//  Copyright (c) 2012 grimfrog. All rights reserved.
//

#import "PVMainViewController.h"
#import "PVFeedController.h"
#import "PVFeedCell.h"
#import "PVPhotoCell.h"


@interface PVMainViewController () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) NSArray *feedControllers;
@property (nonatomic, strong) UIView *midView;
@property (nonatomic, strong) UICollectionView *frontView;
@property (nonatomic, strong) PVStackLayout *stackLayout;
@property (nonatomic, strong) UIBarButtonItem *backButton;
@property (nonatomic) CGPoint stackPosition;

@end


@implementation PVMainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.feedControllers = @[[[PVFeedController alloc] initWithTag:@"Wildlife"],
        [[PVFeedController alloc] initWithTag:@"Prague"],
        [[PVFeedController alloc] initWithTag:@"Nature"],
        [[PVFeedController alloc] initWithTag:@"Beach"]
    ];

    self.navigationItem.title = @"Flickr Photo Viewer";
    self.collectionView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"paper.jpg"]];
    [self.collectionView registerClass:[PVFeedCell class] forCellWithReuseIdentifier:@"FeedCell"];

    self.backButton = [[UIBarButtonItem alloc] initWithTitle:@"Back"
                                                       style:UIBarButtonItemStyleBordered
                                                      target:self
                                                      action:@selector(backPressed:)];
}

- (void)stackPressed
{
    UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc] init];
    flow.sectionInset = UIEdgeInsetsMake(20, 20, 20, 20);
    [self.navigationItem setRightBarButtonItem:self.backButton animated:YES];
    
    [UIView animateWithDuration:0.35
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

    [UIView animateWithDuration:0.35
                          delay:0
                        options:UIViewAnimationCurveEaseOut
                     animations:^{
                         self.frontView.collectionViewLayout = self.stackLayout;
                         self.midView.alpha = 0.0;
                     }
                     completion:^(BOOL finished){
                         self.frontView.alpha = 0.0;
                         self.frontView = nil;
                         self.midView = nil;
                         self.stackLayout = nil;
                     }];
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
    feedController.collectionView = collectionView;
    cell.feedViewController = feedController;
    cell.textField.text = feedController.tag;
    return cell;
}


#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    self.frontView.alpha = 1.0;
    PVFeedCell *cell = (PVFeedCell *)[self.collectionView cellForItemAtIndexPath:indexPath];
    CGPoint p = cell.frame.origin;
    p.x += 120;
    p.y = p.y + 120 - collectionView.contentOffset.y;
    self.stackPosition = p;
    
    self.stackLayout = [[PVStackLayout alloc] init];
    self.stackLayout.stackCenter = p;
//    NSLog(@"%@, %@, %@", NSStringFromCGRect(self.collectionView.frame), NSStringFromCGSize(self.collectionView.contentSize), NSStringFromCGPoint(self.stackPosition));
    self.stackLayout.viewSize = self.collectionView.frame.size;
    self.frontView = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:self.stackLayout];
    self.frontView.backgroundColor = [UIColor clearColor];
    [self.frontView registerClass:[PVPhotoCell class] forCellWithReuseIdentifier:@"PhotoCell"];
    
    PVFeedController *feedController = [self.feedControllers objectAtIndex:indexPath.row];
    
    self.frontView.dataSource = feedController;
    self.stackLayout.parent = feedController;
    self.frontView.delegate = feedController;
    self.midView = [[UIView alloc] initWithFrame:self.view.frame];
    self.midView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"paper.jpg"]];
    self.midView.alpha = 0.0;
    [self.view addSubview:self.midView];
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
