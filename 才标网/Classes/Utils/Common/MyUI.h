//
//  MyUI.h
//  GLKiphone
//
//  Created by 刘锋婷 on 14/6/10.
//  Copyright (c) 2014年 刘锋婷. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyVerticalLable.h"

/**
 *  UILabel
 */
@interface UILabel (Creation)

+(UILabel *)createLabelWithFrame:(CGRect)rect backgroundColor:(UIColor *)color textColor:(UIColor *)textColor font:(UIFont *)font textalignment:(NSTextAlignment )alignment text:(NSString *)text;
+(UILabel *)createLabelWithFrame:(CGRect)rect backgroundColor:(UIColor *)color textColor:(UIColor *)textColor font:(UIFont *)font textalignment:(NSTextAlignment )alignment text:(NSString *)text numberOfLine:(NSInteger)numberOfline;
+(UILabel *)createLabelWithFrame:(CGRect)rect backgroundColor:(UIColor *)color textColor:(UIColor *)textColor font:(UIFont *)font textalignment:(NSTextAlignment )alignment text:(NSString *)text conrnerRadius:(CGFloat)cornerRadius borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;

+(MyVerticalLable *)createVerticalLabelWithFrame:(CGRect)rect backgroundColor:(UIColor *)color textColor:(UIColor *)textColor font:(UIFont *)font textalignment:(NSTextAlignment )alignment text:(NSString *)text numberOfLine:(NSInteger)numberOfline verticalAlignment:(VerticalAlignment)verticalAlign;
@end



/**
 *  UIView
 *
 *  @param rect  rect
 *  @param color color
 *
 *  @return view
 */
@interface UIView  (Creation)

+(UIView *)createViewWithFrame:(CGRect)rect backgroundColor:(UIColor *)color;
+(UIView *)createViewWithFrame:(CGRect)rect backgroundColor:(UIColor *)color conrnerRadius:(CGFloat)cornerRadius borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;

@end

/**
 *  UITextField
 *
 *  @param rect        rect
 *  @param color       color
 *  @param borderStyle borderStyle
 *  @param placeholder placeholder
 *  @param text        text
 *  @param textColor   textColor
 *  @param font        font
 *
 *  @return textField
 */
@interface UITextField (Creation)

+(UITextField *)createTextFieldWithFrame:(CGRect)rect backgroundColor:(UIColor *)color borderStyle:(UITextBorderStyle)borderStyle placeholder:(NSString *)placeholder text:(NSString *)text textColor:(UIColor *)textColor font:(UIFont *)font textalignment:(NSTextAlignment )alignment;

@end


/**
 *  UIButton
 *
 *  @param rect  rect
 *  @param color color
 *  @param image image
 *
 *  @return button
 */
@interface UIButton (Creations)

+(UIButton *)createButtonwithFrame:(CGRect)rect backgroundColor:(UIColor *)color image:(UIImage *)image;
+(UIButton *)createButtonwithFrame:(CGRect)rect backgroundColor:(UIColor *)color titleColor:(UIColor *)titleColor title:(NSString *)title;
#pragma mark - iconfont
+(UIButton *)createButtonwithFrame:(CGRect)rect backgroundColor:(UIColor *)color titleColor:(UIColor *)titleColor font:(UIFont *)font title:(NSString *)title;
+(UIButton *)createButtonwithFrame:(CGRect)rect backgroundColor:(UIColor *)color titleColor:(UIColor *)titleColor font:(UIFont *)font title:(NSString *)title conrnerRadius:(CGFloat)cornerRadius borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;

+(UIButton *)createButtonwithFrame:(CGRect)rect backgroundColor:(UIColor *)color conrnerRadius:(CGFloat)cornerRadius borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;

@end

@interface UIBarButtonItem (Creation)
+(UIBarButtonItem *)createBarButtonWithImage:(NSString *)imgstr titleColor:(UIColor *)title_color titleText:(NSString *)title_text selector:(SEL)selector target :(id)target;
+(UIBarButtonItem *)createBarButtonWithImage:(NSString *)imgstr titleColor:(UIColor *)title_color titleText:(NSString *)title_text selector:(SEL)selector target :(id)target redDot:(BOOL)hasRedDot;
@end

/**
 *  UIImageView
 *
 *  @param rect  rect
 *  @param color color
 *  @param image image
 *
 *  @return imageView
 */
