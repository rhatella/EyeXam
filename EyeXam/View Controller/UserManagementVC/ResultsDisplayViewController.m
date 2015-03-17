//
//  ResultsDisplayViewController.m
//  EyeXam
//
//  Created by Yi on 2015-03-17.
//  Copyright (c) 2015 University of Toronro. All rights reserved.
//

#import "ResultsDisplayViewController.h"
#import "DatabaseInstance.h"
#import "allRecords.h"

@interface ResultsDisplayViewController ()
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UITableView *nakedEyeResultDisplayTable;
@property (weak, nonatomic) IBOutlet UITableView *withGlassesResultDisplayTable;

@end

@implementation ResultsDisplayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tabBarController setTitle:@"Results Display"];
    self.userName = [[NSUserDefaults standardUserDefaults] objectForKey:@"userName"];
    self.userNameLabel.text = self.userName;
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(tableView.tag ==0){
        //return naked eye result records count
        return [[[DatabaseInstance getSharedInstance]getNakedEyeRecordsForSelectedUser:self.userName] count];

    }else if (tableView.tag ==1){
        //return with glasses eye result records count
        return [[[DatabaseInstance getSharedInstance] getWithGlassesRecordsForSelectedUser:self.userName] count];
    }
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
     UITableViewCell *cell = nil;
     if(tableView.tag ==0){
         //return naked eye result cell
         cell = [tableView dequeueReusableCellWithIdentifier:@"nakedEyeResultsTableCell" forIndexPath:indexPath];
         NSArray *nakedEyeResultsArray = [[DatabaseInstance getSharedInstance] getNakedEyeRecordsForSelectedUser:self.userName];
         allRecords *recordsForCurrentUser = [nakedEyeResultsArray objectAtIndex:indexPath.row];
         cell.textLabel.text = recordsForCurrentUser.lefteyeResult;
         

     }else if (tableView.tag ==1){//
         //return with glasses eye result cell
         cell = [tableView dequeueReusableCellWithIdentifier:@"withGlassesResultsTableCell" forIndexPath:indexPath];


     }
     return cell;
}


@end
