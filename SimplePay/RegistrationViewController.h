//
//  RegistrationViewController.h
//  SimplePay
//
//  Created by Burak Colakoglu on 19.11.14.
//  Copyright (c) 2014 Colakoglu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegistrationViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *txt_firstName;
@property (weak, nonatomic) IBOutlet UITextField *txt_lastName;
@property (weak, nonatomic) IBOutlet UITextField *txt_birthday;
@property (weak, nonatomic) IBOutlet UITextField *txt_email;
@property (weak, nonatomic) IBOutlet UITextField *txt_street;
@property (weak, nonatomic) IBOutlet UITextField *txt_number;
@property (weak, nonatomic) IBOutlet UITextField *txt_postalCode;
@property (weak, nonatomic) IBOutlet UITextField *txt_place;
@property (weak, nonatomic) IBOutlet UITextField *txt_password;
@property (weak, nonatomic) IBOutlet UITextField *txt_payPin;

-(IBAction)removeKeyboard;

- (IBAction)btn_actionRegistration:(id)sender;


@end
