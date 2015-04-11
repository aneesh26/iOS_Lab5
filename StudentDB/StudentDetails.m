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
 * Purpose: An iOS application for Student Course Database to Add/Remove Course, Add/Remove Student and Enroll/Drop students from courses using SQLite
 *
 * @author Aneesh Shastry ashastry@asu.edu
 *         MS Computer Science, CIDSE, IAFSE, Arizona State University
 * @version April 11, 2015
 */



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
  //      NSLog(queryString);
        NSArray * queryRes = [self.crsDB executeQuery:queryString];
        
        NSArray * res = queryRes[0];
        
        [self.sNameTF setText:res[0]];
        [self.sMajorTF setText:res[1]];
        [self.sEmailTF setText:res[2]];
        [self.sIdTF setText:res[3]];
        
        
    }
    
    
    
    
    
    
    
}

- (void) addClicked:(id)sender{
    
    
    if([self.sNameTF.text isEqual:@""] || [self.sMajorTF.text isEqual:@""] || [self.sEmailTF.text isEqual:@""] || [self.sIdTF.text isEqual:@""]){
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Warning!" message:[NSString stringWithFormat:@"Incomplete / Incorrect Input"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        alert.alertViewStyle = UIAlertViewStyleDefault;
        [alert show];
        
    }else{
    
    
    //check if the student id exists
    
        NSString * queryString = [[@"select studentid from student where studentid = "
                                   stringByAppendingString:self.sIdTF.text]
                                  stringByAppendingString:@";"];
        NSArray * checkRes = [self.crsDB executeQuery:queryString];
        if([checkRes count] > 0){
            UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Warning!" message:[NSString stringWithFormat:@"Student ID exists, please enter a different ID"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            alert.alertViewStyle = UIAlertViewStyleDefault;
            [alert show];
            
        }else{
            
        
    
            queryString = [[[[[[[[@"insert into student values ('"
                                 stringByAppendingString: self.sNameTF.text]
                                stringByAppendingString:@"','"]
                               stringByAppendingString:self.sMajorTF.text ]
                               stringByAppendingString:@"','" ]
                                stringByAppendingString:self.sEmailTF.text ]
                                stringByAppendingString:@"'," ]
                               stringByAppendingString:self.sIdTF.text]
                              stringByAppendingString:@");"];
          //  NSLog(queryString);
    
            NSArray * addRes = [self.crsDB executeQuery:queryString];
    
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
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
            //get the student ID
            NSString* queryString = [[@"select * from student where name = '"
                                      stringByAppendingString: self.studentName]
                                     stringByAppendingString:@"';"];
         //   NSLog(queryString);
            NSMutableArray * queryRes = [self.crsDB executeQuery:queryString];
            
            
            NSArray * studentIDObject = queryRes[0];
            NSString * studentID = studentIDObject[3];
            
            
            //delete course
            queryString = [[@"delete from student where name = '"
                            stringByAppendingString: self.studentName]
                           stringByAppendingString:@"';"];
        //    NSLog(queryString);
            queryRes = [self.crsDB executeQuery:queryString];
            
            
            //remove course for student
            queryString = [[@"delete from studenttakes where studentid = "
                            stringByAppendingString: studentID]
                           stringByAppendingString:@";"];
        //    NSLog(queryString);
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
         //   NSLog(queryString);
            NSMutableArray * queryRes = [self.crsDB executeQuery:queryString];
            
            NSArray * studentIDObject = queryRes[0];
            NSString * studentID = studentIDObject[3];
            
               //get the course ID
            
           queryString = [[@"select * from course where coursename = '"
                                      stringByAppendingString: self.selectedCourse]
                                     stringByAppendingString:@"';"];
         //   NSLog(queryString);
            queryRes = [self.crsDB executeQuery:queryString];
            
            
            NSArray * courseIDObject = queryRes[0];
            NSString * courseID = courseIDObject[1];

            
            
            //drop course for student
            queryString = [[[[@"delete from studenttakes where studentid = "
                            stringByAppendingString: studentID]
                           stringByAppendingString:@" and courseid = "]
                        stringByAppendingString: courseID]
                        stringByAppendingString:@";"];
        //    NSLog(queryString);
            queryRes = [self.crsDB executeQuery:queryString];
            
            
            
            [self.navigationController popViewControllerAnimated:YES];
            
            
        }
        
    }
    
    
}

@end
