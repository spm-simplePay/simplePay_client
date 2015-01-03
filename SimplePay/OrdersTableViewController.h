//
//  OrdersTableViewController.h
//  SimplePay
//
//  Created by Burak Colakoglu on 02.01.15.
//  Copyright (c) 2015 Colakoglu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrdersTableViewController : UITableViewController

@property (weak, nonatomic) IBOutlet UITableView *ordersTableView;
@property (strong, nonatomic) NSMutableArray *listOfOrders;

@end
