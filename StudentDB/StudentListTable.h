//
//  StudentListTable.h
//  StudentDB
//
//  Created by ashastry on 4/8/15.
//  Copyright (c) 2015 Aneesh Shastry. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>
#import "CourseViewTable.h"

@interface StudentListTable : UITableViewController

@property (strong, nonatomic) CourseViewTable * parent;
@property (strong, nonatomic) NSString * selectedCourse;
@property (strong, nonatomic) CourseDBManager * crsDB;

@end
