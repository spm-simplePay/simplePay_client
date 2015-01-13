//
//  ViewController.h
//  SimplePay
//
//  Created by Burak Colakoglu on 09.11.14.
//  Copyright (c) 2014 Colakoglu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *txt_email;
@property (weak, nonatomic) IBOutlet UITextField *txt_password;

- (IBAction)btn_actionLogin:(id)sender;
-(void) postUserLogin;

@end

