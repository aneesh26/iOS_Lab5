//
//  StudentDetails.m
//  StudentDB
//
//  Created by ashastry on 4/8/15.
//  Copyright (c) 2015 Aneesh Shastry. All rights reserved.
//

#import "StudentDetails.h"

@interface StudentDetails()
@property (weak, nonatomic) IBOutlet UITextField *sNameTF;
@property (weak, nonatomic) IBOutlet UITextField *sIdTF;
@property (weak, nonatomic) IBOutlet UITextField *sMajorTF;
@property (weak, nonatomic) IBOutlet UITextField *sEmailTF;
@property (weak, nonatomic) IBOutlet UITextField *sAddCourseTF;
@property (weak, nonatomic) IBOutlet UITextField *sDropCourseTF;

@end

@implementation StudentDetails

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Student Details";
    
    
    
    
    if(self.isNewStudent == YES){
        self.title = @"Add Student";
        UIBarButtonItem *btnAdd = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(addClicked:)];
        self.navigationItem.rightBarButtonItem = btnAdd;
        self.isNewStudent = NO;
    }
    else{
        self.title = @"Student Details";
        
        UIBarButtonItem *btnDel = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemTrash target:self action:@selector(delClicked:)];
        UIBarButtonItem *btnDrop = [[UIBarButtonItem alloc] initWithTitle:@"Drop" style:UIBarButtonItemStylePlain target:self action:@selector(dropClicked:)];
       
        
        self.navigationItem.rightBarButtonItems =@[btnDel,btnDrop];
        
        
        [self.sNameTF setText:[NSString stringWithString:self.studentName]];
        
        NSString * queryString = [[@"select * from student where name='"
                                   stringByAppendingString:self.sNameTF.text]
                                  stringByAppendingString:@"';"] ;
        NSLog(queryString);
        NSArray * queryRes = [self.crsDB executeQuery:queryString];
        
        NSArray * res = queryRes[0];
        
        [self.sNameTF setText:res[0]];
        [self.sMajorTF setText:res[1]];
        [self.sEmailTF setText:res[2]];
        [self.sIdTF setText:res[3]];
        
        
    }
    
    
    
    
    
    
    
}

- (void) addClicked:(id)sender{
    NSString * queryString = [[[[[[[[@"insert into student values ('"
                                 stringByAppendingString: self.sNameTF.text]
                                stringByAppendingString:@"','"]
                               stringByAppendingString:self.sMajorTF.text ]
                               stringByAppendingString:@"','" ]
                                stringByAppendingString:self.sEmailTF.text ]
                                stringByAppendingString:@"'," ]
                               stringByAppendingString:self.sIdTF.text]
                              stringByAppendingString:@");"];
    NSLog(queryString);
    
    NSArray * addRes = [self.crsDB executeQuery:queryString];
     //studentID,courseID
    
    queryString = [[[[@"insert into studenttakes values ("
                                 stringByAppendingString: self.sAddCourseTF.text]
                                stringByAppendingString:@","]
                               stringByAppendingString:self.sDropCourseTF.text]
                              stringByAppendingString:@");"];
      NSLog(queryString);
    
    addRes = [self.crsDB executeQuery:queryString];
    
    
    [self.navigationController popViewControllerAnimated:YES];
}



-(void)delClicked:(id)sender{
    
    // delete from course where coursename='CSE 598 DAA';
    
    //get courseid
    
    
    UIAlertView *deleteAlert = [[UIAlertView alloc] initWithTitle:@"Warning"
                                                          message:[[@"Remove Student '" stringByAppendingString: self.studentName] stringByAppendingString:@"' ?"]
                                                         delegate:self
                                                cancelButtonTitle:@"NO"
                                                otherButtonTitles:@"YES", nil];
    [deleteAlert show];
    
    
}

-(void)dropClicked:(id)sender{
    
    
    
    //get courseid
    
    
    UIAlertView *dropAlert = [[UIAlertView alloc] initWithTitle:@"Drop"
                                                          message:[[[[@"Drop Student '" stringByAppendingString: self.studentName] stringByAppendingString:@"' from course '"]
                                                                stringByAppendingString: self.selectedCourse]
                                                                 stringByAppendingString:@"' ?"]
                                                         delegate:self
                                                cancelButtonTitle:@"NO"
                                                otherButtonTitles:@"YES", nil];
    [dropAlert show];
    
    
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
            NSString* queryString = [[@"select * from student where name = '"
                                      stringByAppendingString: self.studentName]
                                     stringByAppendingString:@"';"];
            NSLog(queryString);
            NSMutableArray * queryRes = [self.crsDB executeQuery:queryString];
            
            
            NSArray * studentIDObject = queryRes[0];
            NSString * studentID = studentIDObject[1];
            
            
            //delete course
            queryString = [[@"delete from student where name = '"
                            stringByAppendingString: self.studentName]
                           stringByAppendingString:@"';"];
            NSLog(queryString);
            queryRes = [self.crsDB executeQuery:queryString];
            
            
            //remove course for student
            queryString = [[@"delete from studenttakes where studentid = "
                            stringByAppendingString: studentID]
                           stringByAppendingString:@";"];
            NSLog(queryString);
            queryRes = [self.crsDB executeQuery:queryString];
            
            
            
            [self.navigationController popViewControllerAnimated:YES];
            
            
        }
        
    }
    if([title isEqual:@"Drop"]){
        
        NSString *buttonText = [alertView buttonTitleAtIndex:buttonIndex];
        
        if([buttonText isEqualToString:@"NO"])
        {
            
        }
        else if([buttonText isEqualToString:@"YES"])
        {
            //get the student ID
            NSString* queryString = [[@"select * from student where name = '"
                                      stringByAppendingString: self.studentName]
                                     stringByAppendingString:@"';"];
            NSLog(queryString);
            NSMutableArray * queryRes = [self.crsDB executeQuery:queryString];
            
            NSArray * studentIDObject = queryRes[0];
            NSString * studentID = studentIDObject[3];
            
               //get the course ID
            
           queryString = [[@"select * from course where coursename = '"
                                      stringByAppendingString: self.selectedCourse]
                                     stringByAppendingString:@"';"];
            NSLog(queryString);
            queryRes = [self.crsDB executeQuery:queryString];
            
            
            NSArray * courseIDObject = queryRes[0];
            NSString * courseID = courseIDObject[1];

            
            
            //drop course for student
            queryString = [[[[@"delete from studenttakes where studentid = "
                            stringByAppendingString: studentID]
                           stringByAppendingString:@" and courseid = "]
                        stringByAppendingString: courseID]
                        stringByAppendingString:@";"];
            NSLog(queryString);
            queryRes = [self.crsDB executeQuery:queryString];
            
            
            
            [self.navigationController popViewControllerAnimated:YES];
            
            
        }
        
    }
    
    //else if([title isEqual:@"Waypoint Removed"]){
    //  [self.navigationController popViewControllerAnimated:YES];
    // }
    
    
    
    
    
    
}

@end
