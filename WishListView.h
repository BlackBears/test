//
//  WishListView.h
//  Dummy Test
//
//  Created by Jack Higgins on 4/5/14.
//  Copyright (c) 2014 Higgins Software Design. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WishListView : UITableViewController
@property (strong) NSMutableArray *lists;
@property (strong) NSMutableArray *items;
@property (strong, nonatomic) NSArray *DetailModal;

@end
