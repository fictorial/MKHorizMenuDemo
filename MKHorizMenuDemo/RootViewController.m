//
//  RootViewController.m
//  HorizontalMenu
//
//  Created by Mugunth on 25/04/11.
//  Copyright 2011 Steinlogic. All rights reserved.
//

#import "RootViewController.h"

// Vastly altered by Brian Hammond <brian@fictorial.com> Jun 19 2013

@implementation RootViewController

- (void)viewDidLoad
{
    _horizMenu.items = @[ @"Headlines", @"UK", @"International", @"Politics", @"Weather",
                          @"Travel", @"Radio", @"Hollywood", @"Sports", @"Others" ];

    _horizMenu.maximumSelectionCount = 3;
    _horizMenu.itemTextColor = [UIColor colorWithRed:0.482 green:0.715 blue:0.788 alpha:1.000];
    _horizMenu.selectedItemTextColor = [UIColor colorWithRed:0.271 green:0.589 blue:0.292 alpha:1.000];
    _horizMenu.backgroundColor = [UIColor colorWithRed:0.742 green:0.880 blue:0.923 alpha:1.000];

    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated
{
    [self.horizMenu setSelectedIndex:5 animated:YES];
}

#pragma mark - MKHorizMenuDelegate

- (void)horizMenu:(MKHorizMenu *)horizMenu didSelectItem:(NSString *)item
{
    NSLog(@"Selected: %@", item);
}

- (void)horizMenu:(MKHorizMenu *)horizMenu didDeselectItem:(NSString *)item
{
    NSLog(@"Deselected: %@", item);
}

- (void)horizMenuDidTrySelectionAtCapacity:(MKHorizMenu *)horizMenu
{
    [[[UIAlertView alloc]
      initWithTitle:@"Oops!"
      message:@"You may select up to 3 items. Tap a selected item to deselect it."
      delegate:nil
      cancelButtonTitle:@"OK"
      otherButtonTitles:nil] show];
}

@end
