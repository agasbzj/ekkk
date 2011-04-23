//
//  BankSelectViewController.m
//  ekkk
//
//  Created by 卞 中杰 on 11-4-23.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "BankSelectViewController.h"
#import "CardsSelectView.h"

@implementation BankSelectViewController
@synthesize tableView = _tableView;
@synthesize bankArray = _bankArray;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    [_tableView release];
    [_bankArray release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _bankArray = [[[[NSDictionary alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"BanksAndCards" ofType:@"plist"]] valueForKey:@"Banks"] retain];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - TableView Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_bankArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"CellIdentifier";
    UITableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    NSDictionary *dic = [_bankArray objectAtIndex:indexPath.row];
    cell.textLabel.text = [dic valueForKey:@"bankName"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"CardsSelectView" owner:self options:nil];
    CardsSelectView *cardsSelectView = [[CardsSelectView alloc] init];
    cardsSelectView = [array objectAtIndex:0];
    cardsSelectView.cardsArray = [[_bankArray objectAtIndex:indexPath.row] valueForKey:@"cards"];
    cardsSelectView.selectedCards = [NSMutableArray arrayWithCapacity:3];
    [self.view addSubview:cardsSelectView];
}

- (IBAction)ok:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
}

- (IBAction)cancel:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
}
@end
