//
//  ViewController.h
//  TYRemainder
//
//  Created by Thabresh on 8/19/16.
//  Copyright © 2016 VividInfotech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *remindTbl;
@property (strong, nonatomic) IBOutlet UIView *popUp;
@property (weak, nonatomic) IBOutlet UITableView *popUpTbl;


@end

