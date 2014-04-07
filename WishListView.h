//
//  WishListView.h
//  Dummy Test
//
//  Created by Jack Higgins on 4/5/14.
//  Copyright (c) 2014 Higgins Software Design. All rights reserved.
//

@class List;

@interface WishListView : UITableViewController

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong) List *list;

@property (strong, nonatomic) NSArray *DetailModal;

@end
