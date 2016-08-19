//
//  NotesCell.h
//  TYRemainder
//
//  Created by Thabresh on 8/19/16.
//  Copyright © 2016 VividInfotech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NotesCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *notes;
@property (weak, nonatomic) IBOutlet UIImageView *avator;
@property (weak, nonatomic) IBOutlet UILabel *date;

@end
