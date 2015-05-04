//
//  HorizontalBlockView.m
//  HorizontalScrollWithBlock
//
//  Created by Souvik on 04/05/15.
//  Copyright (c) 2015 Souvik. All rights reserved.
//

#import "HorizontalBlockView.h"

@interface HorizontalBlockView()<UIScrollViewDelegate,UITextFieldDelegate>
{
    NSInteger Rowrecentposition;
    BOOL isTaparow;
}
@end
@implementation HorizontalBlockView
@synthesize delegate=_delegate;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        // Initialization code
        [self Prepareviewforscorecard];
        
    }
    return self;
}
-(void)RefreshTotalContent
{
    StoreAllview=[[NSMutableArray alloc]initWithCapacity:20];
    isTaparow=FALSE;
    NSUInteger numborOfphysicalindex=[self Numborofcoloum];
    for (NSUInteger i = 0; i < numborOfphysicalindex; ++i)
    {
        [StoreAllview addObject:[NSNull null]];
    }
    [self setNeedsDisplay];
    
}

- (void)layoutPages
{
    CGSize pageSize = self.bounds.size;
    MainBackScroll.contentSize = CGSizeMake([StoreAllview count] * [self ColoumWidth], pageSize.height);
}

-(BOOL)isNextcoloumfill
{
    return YES;
}

-(UIScrollView *)Getscrollview
{
    return MainBackScroll;
    
}


- (void)layoutSubviews
{
    [self layoutPages];
    [self currentPageIndexDidChange];
}


-(CGFloat)ColoumWidth
{
    CGFloat coloumwidth=0.0f;
    if (_delegate)
    {
        coloumwidth=[_delegate BlockViewWidthtofeachcell:self];
    }
    return coloumwidth;
}

-(NSInteger)Numborofrow
{
    NSInteger RowNumbormw=0;
    if (_delegate)
    {
        RowNumbormw=[_delegate SetNumborofRowToBlockView:self];
    }
    return RowNumbormw;
}

-(NSInteger)Numborofcoloum
{
    ColoumNumbor=0;
    if (_delegate)
    {
        ColoumNumbor=[_delegate BlockViewNumborofColoum:self];
    }
    return ColoumNumbor;
}


-(void)Prepareviewforscorecard
{
    
    columnPool=[[NSMutableArray alloc]init];
    [self setClipsToBounds:YES];
    self.autoresizesSubviews = YES;
    UIScrollView *scroller = [[UIScrollView alloc] init];
    CGRect rect = self.bounds;
    scroller.frame = rect;
    
    scroller.delegate = self;
    scroller.autoresizesSubviews = YES;
    scroller.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    scroller.showsHorizontalScrollIndicator = YES;
    scroller.showsVerticalScrollIndicator = NO;
    scroller.alwaysBounceVertical = NO;
    
    MainBackScroll = scroller;
    [self addSubview:scroller];
    
}


