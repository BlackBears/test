//
//  AddViewController.m
//  Dummy Test
//
//  Created by Jack Higgins on 4/5/14.
//  Copyright (c) 2014 Higgins Software Design. All rights reserved.
//

#import "AddViewController.h"
#import "ViewController.h"
#import "WishListView.h"
#import "List.h"
#import "Item.h"

@interface AddViewController ()

@end

@implementation AddViewController

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //  use the represented model object to fill in the text fields
    self.name.text = _item.name;
    self.price.text = _item.price;
    self.desc.text = _item.desc;
}
  

- (IBAction)cancel:(id)sender {
    if( self.completionBlock )
        self.completionBlock(NO);
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)save:(id)sender {
    NSManagedObjectContext *context = [self managedObjectContext];
    
    self.item.name = self.name.text;
    self.item.price = self.price.text;
    self.item.desc = self.desc.text;
    
    
    NSError *error = nil;
    // Save the object to persistent store
    if (![context save:&error]) {
        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
    }
    
    if( self.completionBlock ) {
        self.completionBlock(YES);
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end