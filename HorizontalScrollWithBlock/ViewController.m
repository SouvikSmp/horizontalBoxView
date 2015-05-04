//
//  ViewController.m
//  HorizontalScrollWithBlock
//
//  Created by Souvik on 04/05/15.
//  Copyright (c) 2015 Souvik. All rights reserved.
//

#import "ViewController.h"
#import "HorizontalBlockView.h"

@interface ViewController ()<HorizontalBlockDelegate>
{
    HorizontalBlockView *horiZental;
}

@property (weak, nonatomic) IBOutlet UIView *BlockView;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
   //Adding HoriZontal Scroll with block in ios
    horiZental=[[HorizontalBlockView alloc] initWithFrame:CGRectMake(0, 0, _BlockView.frame.size.width, _BlockView.frame.size.height)];
    horiZental.delegate=self;
    [_BlockView addSubview:horiZental];
    [horiZental RefreshTotalContent];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)BlockViewNumborofColoum:(HorizontalBlockView *)HorizontalView
{
    return 20;
}
-(NSInteger)SetNumborofRowToBlockView:(HorizontalBlockView *)HorizontalView
{
    return 10;
}

-(UIView *)BlockView:(HorizontalBlockView *)HorizontalView Viewforindex:(NSInteger)Index Defauldview:(UIView *)Defauldview
{
    
    return Defauldview;
}

-(CGFloat)BlockViewWidthtofeachcell:(HorizontalBlockView *)HorizontalView
{
    return 64.0f;
}
-(CGFloat)BlockViewViewHeightofEachcell:(HorizontalBlockView *)HorizontalView
{
    return 50.0f;
}
-(CGFloat)BlockViewGapbeteentwocell:(HorizontalBlockView *)HorizontalView
{
    return 1.0f;
}
-(NSInteger)ColoumCountingStartfrom:(HorizontalBlockView *)HorizontalView
{
    return 1;
}

-(void)BlockView:(HorizontalBlockView *)HorizontalView didselectacoloumat:(NSInteger)ColumNumber androw:(NSInteger)Rownumber
{
    NSLog(@"The value of coloum and row:%ld and %ld",ColumNumber,Rownumber);
}

@end
