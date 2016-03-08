//
//  ViewController.m
//  MacysSampleTest
//
//  Created by Jalakam, Pradeep on 3/8/16.
//  Copyright © 2016 Jalakam, Pradeep. All rights reserved.
//

#import "DisplayMeaningsViewController.h"
#import "FetchMeaningUsingAF.h"
#import "MBProgressHUD.h"

@interface DisplayMeaningsViewController ()<UITextFieldDelegate, UITableViewDataSource, FetchedMeaningDelegate>
@property (weak, nonatomic) IBOutlet UITextField *enterAcronymsTextFeild;
@property (weak, nonatomic) IBOutlet UITableView *meaningsTableView;
@property (strong, nonatomic) FetchMeaningUsingAF *fetchMeaning;
@property (strong, nonatomic) NSArray *meaningArray;

@end

@implementation DisplayMeaningsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.fetchMeaning = [[FetchMeaningUsingAF alloc]init];
    self.fetchMeaning.delegate = self;
    self.enterAcronymsTextFeild.returnKeyType = UIReturnKeySearch;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void) searchForMeaning
{
    if (self.enterAcronymsTextFeild.text.length > 0)
    {
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [self.fetchMeaning fetchMeaningsUsingAFNetworking:self.enterAcronymsTextFeild.text];
    }
    else
    {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Enter Acronyms"
                                                                       message:@"Enter Atleast one Character"
                                                                preferredStyle:UIAlertControllerStyleActionSheet];
        UIAlertAction *firstAction = [UIAlertAction actionWithTitle:@"ok"
                                                              style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
                                                                  [alert dismissViewControllerAnimated:YES completion:nil];
                                                              }];
        
        
        [alert addAction:firstAction];
        [self presentViewController:alert animated:YES completion:nil];
    }
    
}

- (void) fetchCompleted:(NSArray *)meaningArray
{
    self.meaningArray = meaningArray;
    [self.meaningsTableView reloadData];
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}

#pragma - TableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.meaningArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"MeaningCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    cell.textLabel.text = [self.meaningArray objectAtIndex:indexPath.row];
    return cell;
}

#pragma - UITextFeild

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self searchForMeaning];
    [textField resignFirstResponder];
    return NO;
}

@end
