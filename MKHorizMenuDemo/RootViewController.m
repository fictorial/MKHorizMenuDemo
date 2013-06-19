//
//  RootViewController.m
//  HorizontalMenu
//
//  Created by Mugunth on 25/04/11.
//  Copyright 2011 Steinlogic. All rights reserved.
//

#import "RootViewController.h"

@implementation RootViewController

@synthesize horizMenu = _horizMenu;
@synthesize items = _items;
@synthesize selectionItemLabel = _selectionItemLabel;


- (void)viewDidLoad
{
    self.items = [NSArray arrayWithObjects:@"Headlines", @"UK", @"International", @"Politics", @"Weather", @"Travel", @"Radio", @"Hollywood", @"Sports", @"Others", nil];    
    [self.horizMenu reloadData];
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload
{
    [super viewDidUnload];

    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
    self.selectionItemLabel = nil;
}

-(void) viewDidAppear:(BOOL)animated
{
    [self.horizMenu setSelectedIndex:5 animated:YES];
}

- (void)dealloc
{
    [super dealloc];
}

#pragma mark -
#pragma mark HorizMenu Data Source
- (UIImage*) selectedItemImageForMenu:(MKHorizMenu*) tabMenu
{
    return nil;
}

- (UIColor*) labelColorForMenu:(MKHorizMenu*) tabMenu
{
    return [UIColor colorWithWhite:0.70f alpha:1.0f];
}

- (UIColor*) labelSelectedColorForMenu:(MKHorizMenu*) tabMenu
{
    return [UIColor whiteColor];
}

- (UIColor *)labelHighlightedColorForMenu:(MKHorizMenu *)tabMenu
{
    return [UIColor grayColor];
}

- (UIFont*) labelFontForMenu:(MKHorizMenu*) tabMenu
{
    return [UIFont fontWithName:@"HelveticaNeue-Light" size:20];
}

- (int) itemPaddingForMenu:(MKHorizMenu*) tabMenu
{
    return 22;
}

- (UIColor*) backgroundColorForMenu:(MKHorizMenu *)tabView
{
    return nil;
}

- (int) numberOfItemsForMenu:(MKHorizMenu *)tabView
{
    return [self.items count];
}

- (NSString*) horizMenu:(MKHorizMenu *)horizMenu titleForItemAtIndex:(NSUInteger)index
{
    return [self.items objectAtIndex:index];
}

#pragma mark -
#pragma mark HorizMenu Delegate
-(void) horizMenu:(MKHorizMenu *)horizMenu itemSelectedAtIndex:(NSUInteger)index
{        
    self.selectionItemLabel.text = [self.items objectAtIndex:index];
}
@end
