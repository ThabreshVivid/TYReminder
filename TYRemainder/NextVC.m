//
//  NextVC.m
//  TYRemainder
//
//  Created by Thabresh on 8/19/16.
//  Copyright © 2016 VividInfotech. All rights reserved.
//

#import "NextVC.h"

@interface NextVC ()
{
    BOOL isExpand;
}
@end

@implementation NextVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.remainPicker setMinimumDate:[NSDate date]];
    self.remainNotes.text = @"Remainder notes";
    [self.remainNotes setTextColor:[UIColor lightGrayColor]];
    self.remainNotes.layer.borderWidth = 1.0f;
    [self.remainNotes.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [self.remainNotes.layer setMasksToBounds:YES];
    
//    self.remindImage.layer.cornerRadius = self.remindImage.frame.size.width/2;
//    self.remindImage.clipsToBounds = YES;
    self.remindImage.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapFrom:)];
    tapGestureRecognizer.numberOfTapsRequired=1;
    [self.remindImage addGestureRecognizer:tapGestureRecognizer];
}
-(void)handleTapFrom:(UITapGestureRecognizer *)pinchGestureRecognizer
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:picker animated:YES completion:NULL];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)clickedAdd:(id)sender {
    if ([self CheckValidation]) {
        NSMutableDictionary *setDict = [NSMutableDictionary new];
        [setDict setValue:self.remainTitle.text forKey:@"Title"];
        [setDict setValue:self.remainDate.text forKey:@"Date"];
        [setDict setValue:self.remainNotes.text forKey:@"Notes"];
        [setDict setValue:UIImagePNGRepresentation(self.remindImage.image) forKey:@"Image"];
        NSDateFormatter *format = [[NSDateFormatter alloc]init];
        [format setDateFormat:@"dd-MM-yyyy hh:mm:ss a"];
        [[NSUserDefaults standardUserDefaults]setObject:setDict forKey:[NSString stringWithFormat:@"TYRemainder&%@",[format stringFromDate:self.remainPicker.date]]];
        [[NSUserDefaults standardUserDefaults]synchronize];      
        [self.navigationController popViewControllerAnimated:YES];
    }
}
- (IBAction)datePicks:(id)sender {
     NSDateFormatter *format = [[NSDateFormatter alloc]init];
    [format setDateFormat:@"dd-MM-yyyy"];
    self.remainDate.text = [format stringFromDate:self.remainPicker.date];    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    self.remindImage.image = chosenImage;
    [picker dismissViewControllerAnimated:YES completion:NULL];    
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:NULL];
}
-(BOOL)CheckValidation
{
    if (self.remainDate.text.length == 0 || self.remainNotes.text.length == 0 || self.remainTitle.text.length == 0) {
        [[[UIAlertView alloc]initWithTitle:@"Please enter the required fields" message:nil delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil]show];
        return false;
    }return true;
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return isExpand?5:4;
}
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField.tag == 1) {
        [textField resignFirstResponder];
        isExpand = YES;
        [self.tableView reloadData];
    }else if(isExpand){
        isExpand = NO;
        [self.tableView reloadData];
        [textField becomeFirstResponder];
    }
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
-(void)textViewDidBeginEditing:(UITextView *)textView
{
    if(isExpand){
        isExpand = NO;
        [self.tableView reloadData];
        [textView becomeFirstResponder];
    }
    if ([textView.text isEqualToString:@"Remainder notes"]) {
        self.remainNotes.text = nil;
        [self.remainNotes setTextColor:[UIColor blackColor]];
    }
}
-(void)textViewDidEndEditing:(UITextView *)textView
{
    if (textView.text.length == 0) {
        self.remainNotes.text = @"Remainder notes";
        [self.remainNotes setTextColor:[UIColor lightGrayColor]];
    }
}
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if([text isEqualToString:@"\n"])
        [textView resignFirstResponder];
    return YES;
}
@end
