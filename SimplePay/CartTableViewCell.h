//
//  TableViewCell.h
//  SimplePay
//
//  Created by Burak Colakoglu on 09.12.14.
//  Copyright (c) 2014 Colakoglu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CartTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *lb_productName;

@property (weak, nonatomic) IBOutlet UILabel *lb_quantity;

@property (weak, nonatomic) IBOutlet UILabel *lb_sum;

@end
