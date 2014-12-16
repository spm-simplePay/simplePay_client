//
//  DaySpecificationInformationViewController.h
//  SimplePay
//
//  Created by Burak Colakoglu on 16.12.14.
//  Copyright (c) 2014 Colakoglu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tagesangebot.h"

@interface DaySpecificationInformationViewController : UITableViewController

@property (weak, nonatomic) IBOutlet UITableView *productTableView;
@property (strong, nonatomic) NSMutableArray *listOfProducts;

@end
