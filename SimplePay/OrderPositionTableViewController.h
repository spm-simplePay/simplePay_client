//
//  OrderPositionTableViewController.h
//  SimplePay
//
//  Created by Burak Colakoglu on 02.01.15.
//  Copyright (c) 2015 Colakoglu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Quittung.h"

@interface OrderPositionTableViewController : UITableViewController

@property (strong, nonatomic) IBOutlet UITableView *orderPositionTableView;
@property (retain) Quittung  *quittung;

@end
