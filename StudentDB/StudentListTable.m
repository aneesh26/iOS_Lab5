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



#import "StudentListTable.h"
#import "ViewController.h"
#import "StudentDetails.h"
#import "StudentSelectView.h"

@interface StudentListTable()
@property (strong, nonatomic) IBOutlet UITableView *studentTable;
@property (strong, nonatomic) NSMutableArray * studentList;

@property (strong, nonatomic) NSString * query;

@property (strong, nonatomic) NSArray * studentListQuery;
@property (strong, nonatomic) id  tempSender;


@end

@implementation StudentListTable

- (void)viewDidLoad {
    [super viewDidLoad];
    
     self.studentTable.dataSource = self;
    self.query = [NSString stringWithFormat:@"select name from student,studenttakes,course where course.coursename = '%@' and course.courseid = studenttakes.courseid and student.studentid = studenttakes.studentid;",self.selectedCourse];
  //  self.crsDB = [[CourseDBManager alloc] initDatabaseName:@"coursedb"];
    self.navigationItem.title = self.selectedCourse; // stringByAppendingString:@" Students"];
    
    UIBarButtonItem *btnDel = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemTrash target:self action:@selector(delClicked:)];
    
    UIBarButtonItem *btnAdd = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addClicked:)];
    
    self.navigationItem.rightBarButtonItems = @[btnDel,btnAdd];
    
    
    
}

-(void)delClicked:(id)sender{
    
   // delete from course where coursename='CSE 598 DAA';
    
    //get courseid
    
    
    UIAlertView *deleteAlert = [[UIAlertView alloc] initWithTitle:@"Warning"
                                                          message:[[@"Remove Course '" stringByAppendingString: self.selectedCourse] stringByAppendingString:@"' ?"]
                                                         delegate:self
                                                cancelButtonTitle:@"NO"
                                                otherButtonTitles:@"YES", nil];
    [deleteAlert show];
   
    
}

-(void)addClicked:(id)sender{
    
    // delete from course where coursename='CSE 598 DAA';
    
    //get courseid
    self.tempSender = sender;
    
    UIAlertView *addAlert = [[UIAlertView alloc] initWithTitle:@"Add"
                                                          message:@"Enroll a student to this course ?"
                                                         delegate:self
                                                cancelButtonTitle:@"NO"
                                                otherButtonTitles:@"YES", nil];
    [addAlert show];
    
    
}





- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    //  NSLog(@"Add button Clicked");
    
    
    NSString *title = [alertView title];
    
    
    if([title isEqual:@"Warning"]){
        
        NSString *buttonText = [alertView buttonTitleAtIndex:buttonIndex];
        
        if([buttonText isEqualToString:@"NO"])
        {
            
        }
        else if([buttonText isEqualToString:@"YES"])
        {
            //get the Course ID
            NSString* queryString = [[@"select * from course where coursename = '"
                                      stringByAppendingString: self.selectedCourse]
                                     stringByAppendingString:@"';"];
           // NSLog(queryString);
            NSMutableArray * queryRes = [self.crsDB executeQuery:queryString];
            
            
            NSArray * courseIDObject = queryRes[0];
            NSString * courseID = courseIDObject[1];
          
            
            //delete course
            queryString = [[@"delete from course where coursename = '"
                            stringByAppendingString: self.selectedCourse]
                           stringByAppendingString:@"';"];
          //  NSLog(queryString);
            queryRes = [self.crsDB executeQuery:queryString];
            
            
            //remove course for student
            queryString = [[@"delete from studenttakes where courseid = "
                            stringByAppendingString: courseID]
                           stringByAppendingString:@";"];
           // NSLog(queryString);
            queryRes = [self.crsDB executeQuery:queryString];
            
            
            
            [self.navigationController popViewControllerAnimated:YES];
            
            
        }
        
    }else if([title isEqual:@"Add"]){
        
        NSString *buttonText = [alertView buttonTitleAtIndex:buttonIndex];
        
        if([buttonText isEqualToString:@"NO"])
        {
            
        }
        else if([buttonText isEqualToString:@"YES"])
        {
            
            [self performSegueWithIdentifier:@"SelectStudent" sender:self.tempSender];
            // add code to select student from picker and link it to the course
            
            
         //   [self.navigationController popViewControllerAnimated:YES];
            
            
        }
        
    }
    
    
    
    
    
    
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
    [self.studentTable reloadData];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
   
    NSArray * queryRes = [self.crsDB executeQuery:self.query];
    return queryRes.count;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
  
    
    NSArray * queryRes = [self.crsDB executeQuery:self.query];
    
    NSString * whichStud = @"unknown";
    if(queryRes.count> indexPath.row){
        whichStud = queryRes[indexPath.row][0];
    }
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier: @"Cell"];
    }
    cell.accessoryType =  UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = whichStud;
    
    return cell;
    
    
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if([segue.identifier isEqualToString:@"StudentDetails"]){
        NSIndexPath * indexPath = [self.studentTable indexPathForSelectedRow];
         NSMutableArray  *queryRes = [self.crsDB executeQuery:self.query];
        NSMutableArray * keys = queryRes;
        NSMutableArray *ret  =@"Unknown";
        if(indexPath.row < keys.count){
            ret = keys[[indexPath row]];
         }
        
        NSString *returnValue = ret[0];
       
        StudentDetails * destViewController = segue.destinationViewController;
        destViewController.crsDB = self.crsDB;
        destViewController.studentName = returnValue;
        destViewController.selectedCourse = self.selectedCourse;
     }else if([segue.identifier isEqualToString:@"SelectStudent"]){
        StudentSelectView * destViewController = segue.destinationViewController;
        destViewController.selectedCourse = self.selectedCourse;
        destViewController.crsDB = self.crsDB;
        
        
    }
   
}

@end
