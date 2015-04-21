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



#import "CourseDetails.h"

@interface CourseDetails()
@property (weak, nonatomic) IBOutlet UITextField *cNameTF;
@property (weak, nonatomic) IBOutlet UITextField *cIDTF;



@end

@implementation CourseDetails
- (void)viewDidLoad {
    [super viewDidLoad];

    self.cIDTF.keyboardType = UIKeyboardTypeNumberPad;
        UIBarButtonItem *btnSave = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(saveClicked:)];

        self.navigationItem.rightBarButtonItem = btnSave;
}

- (void)saveClicked:(id)sender{
    NSNumber *testForNum;
    NSNumberFormatter *formatter = [NSNumberFormatter new];
    testForNum = [formatter numberFromString:self.cIDTF.text];
    if([self.cNameTF.text isEqual:@""] || [self.cIDTF.text isEqual:@""]){
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Warning!" message:[NSString stringWithFormat:@"Incomplete / Incorrect Input"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        alert.alertViewStyle = UIAlertViewStyleDefault;
        [alert show];
        
    }
    else if(!testForNum) {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Warning!" message:[NSString stringWithFormat:@"Course ID accepts only numeric values"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        alert.alertViewStyle = UIAlertViewStyleDefault;
        [alert show];
    }
    
    else{
        
        
        //get the course ID
        
        NSString* queryString = [[@"select courseid from course where courseid = "
                        stringByAppendingString: self.cIDTF.text]
                       stringByAppendingString:@";"];
      //  NSLog(queryString);
        NSArray * queryRes = [self.crsDB executeQuery:queryString];
        
        if([queryRes count] > 0){
            UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Warning!" message:[NSString stringWithFormat:@"Course ID exists, please enter a different ID"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            alert.alertViewStyle = UIAlertViewStyleDefault;
            [alert show];
            
        }else{
        
        
        
        
    
            NSString * queryString = [[[[@"insert into course values ('"
                              stringByAppendingString: self.cNameTF.text]
                              stringByAppendingString:@"',"]
                              stringByAppendingString:self.cIDTF.text]
                              stringByAppendingString:@");"];
       //     NSLog(queryString);
  
            NSArray * addRes = [self.crsDB executeQuery:queryString];
    
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
    
    //[self.courseTableView reloadData];
    
    
 //   [self performSegueWithIdentifier:@"CourseDetails" sender:sender];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{

    NSString *title = [alertView title];
    
    
    if([title isEqual:@"Warning"]){
        
        NSString *buttonText = [alertView buttonTitleAtIndex:buttonIndex];
        
        if([buttonText isEqualToString:@"NO"])
        {
            
        }
        else if([buttonText isEqualToString:@"YES"])
        {
            
            
        }
    }

}



@end
