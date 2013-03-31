//
//  ViewController.h
//  CoreDataTutorialz
//
//  Created by admin on 30.03.13.
//  Copyright (c) 2013 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *firstnameTextField;
@property (weak, nonatomic) IBOutlet UITextField *lastnameTextField;
@property (weak, nonatomic) IBOutlet UILabel *displayLabel;
- (IBAction)addPersonButton:(id)sender;
- (IBAction)searchButton:(id)sender;
- (IBAction)deleteButton:(id)sender;

@end