@interface UIImageView (Creation)

+(UIImageView *)createImageViewWithFrame:(CGRect)rect backgroundColor:(UIColor *)color image:(UIImage *)image;
+(UIImageView *)createImageViewWithFrame:(CGRect)rect backgroundColor:(UIColor *)color image:(UIImage *)image conrnerRadius:(CGFloat)cornerRadius borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;

@end


@interface UIScrollView (Creation)

@end



/**
 *  UITableView
 *
 *  @param rect       rect
 *  @param color      coloor
 *  @param delegate   delegate
 *  @param dataSourse dataSorce
 *
 *  @return tableView
 */
@interface UITableView (Creation)

+(UITableView *)createTableViewWithFrame:(CGRect)rect style:(UITableViewStyle)Style  backgroundColor:(UIColor *)color delegate:(id<UITableViewDelegate>)delegate dataSource:(id<UITableViewDataSource>)dataSourse;
+(UITableView *)createTableViewWithFrame:(CGRect)rect style:(UITableViewStyle)Style  backgroundColor:(UIColor *)color delegate:(id<UITableViewDelegate>)delegate dataSource:(id<UITableViewDataSource>)dataSourse  separatorColor:(UIColor *)separatorColor separatorInset:(UIEdgeInsets)separatorInset;

@end

/**
 *  UICollectionViewFlowLayout
 *
 *  @param scrollDirection scrollDirection
 *  @param minimumY        minimumY
 *  @param minimumX        minimumX
 *
 *  @return collectionViewFlowLayout
 */

@interface UICollectionViewFlowLayout (Creation)

+(UICollectionViewFlowLayout *)createCollectionViewFlowLayoutWithScrollDirection:(UICollectionViewScrollDirection)scrollDirection minimumY:(CGFloat )minimumY minimumX:(CGFloat)minimumX;

@end

/**
 *  UICollectionView
 *
 *  @param rect       rect
 *  @param flowLayout flowLayout
 *  @param color      color
 *  @param delegate   delegate
 *  @param dataSourse dataSource
 *
 *  @return collectionView
 */
@interface UICollectionView (Creation)

+(UICollectionView *)createCollectionViewWithFrame:(CGRect)rect collectionViewLayout:(UICollectionViewFlowLayout *)flowLayout  backgroundColor:(UIColor *)color delegate:(id<UICollectionViewDelegate>)delegate dataSource:(id<UICollectionViewDataSource>)dataSourse;

@end







/**
 *  UISegmentedControl
 *
 *  @param rect
 *  @param nameArray
 *  @param backgroundColor
 *  @param tintColor
 *  @param selectedIndex
 *
 *  @return UISegmentedControl
 */
@interface  UISegmentedControl (Creation)

+(UISegmentedControl *)createSegmentWithFrame:(CGRect)rect nameArray:(NSArray *)nameArray backgroundColor:(UIColor *)backgroundColor tintColor:(UIColor *)tintColor selectedIndex:(NSInteger)selectedIndex;

@end





//
///**
// *  UIColor
// *
// *  @param rect       rect
// *  @param flowLayout flowLayout
// *  @param color      color
// *  @param delegate   delegate
// *  @param dataSourse dataSource
// *
// *  @return Hex color
// */
//
//@interface UIColor (Hex)
//
//+ (UIColor *)colorWithHex:(NSString *)hexColor;
//+ (UIColor *)colorWithHex:(NSString *)hexColor alpha:(float)opacity;
//
//@end



/**
 *  CAShapeLayer line
 */
@interface CAShapeLayer (Creation)
/**
 *  CAShapeLayer line
 *
 *  @param startPoint
 *  @param endPoint
 *  @param color
 *  @param lineWidth
 *
 *  @return line
 */
+(CAShapeLayer *)createLineWithStartPoint:(CGPoint )startPoint endPoint:(CGPoint )endPoint color:(UIColor *)color lineWidth:(CGFloat)lineWidth;

/**
 *  CAShapeLayer rect
 *
 *  @param rect
 *  @param fillColor
 *  @param strokColor
 *  @param lineWidth
 *  @param cornerRadius
 *
 *  @return rect
 */
+(CAShapeLayer *)createRect:(CGRect)rect fillColor:(UIColor *)fillColor strokColor:(UIColor *)strokColor lineWidth:(CGFloat)lineWidth cornerRadius:(CGFloat)cornerRadius;

@end



