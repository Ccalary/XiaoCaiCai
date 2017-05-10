//
//  AddressPickerView.h
//  去去去
//
//  Created by liqiang on 15/11/12.
//  Copyright © 2015年 dieshang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AddressPickerViewDelegate <NSObject>
@optional
- (void)ensureWithAddress:(NSString *)address provinceId:(NSInteger)provinceId cityId:(NSInteger)cityId locationDistrictId:(NSInteger)locationDistrictId;
@optional
- (void)ensureWithAddress:(NSString *)address provinceId:(NSInteger)provinceId provinceName:(NSString *)provinceName cityId:(NSInteger)cityId  cityName:(NSString *)cityName locationDistrictId:(NSInteger)locationDistrictId locationDistrictName:(NSString *)locationDistrictName ;
@end

@interface AddressPickerView : UIView

@property (nonatomic, weak) id<AddressPickerViewDelegate> delegate;

- (void)showMyPicker;

/**
 *  需要显示不限
 */
- (void)showMyPickerWithAddress:(NSString *)address;

/**
 *  不需要显示不限
 */
- (void)showMyPickerWithProvinceId:(NSInteger)provinceId cityId:(NSInteger)cityId districtId:(NSInteger)districtId;

@end