-(UIView *)PreparecoloumWithXposition:(NSUInteger)ColoumPostition
{
    
    UIView *mainView=[[UIView alloc] initWithFrame:CGRectMake((ColoumPostition*[self ColoumWidth])+(ColoumPostition*[self setGap]), 0, [self ColoumWidth], ([self Heightofcell]*[self Numborofrow])+[self Numborofrow])];
    mainView.backgroundColor=[UIColor clearColor];
    UIView *headerView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, [self ColoumWidth]-1, 25.0f)];
    [headerView setBackgroundColor:[UIColor whiteColor]];
    [headerView setAlpha:.4];
    [mainView addSubview:headerView];
    
    UILabel *MainLable=[[UILabel alloc] initWithFrame:CGRectMake(0, 1, [self ColoumWidth]-1, 25.0f)];
    MainLable.font=[UIFont fontWithName:@"Armata-Regular" size:15.0f];
    MainLable.textColor=[UIColor whiteColor];
    MainLable.textAlignment=NSTextAlignmentCenter;
    [MainLable setText:[NSString stringWithFormat:@"%lu",ColoumPostition+1]];
    
    [mainView addSubview:MainLable];
    for (int i=0; i<[self Numborofrow]; i++)
    {
        UIView *ColoumView=[[UIView alloc] initWithFrame:CGRectMake(0, ([self Heightofcell]*i)+(i*[self setGap])+26.0f, [self ColoumWidth]-1, [self Heightofcell])];
        [ColoumView setTag:(100*(ColoumPostition+1))+i];
        
        [ColoumView setAlpha:.1f];
        if (isTaparow)
        {
            if (i==Rowrecentposition)
            {
                [ColoumView setAlpha:.4f];
            }
        }
        if (ColoumPostition==9||ColoumPostition==19)
        {
            [ColoumView setBackgroundColor:[UIColor blackColor]];
            [ColoumView setAlpha:.40f];
            if (ColoumPostition==9)
            {
                MainLable.text=@"IN";
            }
            else
            {
                MainLable.text=@"OUT";
            }
        }
        else
        {
            [ColoumView setBackgroundColor:[UIColor whiteColor]];
        }
        [mainView addSubview:ColoumView];
        if (i>2)
        {
            if (ColoumPostition==9||ColoumPostition==19)
            {
                UILabel *scorelbl=[[UILabel alloc] init];
                scorelbl.frame=ColoumView.frame;
                scorelbl.textColor=[UIColor whiteColor];
                scorelbl.textAlignment=NSTextAlignmentCenter;
                scorelbl.font=[UIFont fontWithName:@"Armata-Regular" size:17.0f];
                [mainView addSubview:scorelbl];
                [scorelbl setTag:(3000*(ColoumPostition+1))+i];
            }
            else
            {
                UITextField *textField=[[UITextField alloc] init];
                textField.frame=ColoumView.frame;
                [textField setEnabled:YES];
                textField.textColor=[UIColor whiteColor];
                textField.textAlignment=NSTextAlignmentCenter;
                textField.font=[UIFont fontWithName:@"Armata-Regular" size:17.0f];
                [mainView addSubview:textField];
                [textField setKeyboardAppearance:UIKeyboardAppearanceDefault];
                [textField setTag:(3000*(ColoumPostition+1))+i];
                [textField setText:@"ME"];
                textField.delegate=self;
                UILabel *Exponentlbl=[[UILabel alloc] initWithFrame:CGRectMake([self ColoumWidth]-38, 4, 16, 16)];
                Exponentlbl.text=@"S";
                Exponentlbl.font=[UIFont fontWithName:@"Armata-Regular" size:15.0f];
                Exponentlbl.textAlignment=NSTextAlignmentCenter;
                Exponentlbl.textColor=[UIColor whiteColor];
                [textField addSubview:Exponentlbl];
                
            }
            
            
        }
        else
        {
            UILabel *lable=[[UILabel alloc] initWithFrame:ColoumView.frame];
            lable.textColor=[UIColor whiteColor];
            lable.font=[UIFont fontWithName:@"Armata-Regular" size:15.0f];
            [mainView addSubview:lable];
            [lable setTag:(3000*(ColoumPostition+1))+i];
        }
    }
    return mainView;
}

-(NSUInteger)CalculatepageIndex
{
    NSInteger pageno=MainBackScroll.contentOffset.x/[self ColoumWidth];
    return pageno;
}

-(void)setphysicalpageindex:(NSUInteger)newIndex
{
    MainBackScroll.contentOffset = CGPointMake(newIndex * [self pageSize].width, 0);
}


//---Total Size of the the Added scroll
- (CGSize)pageSize
{
    CGRect rect = MainBackScroll.bounds;
    return rect.size;
}

- (void)currentPageIndexDidChange
{
    
    CGSize pageSize = [self pageSize];
    CGFloat columnWidth = [self ColoumWidth];
    _visibleColumnCount = pageSize.width / columnWidth + 2;
    NSInteger leftMostPageIndex = -1;
    NSInteger rightMostPageIndex = 0;
    
    for (NSInteger i = -2; i < _visibleColumnCount; i++)
    {
        NSInteger index = _currentPhysicalPageIndex + i;
        if (index < [StoreAllview count] && (index >= 0))
        {
            [self layoutPhysicalPage:index];
            if (leftMostPageIndex < 0)
                leftMostPageIndex = index;
            rightMostPageIndex = index;
        }
    }
    // clear out views to the left
    for (NSInteger i = 0; i < leftMostPageIndex; i++)
    {
        [self removeColumn:i];
    }
    // clear out views to the right
    for (NSInteger i = rightMostPageIndex + 1; i < [StoreAllview count]; i++)
    {
        [self removeColumn:i];
    }
}
//Setdelegate for height of each box

