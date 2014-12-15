//
//  CartTableViewController.h
//  SimplePay
//
//  Created by Burak Colakoglu on 08.12.14.
//  Copyright (c) 2014 Colakoglu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CartTableViewController : UITableViewController

@property (strong, nonatomic) IBOutlet UITableView *cartTableView;


@property (weak, nonatomic) IBOutlet UILabel *lb_totalSum;


- (IBAction)btn_actionClearAllCartObjects:(id)sender;

@end
