//
//  DaySpecificationViewController.h
//  SimplePay
//
//  Created by Burak Colakoglu on 16.12.14.
//  Copyright (c) 2014 Colakoglu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DaySpecificationViewController : UITableViewController

@property (weak, nonatomic) IBOutlet UITableView *daySpecificationTableView;
@property (strong, nonatomic) NSMutableArray *listOfDaySpecification;




@end
