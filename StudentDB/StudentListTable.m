//
//  StudentListTable.m
//  StudentDB
//
//  Created by ashastry on 4/8/15.
//  Copyright (c) 2015 Aneesh Shastry. All rights reserved.
//

#import "StudentListTable.h"
#import "ViewController.h"
#import "StudentDetails.h"

@interface StudentListTable()
@property (strong, nonatomic) IBOutlet UITableView *studentTable;
@property (strong, nonatomic) NSMutableArray * studentList;

@property (strong, nonatomic) NSString * query;


@end

@implementation StudentListTable

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    /*
    self.title = @"Student List";
    self.studentTable.dataSource = self;
    
    self.studentList = [[NSMutableArray alloc] init];
    
    
    
    [self.studentList addObject:@"Student 1"];
    [self.studentList addObject:@"Student 2"];
    [self.studentList addObject:@"Student 3"];
    NSLog(@"No of rows %lu",[self.studentList count] );
    [self.studentTable reloadData];
     */
    
    self.studentTable.dataSource = self;
    self.query = [NSString stringWithFormat:@"select name from student,studenttakes,course where course.coursename = '%@' and course.courseid = studenttakes.courseid and student.studentid = studenttakes.studentid;",self.selectedCourse];
  //  self.crsDB = [[CourseDBManager alloc] initDatabaseName:@"coursedb"];
    self.navigationItem.title = self.selectedCourse; // stringByAppendingString:@" Students"];
    
    UIBarButtonItem *btnDel = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemTrash target:self action:@selector(delClicked:)];
    
    self.navigationItem.rightBarButtonItem = btnDel;
    
    
    
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
            NSLog(queryString);
            NSMutableArray * queryRes = [self.crsDB executeQuery:queryString];
            
            
            NSArray * courseIDObject = queryRes[0];
            NSString * courseID = courseIDObject[1];
          
            
            //delete course
            queryString = [[@"delete from course where coursename = '"
                            stringByAppendingString: self.selectedCourse]
                           stringByAppendingString:@"';"];
            NSLog(queryString);
            queryRes = [self.crsDB executeQuery:queryString];
            
            
            //remove course for student
            queryString = [[@"delete from studenttakes where courseid = "
                            stringByAppendingString: courseID]
                           stringByAppendingString:@";"];
            NSLog(queryString);
            queryRes = [self.crsDB executeQuery:queryString];
            
            
            
            [self.navigationController popViewControllerAnimated:YES];
            
            
        }
        
    }//else if([title isEqual:@"Waypoint Removed"]){
      //  [self.navigationController popViewControllerAnimated:YES];
   // }
    
    
    
    
    
    
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
    
    // Return the number of rows in the section.
    
   // return [self.studentList count];
    //  NSLog([NSString stringWithFormat:@"No of rows %f",[self.courseList count] ]);
    //   return [[self.wpLib allKeys] count];
    
    NSArray * queryRes = [self.crsDB executeQuery:self.query];
    return queryRes.count;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
   /*
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    
    NSArray *keys = self.studentList;
    //  NSLog(@"Keys: %@",keys);
    
    NSString * ret = @"unknown";
    
    if(indexPath.row < keys.count){
        ret = keys[indexPath.row];
    }
    
    cell.textLabel.text = ret;
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    
    // Configure the cell...
    
    return cell;
    */
    
    
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
        // NSArray * keys = [self.wpLib allKeys];
         NSMutableArray  *queryRes = [self.crsDB executeQuery:self.query];
        NSMutableArray * keys = queryRes;
        NSMutableArray *ret  =@"Unknown";
        if(indexPath.row < keys.count){
            ret = keys[[indexPath row]];
       //     ret = [[keys objectAtIndex:indexPath.row] description];
           // ret = keys[indexPath.row];
        }
        
        NSString *returnValue = ret[0];
       
        StudentDetails * destViewController = segue.destinationViewController;
        destViewController.crsDB = self.crsDB;
        destViewController.studentName = returnValue;
        destViewController.selectedCourse = self.selectedCourse;
        //   destViewController.waypointName = ret;
        //    destViewController.wpLib = self.wpLib;
        //   destViewController.wpList = self.waypointList;
    }
   
    
    
    
    
    
    
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

@end
