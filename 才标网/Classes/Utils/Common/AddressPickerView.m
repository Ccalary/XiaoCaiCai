//
//  AddressPickerView.m
//  去去去
//
//  Created by liqiang on 15/11/12.
//  Copyright © 2015年 dieshang. All rights reserved.
//

#import "AddressPickerView.h"
#import "UtilString.h"
#import "CBConnect.h"

@interface AddressPickerView()<UIPickerViewDataSource,UIPickerViewDelegate>

@property (weak, nonatomic)  UIPickerView *pickerView;
@property (strong, nonatomic) UIView *maskView;

@property (nonatomic, weak) UIView *backgroundView;

//data
@property (strong, nonatomic) NSDictionary *pickerDic;
@property (strong, nonatomic) NSArray *provinceArray;
@property (strong, nonatomic) NSArray *cityArray;
@property (strong, nonatomic) NSArray *townArray;
@property (strong, nonatomic) NSArray *selectedArray;
@property (nonatomic, strong) NSDictionary *selectDic;

@end

@implementation AddressPickerView

- (NSArray *)provinceArray
{
    if (!_provinceArray) {
        _provinceArray = [NSArray array];
    }
    
    return _provinceArray;
}

- (NSArray *)cityArray
{
    if (!_cityArray) {
        _cityArray = [NSArray array];
    }
    
    return _cityArray;
}

- (NSArray *)townArray
{
    if (!_townArray) {
        _townArray = [NSArray array];
    }
    
    return _townArray;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.backgroundColor = [UIColor clearColor];
        
        [self drawView];
    }
    
    return self;
}

- (void)drawView
{
    UIView *maskView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    maskView.backgroundColor = [UIColor blackColor];
    maskView.alpha = 0.3;
    [self addSubview:maskView];
    [maskView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hidePickerView)]];
    
    UIView *backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height, self.frame.size.width, 230)];
    backgroundView.backgroundColor = [UIColor whiteColor];
    [self addSubview:backgroundView];
    self.backgroundView = backgroundView;
    
    UIButton *btn1 = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 30)];
    [btn1 setTitle:@"取消" forState:UIControlStateNormal];
    [btn1 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(hidePickerView) forControlEvents:UIControlEventTouchUpInside];
    [backgroundView addSubview:btn1];
    
    UIButton *btn2 = [[UIButton alloc] initWithFrame:CGRectMake(self.frame.size.width-50, 0, 50, 30)];
    [btn2 setTitle:@"确定" forState:UIControlStateNormal];
    [btn2 setTitleColor:[UIColor colorWithRed:82/255. green:106/255. blue:165/255. alpha:1] forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(ensure) forControlEvents:UIControlEventTouchUpInside];
    [backgroundView addSubview:btn2];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(btn1.frame)+5, self.frame.size.width, 1)];
    line.backgroundColor = [UIColor colorWithRed:229/255. green:229/255. blue:229/255. alpha:1];
    [backgroundView addSubview:line];
    
    UIPickerView *pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(line.frame), self.frame.size.width, 200)];
    pickerView.dataSource = self;
    pickerView.delegate = self;
    [backgroundView addSubview:pickerView];
    self.pickerView = pickerView;
}

- (void)showMyPicker
{
    [self requestCityWithAddress:nil];
}

- (void)showMyPickerWithAddress:(NSString *)address
{
    [self requestCityWithAddress:address];
}

- (void)showMyPickerWithProvinceId:(NSInteger)provinceId cityId:(NSInteger)cityId districtId:(NSInteger)districtId
{
    [self requestCityWithProvinceId:(NSInteger)provinceId cityId:(NSInteger)cityId districtId:(NSInteger)districtId];
}

