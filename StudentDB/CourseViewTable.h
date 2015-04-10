//
//  CourseViewTable.h
//  StudentDB
//
//  Created by ashastry on 4/8/15.
//  Copyright (c) 2015 Aneesh Shastry. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>
#import "CourseDBManager.h"

@interface CourseViewTable : UITableViewController
@property (strong, nonatomic) NSString *databasePath;
@property (nonatomic) sqlite3 *courseDB;

@property (strong, nonatomic) IBOutlet UILabel *status;


- (NSArray *) getDataQuery;
- (void)addClicked:(id)sender;

@end
