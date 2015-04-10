//
//  StudentDetails.h
//  StudentDB
//
//  Created by ashastry on 4/8/15.
//  Copyright (c) 2015 Aneesh Shastry. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WebKit/WebKit.h>
#import "CourseDBManager.h"

@interface StudentDetails : UIViewController
@property (nonatomic,assign) BOOL * isNewStudent;
@property (strong, nonatomic) CourseDBManager * crsDB;
@property (strong, nonatomic) NSString * studentName;
@property (strong, nonatomic) NSString * selectedCourse;
@end
