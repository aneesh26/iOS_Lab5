//
//  studentSelectView.h
//  StudentDB
//
//  Created by ashastry on 4/11/15.
//  Copyright (c) 2015 Aneesh Shastry. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WebKit/WebKit.h>
#import "CourseDBManager.h"

@interface StudentSelectView : UIViewController
@property (strong,nonatomic) NSMutableArray * studentList;
@property (strong, nonatomic) NSString * selectedCourse;
@property (strong, nonatomic) CourseDBManager * crsDB;
@end
