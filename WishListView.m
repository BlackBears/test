//
//  WishListView.m
//  Dummy Test
//
//  Created by Jack Higgins on 4/5/14.
//  Copyright (c) 2014 Higgins Software Design. All rights reserved.
//

#import "WishListView.h"
#import "ViewController.h"
#import "AddViewController.h"
#import "List.h"
#import "Item.h"

@interface WishListView ()
@property (nonatomic, copy) NSArray *items;
@end

@implementation WishListView

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    Item *item = self.items[indexPath.row];
    cell.textLabel.text = item.name;
    
    return cell;
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete object from managed object context
        Item *deletionItem = self.items[indexPath.row];
        [[self managedObjectContext] deleteObject:deletionItem];
        
        NSError *error = nil;
        if (![[self managedObjectContext] save:&error]) {
            NSLog(@"Can't Delete! %@ %@", error, [error localizedDescription]);
            return;
        }
        _items = nil;
        
        [tableView beginUpdates];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [tableView endUpdates];
    }
}



#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

}

- (NSArray *)items {
    if( !_items ) {
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Item"];
        fetchRequest.predicate = [NSPredicate predicateWithFormat:@"list = %@",self.list];
        NSError *fetchError = nil;
        _items = [[self managedObjectContext] executeFetchRequest:fetchRequest error:&fetchError];
        if( !_items ) {
            NSLog(@"ERROR while fetching items %@,%@",fetchError,fetchError.userInfo);
        }
    }
    return _items;
}


#pragma mark - Segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    Item *selectedItem = nil;
    AddViewController *destViewController = segue.destinationViewController;
    
    if ([[segue identifier] isEqualToString:@"ShowDetails"]) {
        //  if there's a selected item, display it.
        NSIndexPath *indexPath = [[self tableView] indexPathForSelectedRow];
        selectedItem = self.items[indexPath.row];
        destViewController.item = selectedItem;
        destViewController.completionBlock = ^(BOOL saved) {
            if( saved ) {
                _items = nil;
                [[self tableView] reloadData];
            }
        };
    }
    else if( [[segue identifier] isEqualToString:@"AddItem"] ) {
        //  if there's not, then create one
        selectedItem = [NSEntityDescription insertNewObjectForEntityForName:@"Item" inManagedObjectContext:self.managedObjectContext];
        selectedItem.list = self.list;
        destViewController.item = selectedItem;
        destViewController.completionBlock = ^(BOOL saved){
            if( !saved ) {
                [[self managedObjectContext] deleteObject:selectedItem];
            }
            else {
                _items = nil;
                [[self tableView] reloadData];
            }
        };
    }
}

@end

