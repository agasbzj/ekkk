//
//  BankSelectViewController.m
//  ekkk
//
//  Created by 卞 中杰 on 11-4-23.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "BankSelectViewController.h"
#import "ekkkAppDelegate.h"
#define kCardsSelectViewTag 100

@implementation BankSelectViewController
@synthesize tableView = _tableView;
@synthesize bankArray = _bankArray;
@synthesize userArray = _userArray;
@synthesize readyToWriteArray = _readyToWriteArray;
@synthesize currentBankDictionary = _currentBankDictionary;
@synthesize delegate;

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
    [_bankArray release];
    [_userArray release];
    [_readyToWriteArray release];
    [_tableView release];
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
    _bankArray = [[[NSDictionary alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"BanksAndCards" ofType:@"plist"]] valueForKey:@"Banks"];
    
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
    cell.textLabel.textAlignment = UITextAlignmentCenter;
    cell.imageView.image = [UIImage imageNamed:[dic valueForKey:@"icon"]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    _currentBankDictionary = [[NSMutableDictionary alloc] init];
    [_currentBankDictionary setValue:[[_bankArray objectAtIndex:indexPath.row] valueForKey:@"bankName"] forKey:@"bank_name"];
    NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"CardsSelectView" owner:self options:nil];
    CardsSelectView *cardsSelectView = [[[CardsSelectView alloc] init] autorelease];
    cardsSelectView = [array objectAtIndex:0];
    cardsSelectView.tag = kCardsSelectViewTag;
    cardsSelectView.delegate = self;
    cardsSelectView.cardsArray = [[_bankArray objectAtIndex:indexPath.row] valueForKey:@"cards"];
    cardsSelectView.selectedCards = [NSMutableArray arrayWithCapacity:3];

    //cardsArray存放已选择的卡，用于标识出来
    NSArray *cardsArray = [[[NSArray alloc] init] autorelease];
    for (NSDictionary *dic in _readyToWriteArray) {
        if ([[dic valueForKey:@"bank_name"] isEqualToString:[_currentBankDictionary valueForKey:@"bank_name"]] == YES) {
            cardsArray = [dic valueForKey:@"cards"];
            break;
        }
    }
    if ([cardsArray count] > 0) {
        cardsSelectView.selectedCards = (NSMutableArray *)cardsArray;
    }
    
    
    [self.view insertSubview:cardsSelectView belowSubview:self.view];
    
    //翻转动画
    CGContextRef context = UIGraphicsGetCurrentContext();
    [UIView beginAnimations:nil context:context];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.view cache:YES];
    [UIView setAnimationDuration:.5f];
    [self.view exchangeSubviewAtIndex:0 withSubviewAtIndex:1];
    [UIView commitAnimations];
    

}

- (IBAction)ok:(id)sender {
    //发送给代理（ekkkappdelegate），让代理来保存数据
    NSMutableArray *array = _readyToWriteArray;
    for (NSDictionary *dic in array) {
        NSArray *cards = [dic valueForKey:@"cards"];
        if ([cards count] == 0) {
            [array removeObject:dic];
        }
    }
    [delegate userCardsSelected:array];
    [self dismissModalViewControllerAnimated:YES];
}

- (IBAction)cancel:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - CardsSelectView Delegate

- (void)cardsSelected:(NSMutableArray *)cardsSelectedArray isCancel:(BOOL)isCancel{
    if (isCancel == NO) {
        int flag = 0;
        //处理接收数据
        [_currentBankDictionary setValue:cardsSelectedArray forKey:@"cards"];
        if ([_readyToWriteArray count] == 0) {
            [_readyToWriteArray addObject:_currentBankDictionary];
        }
        else {
            //如果找到bank name相同的，用新的dic代替原来的对应的dic
            for (int i = 0; i < [_readyToWriteArray count]; i++) {
                NSDictionary *dic = [_readyToWriteArray objectAtIndex:i];
                if ([[dic valueForKey:@"bank_name"] isEqualToString:[_currentBankDictionary valueForKey:@"bank_name"]] == YES) {
                    [_readyToWriteArray removeObject:dic];
                    NSArray *tmp = [_currentBankDictionary objectForKey:@"cards"];
                    if ([tmp count] > 0) {
                        [_readyToWriteArray addObject:_currentBankDictionary];
                    }
                    flag = 1;
                    break;
                }

            }
            if (flag == 0) {
                [_readyToWriteArray addObject:_currentBankDictionary];
            }

        }

    }
    [_currentBankDictionary release];
    
    //返回的翻转动画
    CGContextRef context = UIGraphicsGetCurrentContext();
    [UIView beginAnimations:nil context:context];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self.view cache:YES];
    [UIView setAnimationDuration:.5f];
    [self.view exchangeSubviewAtIndex:0 withSubviewAtIndex:1];
    [[self.view viewWithTag:kCardsSelectViewTag] removeFromSuperview];
    [UIView commitAnimations];
}
@end
