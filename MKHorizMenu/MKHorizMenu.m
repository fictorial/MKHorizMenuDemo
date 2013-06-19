//
//  MKHorizMenu.m
//  MKHorizMenuDemo
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

#import <QuartzCore/QuartzCore.h>

#import "MKHorizMenu.h"

enum
{
    kButtonBaseTag = 10000,
    kLeftOffset = 10
};

@implementation MKHorizMenu
{
    NSMutableSet *_selectedIndexes;
}

@synthesize selectedIndexes = _selectedIndexes;

- (void)awakeFromNib
{
    self.bounces = YES;
    self.scrollEnabled = YES;
    self.alwaysBounceHorizontal = YES;
    self.alwaysBounceVertical = NO;
    self.showsHorizontalScrollIndicator = NO;
    self.showsVerticalScrollIndicator = NO;

    self.itemFont = [UIFont boldSystemFontOfSize:15];
    self.itemTextColor = [UIColor grayColor];
    self.selectedItemTextColor = [UIColor whiteColor];
    self.selectedItemBackgroundImage = nil;
    self.itemPadding = 20;
    self.canToggleSelections = YES;
    self.maximumSelectionCount = 1;
    self.separatorDotSize = 4;

    _selectedIndexes = [NSMutableSet setWithCapacity:32];

    [self reloadData];
}

- (void)setItems:(NSArray *)theItems
{
    _items = [theItems copy];
    [_selectedIndexes removeAllObjects];
    [self reloadData];
}

- (void)setMaximumSelectionCount:(NSUInteger)n
{
    NSParameterAssert(n > 0);

    if (n != _maximumSelectionCount) {
        _maximumSelectionCount = n;
        [self deselectAll];
    }
}

- (void)reloadData
{
    NSArray *viewsToRemove = [self subviews];
	for (UIView *v in viewsToRemove) {
		[v removeFromSuperview];
	}
    
    NSInteger tag = kButtonBaseTag;
    CGFloat xPos = kLeftOffset;

    for (NSUInteger i = 0 ; i < _items.count; ++i) {
        UIButton *customButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [customButton setTitle:_items[i] forState:UIControlStateNormal];
        customButton.selected = [_selectedIndexes containsObject:@(i)];
        customButton.titleLabel.font = _itemFont;
        [customButton setTitleColor:_itemTextColor forState:UIControlStateNormal];
        [customButton setTitleColor:_selectedItemTextColor forState:UIControlStateHighlighted];
        [customButton setTitleColor:_selectedItemTextColor forState:UIControlStateSelected];
        [customButton setBackgroundImage:_selectedItemBackgroundImage forState:UIControlStateSelected];
        customButton.tag = tag++;
        
        [customButton addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
        
        int buttonWidth = [_items[i]
                           sizeWithFont:customButton.titleLabel.font
                           constrainedToSize:CGSizeMake(150, 28)
                           lineBreakMode:NSLineBreakByTruncatingTail].width;
        
        customButton.frame = CGRectMake(xPos, 7, buttonWidth + _itemPadding, 28);

        xPos += buttonWidth + _itemPadding;

        [self addSubview:customButton];

        if (_separatorDotSize > 0) {
            if (i < _items.count-1) {
                CGRect dotFrame = CGRectMake(CGRectGetMaxX(customButton.frame)-_separatorDotSize/2,
                                             CGRectGetMidY(customButton.frame)-_separatorDotSize/2,
                                             _separatorDotSize, _separatorDotSize);

                UIView *dotView = [[UIView alloc] initWithFrame:dotFrame];
                dotView.layer.cornerRadius = _separatorDotSize/2;
                dotView.backgroundColor = _itemTextColor;
                [self addSubview:dotView];
            }
        }
    }

    xPos += kLeftOffset;
    
    self.contentSize = CGSizeMake(xPos, 41);
    
    [self layoutSubviews];
}

- (void)deselectAll
{
    [_selectedIndexes removeAllObjects];

    for (NSNumber *index in _selectedIndexes) {
        UIButton *thisButton = (UIButton *)[self viewWithTag:index.integerValue + kButtonBaseTag];
        thisButton.selected = NO;

        [_menuDelegate horizMenu:self didDeselectItem:_items[index.integerValue]];
    }
}

- (void)setSelectedIndex:(NSUInteger)selectedIndex animated:(BOOL)animated
{
    [self deselectAll];

    self.selectedIndexes = [NSMutableSet setWithObject:@(selectedIndex)];

    UIButton *thisButton = (UIButton *)[self viewWithTag:selectedIndex + kButtonBaseTag];
    thisButton.selected = YES;

    [self setContentOffset:CGPointMake(thisButton.frame.origin.x - kLeftOffset, 0)
                  animated:animated];
}

- (void)setSelectedIndexes:(NSSet *)theSelectedIndexes
{
    [self deselectAll];

    _selectedIndexes = [theSelectedIndexes mutableCopy];

    if (_selectedIndexes.count > 0) {
        [self reloadData];

        for (NSNumber *index in _selectedIndexes) {
            UIButton *thisButton = (UIButton *)[self viewWithTag:index.integerValue + kButtonBaseTag];
            thisButton.selected = YES;

            [_menuDelegate horizMenu:self didSelectItem:_items[index.integerValue]];
        }
    }
}

- (void)buttonTapped:(UIButton *)button
{
    for (NSUInteger i = 0; i < _items.count; ++i) {
        UIButton *thisButton = (UIButton *)[self viewWithTag:i + kButtonBaseTag];

        if (i + kButtonBaseTag == button.tag) {
            if (thisButton.selected) {
                if (_canToggleSelections) {
                    thisButton.selected = NO;

                    [_selectedIndexes removeObject:@(i)];

                    [_menuDelegate horizMenu:self didDeselectItem:_items[i]];
                }
            } else if (![_selectedIndexes containsObject:@(i)]) {
                if (_selectedIndexes.count < _maximumSelectionCount) {
                    thisButton.selected = YES;

                    [_selectedIndexes addObject:@(i)];

                    [_menuDelegate horizMenu:self didSelectItem:_items[i]];
                } else {
                    [_menuDelegate horizMenuDidTrySelectionAtCapacity:self];
                }
            }
        } else if (button != thisButton && !_maximumSelectionCount) {
            if (thisButton.selected) {
                thisButton.selected = NO;
                [_menuDelegate horizMenu:self didSelectItem:_items[i]];
            }
        }
    }

    NSLog(@"selected items: %@", _selectedIndexes);
}

@end
