//
//  MKHorizMenu.h
//  MKHorizMenuDemo
//
//  Created by Mugunth on 09/05/11.
//  Copyright 2011 Steinlogic. All rights reserved.

//  Permission granted to do anything, commercial/non-commercial with this file apart from removing the line/URL above
//  Read my blog post at http://mk.sg/8h on how to use this code

//  As a side note on using this code, you might consider giving some credit to me by
//	1) linking my website from your app's website 
//	2) or crediting me inside the app's credits page 
//	3) or a tweet mentioning @mugunthkumar
//	4) A paypal donation to mugunth.kumar@gmail.com
//
//  A note on redistribution
//	While I'm ok with modifications to this source code, 
//	if you are re-publishing after editing, please retain the above copyright notices

// Vastly altered by Brian Hammond <brian@fictorial.com> Jun 19 2013

#import <UIKit/UIKit.h>

@class MKHorizMenu;

@protocol MKHorizMenuDelegate <NSObject>

- (void)horizMenu:(MKHorizMenu *)horizMenu didSelectItem:(NSString *)item;
- (void)horizMenu:(MKHorizMenu *)horizMenu didDeselectItem:(NSString *)item;
- (void)horizMenuDidTrySelectionAtCapacity:(MKHorizMenu *)horizMenu;

@end

@interface MKHorizMenu : UIScrollView

@property (copy, nonatomic) NSArray *items;
@property (copy, nonatomic) NSSet *selectedIndexes;
@property (strong, nonatomic) UIFont *itemFont;
@property (assign, nonatomic) NSUInteger itemPadding;
@property (strong, nonatomic) UIColor *itemTextColor;
@property (strong, nonatomic) UIColor *selectedItemTextColor;
@property (strong, nonatomic) UIImage *selectedItemBackgroundImage;
@property (assign, nonatomic) NSUInteger maximumSelectionCount;
@property (assign, nonatomic) BOOL canToggleSelections;
@property (assign, nonatomic) NSUInteger separatorDotSize;
@property (weak, nonatomic) IBOutlet id<MKHorizMenuDelegate> menuDelegate;

- (void)reloadData;
- (void)setSelectedIndex:(NSUInteger)selectedIndex animated:(BOOL)animated;

@end
