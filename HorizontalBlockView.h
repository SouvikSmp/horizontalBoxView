//
//  HorizontalBlockView.h
//  HorizontalScrollWithBlock
//
//  Created by Souvik on 04/05/15.
//  Copyright (c) 2015 Souvik. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HorizontalBlockView;
@protocol HorizontalBlockDelegate <NSObject>

-(UIView *)BlockView:(HorizontalBlockView *)HorizontalView Viewforindex:(NSInteger)Index Defauldview:(UIView *)Defauldview;
-(CGFloat)BlockViewWidthtofeachcell:(HorizontalBlockView *)HorizontalView;
-(NSInteger)BlockViewNumborofColoum:(HorizontalBlockView *)HorizontalView;
-(NSInteger)SetNumborofRowToBlockView:(HorizontalBlockView *)HorizontalView;
-(CGFloat)BlockViewViewHeightofEachcell:(HorizontalBlockView *)HorizontalView;
-(CGFloat)BlockViewGapbeteentwocell:(HorizontalBlockView *)HorizontalView;
@optional
-(void)BlockView:(HorizontalBlockView *)HorizontalView didselectacoloumat:(NSInteger)ColumNumber androw:(NSInteger)Rownumber;
-(NSInteger)ColoumCountingStartfrom:(HorizontalBlockView *)HorizontalView;

@end

@interface HorizontalBlockView : UIView
{
    UIScrollView *MainBackScroll;
    NSInteger RowNumbor;
    NSInteger ColoumNumbor;
    NSMutableArray *StoreAllview;
    NSInteger _visibleColumnCount;
    NSMutableArray *columnPool;
    NSUInteger _currentPhysicalPageIndex;
}
-(UIScrollView *)Getscrollview;
-(void)RefreshTotalContent;
-(BOOL)isNextcoloumfill;
-(UIView *)indecatorviewtoindicatethecoloumn:(CGFloat)width andvalues:(NSMutableArray *)totalcontent;
@property (assign) IBOutlet id<HorizontalBlockDelegate> delegate;

@end
