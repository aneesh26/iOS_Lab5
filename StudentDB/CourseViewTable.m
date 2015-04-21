/**
 * Copyright 2015 Aneesh Shastry,
 * <p/>
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 * <p/>
 * http://www.apache.org/licenses/LICENSE-2.0
 * <p/>
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 * <p/>
 * Purpose: An iOS application for Student Course Database to Add/Remove Course, Add/Remove Student and Enroll/Drop students from courses using SQLite. Select Student Name and Email address from address book
 *
 * @author Aneesh Shastry ashastry@asu.edu
 *         MS Computer Science, CIDSE, IAFSE, Arizona State University
 * @version April 20, 2015
 */



#import "CourseViewTable.h"
#import "ViewController.h"
#import "StudentListTable.h"
#import "CourseDetails.h"
#import "StudentDetails.h"

@interface CourseViewTable()

@property (strong, nonatomic) IBOutlet UITableView *courseTableView;
@property (strong, nonatomic) CourseDBManager * crsDB;
@property (strong, nonatomic) NSString * queryResult;
@property (strong, nonatomic) id  tempSender;



@property (strong, nonatomic) NSMutableArray * courseList;

@end

@implementation CourseViewTable

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.courseTableView.dataSource = self;
    self.navigationItem.title = @"Courses";
    self.crsDB = [[CourseDBManager alloc] initDatabaseName:@"coursedb"];
    
    UIBarButtonItem *btnAdd = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addClicked:)];
    
    self.navigationItem.rightBarButtonItem = btnAdd;
   
  }

- (void)addClicked:(id)sender{
    
    UIAlertView *addAlert = [[UIAlertView alloc] initWithTitle:@"Add Course / Student"
                                                          message:@"What would you like to add?"
                                                         delegate:self
                                                cancelButtonTitle:@"Cancel"
                                                otherButtonTitles:@"Course",@"Student", nil];
    
    
    self.tempSender = sender;
    
    
    [addAlert show];
   
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

-(void) viewWillAppear:(BOOL)animated{
    
    [self.courseTableView reloadData];
    //NSLog(@"Running View will appear");
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    // Return the number of rows in the section.
    NSArray * queryRes = [self.crsDB executeQuery:@"select coursename from course;"];
    return queryRes.count;
    
    
}



- (NSArray *) getDataQuery{
    NSArray * queryRes = [self.crsDB executeQuery:@"select coursename from course;"];
    return queryRes;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    NSArray * queryRes = [self getDataQuery];
    
    NSString * whichCrs = @"unknown";
    if(queryRes.count> indexPath.row){
        whichCrs = queryRes[indexPath.row][0];
    }
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier: @"Cell"];
    }
    cell.accessoryType =  UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = whichCrs;
    return cell;
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    
    NSString *title = [alertView title];
    
    
    if([title isEqual:@"Add Course / Student"]){
        
        NSString *buttonText = [alertView buttonTitleAtIndex:buttonIndex];
        
        if([buttonText isEqualToString:@"Course"])
        {
            [self performSegueWithIdentifier:@"CourseDetails" sender:self.tempSender];
        }
        else if([buttonText isEqualToString:@"Student"])
        {
            
           [self performSegueWithIdentifier:@"AddStudent" sender:self.tempSender];
            
        }
        else if([buttonText isEqualToString:@"Cancel"])
        {
            
            // Do Nothing
            
        }
        
    }
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if([segue.identifier isEqualToString:@"CourseToStudent"]){
        NSIndexPath * indexPath = [self.courseTableView indexPathForSelectedRow];
        
        
        NSArray * queryRes = [self.crsDB executeQuery:@"select coursename from course;"];
        NSString * whichCrs = @"unknown";
        if(queryRes.count> indexPath.row){
            whichCrs = queryRes[indexPath.row][0];
        }
        StudentListTable *destViewController = segue.destinationViewController;
       // NSLog(@"prepareForSeque setting course to %@",whichCrs);
        destViewController.parent = self;
        destViewController.selectedCourse = whichCrs;
        destViewController.crsDB = self.crsDB;
        
        
        
        
    }
    if([segue.identifier isEqualToString:@"CourseDetails"]){
        CourseDetails * destViewController = segue.destinationViewController;
        destViewController.crsDB = self.crsDB;
    }
    
    if([segue.identifier isEqualToString:@"AddStudent"]){
 
        
        StudentDetails * destViewController = segue.destinationViewController;
        destViewController.crsDB = self.crsDB;
        destViewController.isNewStudent = YES;

    }

}


@end