- (void)reloadAddressDataWithProvinceId:(NSInteger)provinceId cityId:(NSInteger)cityId districtId:(NSInteger)districtId
{
    self.provinceArray = [NSMutableArray arrayWithContentsOfFile:[UtilString documentsPath:@"city2.plist"]];
    [self.pickerView reloadComponent:0];
    
    if (!provinceId)
    {
        cityId = 4648;
        districtId = 2617;
        provinceId = 19;
        
    }
    
    for (int i = 0; i < self.provinceArray.count; i ++)
    {
        NSDictionary *provinceDic = self.provinceArray[i];
        if ((int)provinceId == [provinceDic[@"provinceId"] intValue])
        {
            [self.pickerView selectRow:i inComponent:0 animated:NO];
            self.cityArray = [provinceDic objectForKey:@"cities"];
            [self.pickerView reloadComponent:1];
            if (!cityId)
            {
                NSDictionary *cityDic = self.cityArray[0];
                self.townArray = [NSArray arrayWithArray:[cityDic objectForKey:@"locationDistricts"]];
                [self.pickerView selectRow:0 inComponent:1 animated:NO];
                [self.pickerView selectRow:0 inComponent:2 animated:NO];
                return;
            }
            else
            {
                for (int j = 0; j < self.cityArray.count; j ++)
                {
                    NSDictionary *cityDic = self.cityArray[j];
                    
                    if ((int)cityId == [cityDic[@"cityId"] intValue])
                    {
                        [self.pickerView selectRow:j inComponent:1 animated:NO];
                        
                        self.townArray = [NSArray arrayWithArray:[cityDic objectForKey:@"locationDistricts"]];
                        [self.pickerView reloadComponent:2];
                        
                        if (!districtId)
                        {
                            [self.pickerView selectRow:0 inComponent:2 animated:NO];
                            return;
                        }
                        else
                        {
                            NSArray *locationDistrictArray = cityDic[@"locationDistricts"];
                            for (int z = 0; z < locationDistrictArray.count; z ++)
                            {
                                NSDictionary *locationDistrictDic = locationDistrictArray[z];
                                if ((int)districtId == [locationDistrictDic[@"locationDistrictId"] intValue])
                                {
                                    [self.pickerView selectRow:z inComponent:2 animated:NO];
                                    return;
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    [self getPickerData2];
}

- (void)reloadAddressDataWithAddress:(NSString *)address
{
    [self getPickerData];
    
    if (address == nil || [address isEqualToString:@""])
    {
        NSDictionary *addressDic = [[NSUserDefaults standardUserDefaults] valueForKey:@"locationAddress"];
        
        if (addressDic)
        {
            address = [NSString stringWithFormat:@"%@ %@ %@",addressDic[@"province"],addressDic[@"city"],addressDic[@"district"]];
            NSLog(@"******%@",address);
        }
        else
        {
            address = @"江苏省 无锡市 滨湖区";
        }
    }
    
    NSArray *array = [address componentsSeparatedByString:@" "];
    
    NSString *province = array[0];
    NSString *city = array[1];
    NSString *locationDistrict = array[2];
    
    
    for (int i = 0; i < self.provinceArray.count; i ++)
    {
        NSDictionary *provinceDic = self.provinceArray[i];
        if ([province isEqualToString:provinceDic[@"provinceName"]])
        {
            [self.pickerView selectRow:i inComponent:0 animated:NO];
            
            self.cityArray = [provinceDic objectForKey:@"cities"];
            
            NSArray *cityArray = provinceDic[@"cities"];
            for (int j = 0; j < cityArray.count; j ++)
            {
                NSDictionary *cityDic = cityArray[j];
                
                if ([city isEqualToString:cityDic[@"cityName"]])
                {
                    [self.pickerView selectRow:j inComponent:1 animated:NO];
                    
                    self.townArray = [NSArray arrayWithArray:[cityDic objectForKey:@"locationDistricts"]];
                    [self.pickerView reloadAllComponents];
                    
                    NSArray *locationDistrictArray = cityDic[@"locationDistricts"];
                    for (int z = 0; z < locationDistrictArray.count; z ++)
                    {
                        NSDictionary *locationDistrictDic = locationDistrictArray[z];
                        NSLog(@"****%@",locationDistrictDic[@"districtName"]);
                        if ([locationDistrict isEqualToString:locationDistrictDic[@"districtName"]])
                        {
                            [self.pickerView selectRow:z inComponent:2 animated:NO];
                            [self.pickerView reloadComponent:2];
                            return;
                        }
                        
                        if (z == locationDistrictArray.count - 1)
                        {
                            [self.pickerView selectRow:0 inComponent:2 animated:NO];
                            [self.pickerView reloadComponent:2];
                            return;
                        }
                    }
                }
                
                if (j == cityArray.count - 1)
                {
                    [self.pickerView selectRow:0 inComponent:1 animated:NO];
                    NSDictionary *cityDic = cityArray[0];
                    self.townArray = [NSArray arrayWithArray:[cityDic objectForKey:@"locationDistricts"]];
                    [self.pickerView selectRow:0 inComponent:2 animated:NO];
                    [self.pickerView reloadAllComponents];
                    return;
                }
            }
        }
        
        if (i == self.provinceArray.count - 1)
        {//未匹配到有效的省
            [self.pickerView selectRow:0 inComponent:0 animated:NO];
            NSDictionary *provinceDic = self.provinceArray[0];
            self.cityArray = [provinceDic objectForKey:@"cities"];
            [self.pickerView selectRow:0 inComponent:1 animated:NO];
            NSDictionary *cityDic = self.cityArray[0];
            self.townArray = [NSArray arrayWithArray:[cityDic objectForKey:@"locationDistricts"]];
            [self.pickerView selectRow:0 inComponent:2 animated:NO];
            [self.pickerView reloadAllComponents];
            return;
        }
    }
}

- (void)hidePickerView
{
    [UIView animateWithDuration:0.3 animations:^{
        
        self.backgroundView.frame = CGRectMake(0, self.frame.size.height, self.frame.size.width, 230);
    } completion:^(BOOL finished) {
        self.hidden = YES;
        [self removeFromSuperview];
    }];
}

#pragma mark -
#pragma mark ================= 网络请求 =================
- (void)requestCityWithProvinceId:(NSInteger)provinceId cityId:(NSInteger)cityId districtId:(NSInteger)districtId
{
    //判断是否已经存在city文件
    NSFileManager* fm=[NSFileManager defaultManager];
    if([fm fileExistsAtPath:[UtilString documentsPath:@"city2.plist"]])
    {
        [self reloadAddressDataWithProvinceId:provinceId cityId:cityId districtId:districtId];
        [UIView animateWithDuration:0.3 animations:^{
            self.backgroundView.frame = CGRectMake(0, self.frame.size.height-230, self.frame.size.width, 230);
        }];
        return;
    }
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [CBConnect getUsercenterLocationListForTree:params success:^(id responseObject) {
        NSDictionary *townDic = @{@"districtName":@"不限",@"locationDistrictId":@(0)};
        NSArray *townArray = @[townDic];
        NSDictionary *cityDic = @{@"cityName":@"不限",@"cityId":@(0),@"locationDistricts":townArray};
        NSArray *citysArray = @[cityDic];
        NSDictionary *provinceDic = @{@"provinceName":@"不限",@"provinceId":@(0),@"cities":citysArray};
        
        NSArray *responseObjectArray = [NSArray arrayWithArray:responseObject];
        NSMutableArray *provinceArray = [NSMutableArray array];
        for (int i = 0; i < responseObjectArray.count; i ++)
        {
            NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:responseObjectArray[i]];
            
            NSMutableArray *array = [NSMutableArray arrayWithArray:dic[@"cities"]];
            NSMutableArray *citysArray = [NSMutableArray array];
            for (int j = 0; j < array.count; j ++)
            {
                NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:array[j]];
                NSMutableArray *array = [NSMutableArray arrayWithArray:dic[@"locationDistricts"]];
                [array insertObject:townDic atIndex:0];
                [dic setValue:array forKey:@"locationDistricts"];
                [citysArray addObject:dic];
            }
            
            [citysArray insertObject:cityDic atIndex:0];
            [dic setValue:citysArray forKey:@"cities"];
            [provinceArray addObject:dic];
        }
        [provinceArray insertObject:provinceDic atIndex:0];
        
        [provinceArray writeToFile:[UtilString documentsPath:@"city2.plist"] atomically:YES];
        
        [self reloadAddressDataWithProvinceId:provinceId cityId:cityId districtId:districtId];
        
        [UIView animateWithDuration:0.3 animations:^{
            self.backgroundView.frame = CGRectMake(0, self.frame.size.height-230, self.frame.size.width, 230);
        }];

        
    } successBackfailError:^(id responseObject) {
        [self removeFromSuperview];
        [LCProgressHUD showFailure:@"地址加载失败"];
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        [self removeFromSuperview];
        [LCProgressHUD showFailure:@"地址加载失败"];
    }];

    
    
//    [[LQHTTPSessionManager sharedManager] LQPost:@"location/listLocationForTree" parameters:nil showTips:@"正在加载地址..." success:^(id responseObject) {
//        
//        NSDictionary *townDic = @{@"districtName":@"不限",@"locationDistrictId":@(0)};
//        NSArray *townArray = @[townDic];
//        NSDictionary *cityDic = @{@"cityName":@"不限",@"cityId":@(0),@"locationDistricts":townArray};
//        NSArray *citysArray = @[cityDic];
//        NSDictionary *provinceDic = @{@"provinceName":@"不限",@"provinceId":@(0),@"cities":citysArray};
//        
//        NSArray *responseObjectArray = [NSArray arrayWithArray:responseObject];
//        NSMutableArray *provinceArray = [NSMutableArray array];
//        for (int i = 0; i < responseObjectArray.count; i ++)
//        {
//            NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:responseObjectArray[i]];
//            
//            NSMutableArray *array = [NSMutableArray arrayWithArray:dic[@"cities"]];
//            NSMutableArray *citysArray = [NSMutableArray array];
//            for (int j = 0; j < array.count; j ++)
//            {
//                NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:array[j]];
//                NSMutableArray *array = [NSMutableArray arrayWithArray:dic[@"locationDistricts"]];
//                [array insertObject:townDic atIndex:0];
//                [dic setValue:array forKey:@"locationDistricts"];
//                [citysArray addObject:dic];
//            }
//            
//            [citysArray insertObject:cityDic atIndex:0];
//            [dic setValue:citysArray forKey:@"cities"];
//            [provinceArray addObject:dic];
//        }
//        [provinceArray insertObject:provinceDic atIndex:0];
//        
//        [provinceArray writeToFile:[UtilString documentsPath:@"city2.plist"] atomically:YES];
//        
//        [self reloadAddressDataWithProvinceId:provinceId cityId:cityId districtId:districtId];
//        
//        [UIView animateWithDuration:0.3 animations:^{
//            self.backgroundView.frame = CGRectMake(0, self.frame.size.height-230, self.frame.size.width, 230);
//        }];
//    } successBackfailError:^(id responseObject) {
//        [self removeFromSuperview];
//        [LCProgressHUD showFailure:@"地址加载失败"];
//    } failure:^(NSError *error) {
//        [self removeFromSuperview];
//        [LCProgressHUD showFailure:@"地址加载失败"];
//    }];
}

//获取城市信息
- (void)requestCityWithAddress:(NSString *)address
{
    //判断是否已经存在city文件
    NSFileManager* fm=[NSFileManager defaultManager];
    if([fm fileExistsAtPath:[UtilString documentsPath:@"city.plist"]])
    {
        [self reloadAddressDataWithAddress:address];
        [UIView animateWithDuration:0.3 animations:^{
            self.backgroundView.frame = CGRectMake(0, self.frame.size.height-230, self.frame.size.width,230);
        }];
        return;
    }
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    
    [CBConnect getUsercenterLocationListForTree:params success:^(id responseObject) {
        [responseObject writeToFile:[UtilString documentsPath:@"city.plist"] atomically:YES];
        
        [self reloadAddressDataWithAddress:address];
        
        [UIView animateWithDuration:0.3 animations:^{
            self.backgroundView.frame = CGRectMake(0, self.frame.size.height-230, self.frame.size.width, 230);
        }];

    } successBackfailError:^(id responseObject) {
        [self removeFromSuperview];
        [LCProgressHUD showFailure:@"地址加载失败"];
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        [self removeFromSuperview];
        [LCProgressHUD showFailure:@"地址加载失败"];
    }];
    
//    [[LQHTTPSessionManager sharedManager] LQPost:@"location/listLocationForTree" parameters:nil showTips:@"正在加载地址..." success:^(id responseObject) {
//        [responseObject writeToFile:[UtilString documentsPath:@"city.plist"] atomically:YES];
//        
//        [self reloadAddressDataWithAddress:address];
//        
//        [UIView animateWithDuration:0.3 animations:^{
//            self.backgroundView.frame = CGRectMake(0, self.frame.size.height-230, self.frame.size.width, 230);
//        }];
//    } successBackfailError:^(id responseObject) {
//        [self removeFromSuperview];
//        [LCProgressHUD showFailure:@"地址加载失败"];
//    } failure:^(NSError *error) {
//        [self removeFromSuperview];
//        [LCProgressHUD showFailure:@"地址加载失败"];
//    }];
}

#pragma mark - get data
- (void)getPickerData
{
    self.provinceArray = [NSMutableArray arrayWithContentsOfFile:[UtilString documentsPath:@"city.plist"]];
    
    self.selectDic = [self.provinceArray objectAtIndex:0];
    self.cityArray = [self.selectDic objectForKey:@"cities"];
    
    NSDictionary *townDic = [self.cityArray objectAtIndex:0];
    self.townArray = [townDic objectForKey:@"locationDistricts"];
    
    [self.pickerView reloadAllComponents];
    
}
- (void)getPickerData2
{
    self.provinceArray = [NSMutableArray arrayWithContentsOfFile:[UtilString documentsPath:@"city2.plist"]];
    
    self.selectDic = [self.provinceArray objectAtIndex:0];
    self.cityArray = [self.selectDic objectForKey:@"cities"];
    
    NSDictionary *townDic = [self.cityArray objectAtIndex:0];
    self.townArray = [townDic objectForKey:@"locationDistricts"];
    
    [self.pickerView reloadAllComponents];
    
}

#pragma mark - UIPicker Delegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (component == 0) {
        return self.provinceArray.count;
    } else if (component == 1) {
        return self.cityArray.count;
    } else {
        return self.townArray.count;
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (component == 0) {
        return [self.provinceArray objectAtIndex:row][@"provinceName"];
    } else if (component == 1) {
        return [self.cityArray objectAtIndex:row][@"cityName"];
    } else {
        return [self.townArray objectAtIndex:row][@"districtName"];
    }
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    if (component == 0) {
        return 110;
    } else if (component == 1) {
        return 100;
    } else {
        return 110;
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (component == 0)
    {
        self.selectDic = [self.provinceArray objectAtIndex:row];
        self.cityArray = [NSArray arrayWithArray:[self.selectDic objectForKey:@"cities"]];
        
        NSDictionary *townDic = [self.cityArray objectAtIndex:0];
        self.townArray = [NSArray arrayWithArray:[townDic objectForKey:@"locationDistricts"]];
        
        [pickerView reloadComponent:1];
        [pickerView reloadComponent:2];
        [pickerView selectRow:0 inComponent:1 animated:YES];
        [pickerView selectRow:0 inComponent:2 animated:YES];
    }
    
    if (component == 1)
    {
        self.townArray = [NSArray arrayWithArray:[[self.cityArray objectAtIndex:row] objectForKey:@"locationDistricts"]];
        [pickerView reloadComponent:2];
        [pickerView selectRow:0 inComponent:2 animated:YES];
    }
    
}

- (void)ensure
{
    NSDictionary *province = [self.provinceArray objectAtIndex:[self.pickerView selectedRowInComponent:0]];
    NSDictionary *city = [self.cityArray objectAtIndex:[self.pickerView selectedRowInComponent:1]];
    NSDictionary *town = [self.townArray objectAtIndex:[self.pickerView selectedRowInComponent:2]];
    
    NSInteger provinceId = [province[@"provinceId"] integerValue];
    NSInteger cityId = [city[@"cityId"] integerValue];
    NSInteger locationDistrictId = [town[@"locationDistrictId"] integerValue];
    
    NSString *provinceName = provinceId?province[@"provinceName"]:@"";
    NSString *cityName = cityId?city[@"cityName"]:@"";
    NSString *districtName = locationDistrictId?town[@"districtName"]:@"";
    
    NSString *address = [NSString stringWithFormat:@"%@ %@ %@",provinceName,cityName,districtName];
    
    if ([self.delegate respondsToSelector:@selector(ensureWithAddress:provinceId:cityId:locationDistrictId:)]) {
        [self.delegate ensureWithAddress:address provinceId:provinceId cityId:cityId locationDistrictId:locationDistrictId];
    }else if ([self.delegate respondsToSelector:@selector(ensureWithAddress:provinceId:provinceName:cityId:cityName:locationDistrictId:locationDistrictName:)]){
        [self.delegate ensureWithAddress:address provinceId:provinceId provinceName:provinceName cityId:cityId cityName:cityName locationDistrictId:locationDistrictId locationDistrictName:districtName];
    }
    
    [self hidePickerView];
}


@end