-(CGFloat)Heightofcell
{
    CGFloat cellheight=0.0f;
    if (_delegate)
    {
        cellheight=[_delegate BlockViewViewHeightofEachcell:self];
    }
    return cellheight;
}

//Set delegate to set the gap between two cell

-(CGFloat)setGap
{
    CGFloat gapewidth=1.0f;
    if (_delegate)
    {
        gapewidth=[_delegate BlockViewGapbeteentwocell:self];
    }
    return gapewidth;
}


- (void)removeColumn:(NSInteger)index
{
    if ([StoreAllview objectAtIndex:index] != [NSNull null])
    {
        UIView *vw = [StoreAllview objectAtIndex:index];
        [self queueColumnView:vw];
        [vw removeFromSuperview];
        [StoreAllview replaceObjectAtIndex:index withObject:[NSNull null]];
    }
}

- (void)layoutPhysicalPage:(NSUInteger)pageIndex
{
    UIView *pageView = [self viewForPhysicalPage:pageIndex];
    CGFloat viewWidth = pageView.bounds.size.width;
    CGSize pageSize = [self pageSize];
    CGRect rect = CGRectMake(viewWidth * pageIndex, 0, viewWidth, pageSize.height);
    pageView.frame = rect;
}

- (void)queueColumnView:(UIView *)vw
{
    if ([columnPool count]>0)
    {
        return;
    }
    [columnPool addObject:vw];
}

- (UIView *)dequeueColumnView
{
    UIView *vw = [columnPool lastObject];
    if (vw)
    {
        [columnPool removeLastObject];
    }
    return vw;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    NSUInteger newPageIndex = [self CalculatepageIndex];
    if (newPageIndex == _currentPhysicalPageIndex)
        return;
    _currentPhysicalPageIndex = newPageIndex;
    _currentPhysicalPageIndex = newPageIndex;
    
    [self currentPageIndexDidChange];
    
}

- (UIView *)viewForPhysicalPage:(NSUInteger)pageIndex
{
    UIView *pageView;
    if ([StoreAllview objectAtIndex:pageIndex] == [NSNull null])
    {
        if (_delegate)
        {
            pageView = [_delegate BlockView:self Viewforindex:pageIndex Defauldview:[self PreparecoloumWithXposition:pageIndex]];
            [StoreAllview replaceObjectAtIndex:pageIndex withObject:pageView];
            [MainBackScroll addSubview:pageView];
        }
    }
    else
    {
        pageView = [StoreAllview objectAtIndex:pageIndex];
    }
    return pageView;
}



//view for left indicator view

