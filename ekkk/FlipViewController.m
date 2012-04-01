//
//  FlipViewController.m
//  ekkk
//
//  Created by 卞 中杰 on 12-4-1.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "FlipViewController.h"
#import "FlipView.h"

#define ARRAY_CAPCITY   3
#define ADV_IMG_NAME    @"adv"

@interface FlipViewController ()
- (void)loadScrollViewWithPage:(int)page;
@end

@implementation FlipViewController


#pragma mark Lifecycle
- (id)initWithSuperView:(UIView *)view
{
    self = [super init];
    if (self) 
    {
        _superView = view;
        
        _flipArray = [[NSMutableArray alloc] initWithCapacity:ARRAY_CAPCITY];
        for (int i = 0; i < ARRAY_CAPCITY; i++) 
        {
            [_flipArray addObject:[NSNull null]];
        }
        
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 44, 320, 90)];
        _scrollView.contentSize = CGSizeMake(_scrollView.frame.size.width * ARRAY_CAPCITY, _scrollView.frame.size.height);
        _scrollView.pagingEnabled = YES;
        _scrollView.scrollsToTop = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.delegate = self;
        _superView.backgroundColor = [UIColor blackColor];
        [_superView addSubview:_scrollView];
        
        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 124, 320, 10)];
        [_pageControl addTarget:self action:@selector(changePage) forControlEvents:UIControlEventValueChanged];
        _pageControl.numberOfPages = ARRAY_CAPCITY;
        _pageControl.currentPage = 0;
        _pageControl.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
        [_superView addSubview:_pageControl];
        [_pageControl release];
        
        [self loadScrollViewWithPage:0];
        [self loadScrollViewWithPage:1];
    }
    return self;
}

- (void)dealloc
{
    [_scrollView release];
    [super dealloc];
}

#pragma mark - ScrollView Delegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    _pageControlUsed = NO;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // We don't want a "feedback loop" between the UIPageControl and the scroll delegate in
    // which a scroll event generated from the user hitting the page control triggers updates from
    // the delegate method. We use a boolean to disable the delegate logic when the page control is used.
    if (_pageControlUsed)
    {
        // do nothing - the scroll was initiated from the page control, not the user dragging
        return;
    }
	
    // Switch the indicator when more than 50% of the previous/next page is visible
    CGFloat pageWidth = scrollView.frame.size.width;
    int page = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    _pageControl.currentPage = page;
    
    // load the visible page and the page on either side of it (to avoid flashes when the user starts scrolling)
    [self loadScrollViewWithPage:page - 1];
    [self loadScrollViewWithPage:page];
    [self loadScrollViewWithPage:page + 1];
    
    // A possible optimization would be to unload the views+controllers which are no longer visible
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    _pageControlUsed = NO;
}

#pragma mark - Public Methods
- (UIScrollView *)getScrollView
{
    return _scrollView;
}

- (void)setHide:(BOOL)value
{
    _scrollView.hidden = value;
    _pageControl.hidden = value;
}


#pragma mark - Private Methods
- (void)changePage
{
    int page = _pageControl.currentPage;
	
    // load the visible page and the page on either side of it (to avoid flashes when the user starts scrolling)
    [self loadScrollViewWithPage:page - 1];
    [self loadScrollViewWithPage:page];
    [self loadScrollViewWithPage:page + 1];
    
	// update the scroll view to the appropriate page
    CGRect frame = _scrollView.frame;
    frame.origin.x = frame.size.width * page;
    frame.origin.y = 0;
    [_scrollView scrollRectToVisible:frame animated:YES];
    
	// Set the boolean used when scrolls originate from the UIPageControl. See scrollViewDidScroll: above.
    _pageControlUsed = YES;
}

- (void)loadScrollViewWithPage:(int)page
{
    if (page < 0)
        return;
    if (page >= ARRAY_CAPCITY)
        return;
    
    // replace the placeholder if necessary
    FlipView *controller = [_flipArray objectAtIndex:page];
    if ((NSNull *)controller == [NSNull null])
    {
        controller = [[FlipView alloc] initWithPageNumber:page];
        [_flipArray replaceObjectAtIndex:page withObject:controller];
        [controller release];
    }
    
    // add the controller's view to the scroll view
    if (controller.superview == nil)
    {
        UIImage *img = [UIImage imageNamed:[NSString stringWithFormat:@"%@_%i.png", ADV_IMG_NAME, page]];
        [controller setImage:img];
        
        CGRect frame = _scrollView.frame;
        frame.origin.x = frame.size.width * page;
        frame.origin.y = 0;
        controller.frame = frame;
        [_scrollView addSubview:controller];
        
//        NSDictionary *numberItem = [self.contentList objectAtIndex:page];
//        controller.numberImage.image = [UIImage imageNamed:[numberItem valueForKey:ImageKey]];
//        controller.numberTitle.text = [numberItem valueForKey:NameKey];

    }
}

@end
