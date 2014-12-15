//
//  ProductInformationTableViewController.h
//  SimplePay
//
//  Created by Burak Colakoglu on 08.12.14.
//  Copyright (c) 2014 Colakoglu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Produkt.h"

@interface ProductInformationTableViewController : UITableViewController

@property (retain) Produkt  *product;

@property (weak, nonatomic) IBOutlet UILabel *lb_label;
@property (weak, nonatomic) IBOutlet UILabel *lb_price;
@property (weak, nonatomic) IBOutlet UILabel *lb_quantityUnit;
@property (weak, nonatomic) IBOutlet UILabel *lb_sum;

@property (weak, nonatomic) IBOutlet UITextField *lb_quantity;


- (IBAction)btn_actionAddToCart:(id)sender;


@end