-(UIView *)indecatorviewtoindicatethecoloumn:(CGFloat)width andvalues:(NSMutableArray *)totalcontent
{
    
    
    UIView *coloumnmainview=[[UIView alloc] initWithFrame:CGRectMake(0, 0, width, ([self Heightofcell]*[self Numborofrow])+([self Numborofrow]*[self setGap])+26.0f)];
    UIView *viewHole=[[UIView alloc] initWithFrame:CGRectMake(0, 0, width, 25)];
    [viewHole setAlpha:.4];
    [viewHole setBackgroundColor:[UIColor whiteColor]];
    [coloumnmainview addSubview:viewHole];
    UILabel *lblhole= [[UILabel alloc] initWithFrame:CGRectMake(0, 1, width, 25)];
    [lblhole setTextAlignment:NSTextAlignmentCenter];
    lblhole.font=[UIFont fontWithName:@"Armata-Regular" size:15.0f];
    [lblhole setTextColor:[UIColor whiteColor]];
    lblhole.text=@"Hole";
    [coloumnmainview addSubview:lblhole];
    
    for (int i=0; i<[self Numborofrow]; i++)
    {
        UIView *mainbackview=[[UIView alloc] initWithFrame:CGRectMake(0, 26+([self Heightofcell]*i)+i, width, [self Heightofcell])];
        [mainbackview setAlpha:.4];
        [mainbackview setBackgroundColor:[UIColor whiteColor]];
        [coloumnmainview addSubview:mainbackview];
        if (i<3)
        {
            UILabel *mainlable=[[UILabel alloc] initWithFrame:mainbackview.frame];
            [mainlable setFont:[UIFont fontWithName:@"Armata-Regular" size:15.0f]];
            mainlable.textAlignment=NSTextAlignmentCenter;
            mainlable.text=[totalcontent objectAtIndex:i];
            mainlable.textColor=[UIColor whiteColor];
            [coloumnmainview addSubview:mainlable];
            
        }
        else
        {
            UIView *backview=[[UIView alloc] initWithFrame:mainbackview.frame];
            [backview setBackgroundColor:[UIColor clearColor]];
            [coloumnmainview addSubview:backview];
            
            UIView *viewuserimageback=[[UIView alloc] initWithFrame:CGRectMake(30, 2, 30, 30)];
            viewuserimageback.alpha=.2f;
            [viewuserimageback setBackgroundColor:[UIColor whiteColor]];
            viewuserimageback.layer.cornerRadius=viewuserimageback.frame.size.width/2;
            viewuserimageback.layer.masksToBounds=YES;
            [backview addSubview:viewuserimageback];
            
            
            
            UILabel *usernamelable=[[UILabel alloc] initWithFrame:CGRectMake(2.0f, 34.0f, 86.0f, 16)];
            [usernamelable setTextColor:[UIColor whiteColor]];
            usernamelable.font=[UIFont fontWithName:@"Armata-Regular" size:14.0f];
            usernamelable.text=@"User Name";
            usernamelable.textAlignment=NSTextAlignmentCenter;
            [backview addSubview:usernamelable];
            
            
            UIImageView *userimageview=[[UIImageView alloc] initWithFrame:CGRectMake(32, 4,26, 26)];
            [self downloadimagewithspinner:[totalcontent objectAtIndex:i] withimageview:userimageview];
            [backview addSubview:userimageview];
            UITapGestureRecognizer *recognizer=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(TaptoselectaRow:)];
            [backview setTag:100000+i];
            [backview setUserInteractionEnabled:YES];
            [backview addGestureRecognizer:recognizer];
        }
        
    }
    return coloumnmainview;
}

//Do tapto select a particular score card row from all scorecard

-(void)TaptoselectaRow:(UITapGestureRecognizer *)tapgesture
{
    UIView *ImageView=(UIView *)[[tapgesture self] view];
    Rowrecentposition=ImageView.tag-100000;
    isTaparow=TRUE;
    
    
    for (NSInteger j=0;j<[self Numborofcoloum]; j++)
    {
        for (NSInteger i=0; i<[self Numborofrow]; i++)
        {
            if (ColoumNumbor!=9||ColoumNumbor!=19)
            {
                UIView *viewbackall=(UIView *)[MainBackScroll viewWithTag:(100*(j+1))+i];
                viewbackall.alpha=.07;
            }
            
        }
        
        UIView *viewback=(UIView *)[MainBackScroll viewWithTag:(100*(j+1))+Rowrecentposition];
        viewback.alpha=.4;
    }
    
}

-(NSUInteger)rowcountstartfrom
{
    NSInteger rowcount=0;
    if (_delegate)
    {
        rowcount=[_delegate ColoumCountingStartfrom:self];
    }
    return rowcount;
}

-(void)downloadimagewithspinner:(NSString *)url withimageview:(UIImageView *)imageview
{
    UIActivityIndicatorView *spinnerView=[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    [spinnerView setCenter:imageview.center];
    [spinnerView startAnimating];
    [spinnerView hidesWhenStopped];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSURL *mainurl;
        mainurl=[NSURL URLWithString:url];
        NSData *data=[NSData dataWithContentsOfURL:mainurl];
        UIImage *muimage=[UIImage imageWithData:data];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [imageview setImage:muimage];
            [imageview.layer setCornerRadius:imageview.frame.size.height/2];
            imageview.layer.borderColor=[UIColor clearColor].CGColor;
            imageview.layer.masksToBounds=YES;
            [spinnerView stopAnimating];
        });
        
        
    });
    
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    NSInteger coloumno=(textField.tag-Rowrecentposition)/3000-1;
    if ([_delegate respondsToSelector:@selector(BlockView:didselectacoloumat:androw:)])
    {
        [_delegate BlockView:self didselectacoloumat:coloumno androw:Rowrecentposition];
    }
}


//UITextViewDelegate

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}


@end
