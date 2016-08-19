//
//  ViewController.m
//  TYRemainder
//
//  Created by Thabresh on 8/19/16.
//  Copyright © 2016 VividInfotech. All rights reserved.
//

#import "ViewController.h"
#import "NotesCell.h"
#import "BirthCell.h"
#import "UIButton+Badge.h"
#import "UIBarButtonItem+Badge.h"
@interface ViewController ()
{
    NSMutableArray *result;
    NSMutableArray *getBirth;
    NSMutableArray *birthResult;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.popUp setFrame:self.view.frame];
    [self.view addSubview:self.popUp];
    [self.popUp setHidden:YES];
   
    self.remindTbl.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    // Do any additional setup after loading the view, typically from a nib.
}
-(void)showMenu{
    [self.popUp setHidden:NO];
    CATransition *transition = [CATransition animation];
    transition.duration = 1.0;
    transition.type = kCATransitionFade;
    [transition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    transition.subtype = kCATransitionFromBottom;
    [self.popUp.layer addAnimation:transition forKey:nil];
    [self.navigationItem.rightBarButtonItem setEnabled:NO];
    [self.navigationItem.leftBarButtonItem setEnabled:NO];
}
-(void)viewWillAppear:(BOOL)animated
{
    result = [NSMutableArray new];
    NSArray *getAllKeys = [[[NSUserDefaults standardUserDefaults] dictionaryRepresentation] allKeys];
    for (int i=0; i<getAllKeys.count; i++) {
        if (!([[getAllKeys objectAtIndex:i] rangeOfString:@"TYRemainder"].location == NSNotFound)) {
            [result addObject:[[NSUserDefaults standardUserDefaults]objectForKey:[getAllKeys objectAtIndex:i]]];
        }
    }
    [self Birth];
    self.remindTbl.estimatedRowHeight = 68.0f;
    self.remindTbl.rowHeight = UITableViewAutomaticDimension;
    [self.remindTbl registerNib:[UINib nibWithNibName:@"NotesCell" bundle:nil] forCellReuseIdentifier:@"NotesCell"];    
    self.popUpTbl.estimatedRowHeight = 72.0f;
    self.popUpTbl.rowHeight = UITableViewAutomaticDimension;
    [self.popUpTbl registerNib:[UINib nibWithNibName:@"BirthCell" bundle:nil] forCellReuseIdentifier:@"BirthCell"];
    [self.remindTbl reloadData];
    [self.popUpTbl reloadData];
}
-(void)Birth{
    NSInteger sums = 0;
    getBirth = [NSMutableArray new];
    birthResult = [NSMutableArray new];
    for (int i=0; i<result.count; i++) {
        NSDateFormatter *format = [[NSDateFormatter alloc]init];
        [format setDateFormat:@"dd-MM-yyyy"];
        if ([[format stringFromDate:[NSDate date]] isEqualToString:[result valueForKey:@"Date"][i]]) {
            [getBirth addObject:[NSString stringWithFormat:@"%ld",(long)sums]];
            [birthResult addObject:[result objectAtIndex:i]];
            sums++;
        }
    }
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"Gift"] style:UIBarButtonItemStylePlain target:self action:@selector(showMenu)];
    self.navigationItem.leftBarButtonItem.badgeValue = [NSString stringWithFormat:@"%ld",getBirth.count];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag==1) {
        return 72.0f;
    }
    return UITableViewAutomaticDimension;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView.tag == 1) {
        return birthResult.count;
    }
    return [[result valueForKey:@"Date"]count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag == 1) {
        BirthCell * cell = [tableView dequeueReusableCellWithIdentifier:@"BirthCell"];
        cell.name.text = [birthResult valueForKey:@"Title"][indexPath.row];
        cell.avator.image = [UIImage imageWithData:[birthResult valueForKey:@"Image"][indexPath.row]];
        cell.avator.layer.cornerRadius = cell.avator.frame.size.width/2;
        cell.avator.clipsToBounds = YES;
        cell.avator.userInteractionEnabled = YES;
        return cell;
    }else{
        NotesCell * cell = [tableView dequeueReusableCellWithIdentifier:@"NotesCell"];
        cell.title.text = [result valueForKey:@"Title"][indexPath.row];
        cell.notes.text = [result valueForKey:@"Notes"][indexPath.row];
        cell.date.text = [result valueForKey:@"Date"][indexPath.row];
        cell.avator.image = [UIImage imageWithData:[result valueForKey:@"Image"][indexPath.row]];
        cell.avator.layer.cornerRadius = cell.avator.frame.size.width/2;
        cell.avator.clipsToBounds = YES;
        cell.avator.userInteractionEnabled = YES;
        return cell;
    }   
}
- (IBAction)popupClose:(id)sender {
    CATransition *transition = [CATransition animation];
    transition.duration = 1.0;
    transition.type = kCATransitionMoveIn;
    [transition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    transition.subtype = kCATransitionFromTop;
    [self.popUp.layer addAnimation:transition forKey:nil];
    [self.popUp setHidden:YES];
    [self.navigationItem.rightBarButtonItem setEnabled:YES];
    [self.navigationItem.leftBarButtonItem setEnabled:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
