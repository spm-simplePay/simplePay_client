//
//  MenuCardViewController.h
//  SimplePay
//
//  Created by Burak Colakoglu on 09.11.14.
//  Copyright (c) 2014 Colakoglu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuCardViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *productsTableView;

@property (strong, nonatomic) NSMutableArray *listOfProducts;
@property (strong, nonatomic) NSMutableArray *searchResults;

@end
