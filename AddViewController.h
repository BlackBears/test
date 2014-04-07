//
//  AddViewController.h
//  Dummy Test
//
//  Created by Jack Higgins on 4/5/14.
//  Copyright (c) 2014 Higgins Software Design. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddViewController : UIViewController

@property (strong) NSMutableArray *lists;
@property (strong) NSMutableArray *items;

@property (strong, nonatomic) IBOutlet UITextField *name;
@property (strong, nonatomic) IBOutlet UITextField *price;
@property (strong, nonatomic) IBOutlet UITextField *desc;


- (IBAction)cancel:(id)sender;
- (IBAction)save:(id)sender;

@end
