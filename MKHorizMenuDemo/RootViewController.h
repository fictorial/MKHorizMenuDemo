//
//  RootViewController.h
//  HorizontalMenu
//
//  Created by Mugunth on 25/04/11.
//  Copyright 2011 Steinlogic. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MKHorizMenu.h"

// Vastly altered by Brian Hammond <brian@fictorial.com> Jun 19 2013

@interface RootViewController : UIViewController <MKHorizMenuDelegate>

@property (nonatomic, retain) IBOutlet MKHorizMenu *horizMenu;
@property (nonatomic, assign) IBOutlet UILabel *selectionItemLabel;

@end
