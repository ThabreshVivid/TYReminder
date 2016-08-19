//
//  NextVC.h
//  TYRemainder
//
//  Created by Thabresh on 8/19/16.
//  Copyright © 2016 VividInfotech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NextVC : UITableViewController<UITextFieldDelegate,UITextViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UITextField *remainTitle;
@property (weak, nonatomic) IBOutlet UITextField *remainDate;
@property (weak, nonatomic) IBOutlet UITextView *remainNotes;
@property (weak, nonatomic) IBOutlet UIDatePicker *remainPicker;
@property (weak, nonatomic) IBOutlet UIImageView *remindImage;

@end
