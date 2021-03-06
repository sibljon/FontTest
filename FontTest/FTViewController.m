//
//  FTViewController.m
//  FontTest
//
//  Created by Ray Lillywhite on 12/6/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "FTViewController.h"



@implementation FTViewController

@synthesize textField = _textField;
@synthesize scrollView = _scrollView;
@synthesize sizeTextField = _sizeTextField;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

- (void)refreshLabels
{
    [self.scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    CGFloat x = 10.0;
    CGFloat y = 10.0;
    CGFloat maxX = 10.0;
    
    CGFloat fontSize = [self.sizeTextField.text floatValue];
    
    if (fontSize < 5.0)
    {
        fontSize = 5.0;
    }
    
    for (NSString *familyName in [[UIFont familyNames] sortedArrayUsingSelector:@selector(compare:)])
    {
        for (NSString *name in [[UIFont fontNamesForFamilyName:familyName] sortedArrayUsingSelector:@selector(compare:)])
        {
            UIFont *font = [UIFont fontWithName:name size:fontSize];
            
            UIView *lineHeight = [[UIView alloc] initWithFrame:CGRectMake(x, y + font.lineHeight, 1.0, font.lineHeight)];
            lineHeight.backgroundColor = [UIColor purpleColor];
            [self.scrollView addSubview:lineHeight];
            
            UIView *ascender = [[UIView alloc] initWithFrame:CGRectMake(lineHeight.frame.origin.x + 2.0, y + font.lineHeight, 1.0, font.ascender)];
            ascender.backgroundColor = [UIColor redColor];
            [self.scrollView addSubview:ascender];
            
            UIView *capHeight = [[UIView alloc] initWithFrame:CGRectMake(ascender.frame.origin.x + 2.0, y + font.lineHeight + font.ascender - font.capHeight, 1.0, font.capHeight)];
            capHeight.backgroundColor = [UIColor orangeColor];
            [self.scrollView addSubview:capHeight];
            
            UIView *descender = [[UIView alloc] initWithFrame:CGRectMake(lineHeight.frame.origin.x + 1.0, y + font.lineHeight + font.ascender, 1.0, -font.descender)];
            descender.backgroundColor = [UIColor blueColor];
            [self.scrollView addSubview:descender];
            
            UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(x + 10.0, y, 0.0, 0.0)];
            label1.text = name;
            label1.font = font;
            [label1 sizeToFit];
            [self.scrollView addSubview:label1];
            
            maxX = MAX(label1.frame.size.width + label1.frame.origin.x, maxX);
            y += label1.frame.size.height;
            
            UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(label1.frame.origin.x, y, 0.0, 0.0)];
            label2.text = self.textField.text;
            label2.font = label1.font;
            [label2 sizeToFit];
            [self.scrollView addSubview:label2];
            
            maxX = MAX(label2.frame.size.width + label2.frame.origin.x, maxX);
            y += label2.frame.size.height + 10.0;
        }
    }
    self.scrollView.contentSize = CGSizeMake(maxX, y);
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self refreshLabels];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [self refreshLabels];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.textField resignFirstResponder];
    [self.sizeTextField resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return NO;
}


@end
