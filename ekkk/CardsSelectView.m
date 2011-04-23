//
//  CardsSelectView.m
//  ekkk
//
//  Created by 卞 中杰 on 11-4-23.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "CardsSelectView.h"


@implementation CardsSelectView
@synthesize tableView = _tableView;
@synthesize cardsArray = _cardsArray;
@synthesize selectedCards = _selectedCards;

- (id)init {
    if ((self = [super init])) {
        
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)dealloc
{
    [_selectedCards release];
    [_tableView release];
    [_cardsArray release];
    [super dealloc];
}


#pragma mark - TableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_cardsArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"CellIdentifier";
    UITableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.textLabel.text = [_cardsArray objectAtIndex:indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [_tableView cellForRowAtIndexPath:indexPath];
    NSString *selected = [_cardsArray objectAtIndex:indexPath.row];
    for (NSString *str in _selectedCards) {
        if ([str isEqualToString:cell.textLabel.text]) {

            cell.accessoryType = UITableViewCellAccessoryNone;
            [self.selectedCards removeObject:selected];
            NSLog(@"%@", _selectedCards);
            return;
        }

    }
    [_selectedCards addObject:selected];
    NSLog(@"%@", _selectedCards);
    cell.accessoryType = UITableViewCellAccessoryCheckmark;
}

- (IBAction)ok:(id)sender {
    NSLog(@"%@", _selectedCards);
    [self removeFromSuperview];
}
- (IBAction)cancel:(id)sender {
    [self removeFromSuperview];
}
@end
