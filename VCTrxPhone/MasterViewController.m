//
//  MasterViewController.m
//  VCTrxPhone
//
//  Created by Jim on 12/11/13.
//  Copyright (c) 2013 Jim. All rights reserved.
//

#import "MasterViewController.h"

#import "DetailViewController.h"
#import "AnimationControllerBase.h"
#import "BottomToTop.h"
#import "TopToBottom.h"
#import "ExpandFromCenter.h"

@interface MasterViewController () <UIViewControllerTransitioningDelegate, UINavigationControllerDelegate, UITableViewDelegate>
@property (nonatomic, strong) NSArray *objects;
@property (nonatomic, strong) AnimationControllerBase *animationController;

@end

@implementation MasterViewController

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.delegate = self;
    
    // Instantiate animations:
    _objects = @[
                 [[BottomToTop alloc] init],
                 [[TopToBottom alloc] init],
                 [[ExpandFromCenter alloc] init]
                 ];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _objects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

    AnimationControllerBase *object = _objects[indexPath.row];
    cell.textLabel.text = object.animationName;
    return cell;
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.animationController = _objects[indexPath.row];
    return indexPath;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        AnimationControllerBase *object = _objects[indexPath.row];
        [[segue destinationViewController] setDetailItem:object.animationName];
    }
}

#pragma mark - UIViewControllerTransitioningDelegate

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
                                                                  presentingController:(UIViewController *)presenting
                                                                      sourceController:(UIViewController *)source
{
    return self.animationController;
}


#pragma mark - UINavigationControllerDelegate

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                  animationControllerForOperation:(UINavigationControllerOperation)operation
                                               fromViewController:(UIViewController *)fromVC
                                                 toViewController:(UIViewController *)toVC
{
    self.animationController.isPopping = operation == UINavigationControllerOperationPop;
    return self.animationController;
}
@end
