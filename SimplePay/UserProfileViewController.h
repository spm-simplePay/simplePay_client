//
//  UserProfileViewController.h
//  SimplePay
//
//  Created by Burak Colakoglu on 11.01.15.
//  Copyright (c) 2015 Colakoglu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserProfileViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *txt_firstAndLastName;

@property (weak, nonatomic) IBOutlet UILabel *txt_birthday;

@property (weak, nonatomic) IBOutlet UILabel *txt_streetAndNumber;

@property (weak, nonatomic) IBOutlet UILabel *txt_postalCode;

@property (weak, nonatomic) IBOutlet UILabel *txt_place;

@end
