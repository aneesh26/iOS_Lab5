//
//  CourseDetails.m
//  StudentDB
//
//  Created by ashastry on 4/9/15.
//  Copyright (c) 2015 Aneesh Shastry. All rights reserved.
//

#import "CourseDetails.h"

@interface CourseDetails()
@property (weak, nonatomic) IBOutlet UITextField *cNameTF;
@property (weak, nonatomic) IBOutlet UITextField *cIDTF;



@end

@implementation CourseDetails
- (void)viewDidLoad {
    [super viewDidLoad];

        UIBarButtonItem *btnSave = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(saveClicked:)];

        self.navigationItem.rightBarButtonItem = btnSave;
}

- (void)saveClicked:(id)sender{
    
    NSString * queryString = [[[[@"insert into course values ('"
                              stringByAppendingString: self.cNameTF.text]
                              stringByAppendingString:@"',"]
                              stringByAppendingString:self.cIDTF.text]
                              stringByAppendingString:@");"];
    NSLog(queryString);
  
     NSArray * addRes = [self.crsDB executeQuery:queryString];
    
     [self.navigationController popViewControllerAnimated:YES];
   
    
    //[self.courseTableView reloadData];
    
    
 //   [self performSegueWithIdentifier:@"CourseDetails" sender:sender];
}



@end
