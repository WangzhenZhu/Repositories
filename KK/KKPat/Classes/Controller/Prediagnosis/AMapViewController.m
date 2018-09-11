//
//  AMapViewController.m
//  KKPat
//
//  Created by Wang on 19/08/2018.
//  Copyright © 2018 Wang. All rights reserved.
//

#import "AMapViewController.h"
#import "KKConfiguration.h"

@interface AMapViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,MAMapViewDelegate,AMapSearchDelegate>

@property (nonatomic, assign) BOOL isStatusBarContentBlack;
@property (nonatomic, strong) UIButton *navLeftButton;
@property (nonatomic, strong) UIButton *navRightButton;
@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, assign) CGFloat mapHeight;
@property (nonatomic, strong) UIView *mapView;
@property (nonatomic, strong) MAMapView *map;
@property (nonatomic, strong) UIImageView *pin;
@property (nonatomic, strong) UIButton *appearlocationBtn;
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, assign) CGRect tableViewFrame;
@property (nonatomic, strong) AMapSearchAPI *search;
@property (nonatomic, strong) NSMutableArray *pois;
@property (nonatomic, strong) AMapPOI *selectedPOI;
@property (nonatomic, strong) AMapGeoPoint *userGeoPoint;
@property (nonatomic, strong) AMapAddressComponent *addressComponet;
@end

@implementation AMapViewController


- (void)initDataSource
{
    _mapHeight = (ScreenHeight - [UIApplication sharedApplication].statusBarFrame.size.height - 44 - CGRectGetHeight(self.searchBar.frame)) / 2.0;
    NSLog(@"mmmm%f",_mapHeight);
    self.pois = [NSMutableArray array];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initDataSource];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupUI];
    // Do any additional setup after loading the view.
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    if(self.isStatusBarContentBlack)
    {
        return UIStatusBarStyleDefault;
    }
    return UIStatusBarStyleLightContent;
}

- (void)setupUI
{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.navLeftButton];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.navRightButton];
    [self.view addSubview:self.searchBar];
    [self.mapView addSubview:self.map];
    [self.mapView addSubview:self.pin];
    [self.mapView addSubview:self.appearlocationBtn];
    [self.view addSubview:self.mapView];
    _map.userTrackingMode = MAUserTrackingModeFollow;
    _map.showsUserLocation = YES;
    [self.view addSubview:self.tableView];
}

#pragma mark -- Nav //搜索中取消同样是这个事件
- (void)navLeftBarButtonEvent:(UIButton *)button
{
    if (CGRectEqualToRect(self.tableViewFrame, CGRectZero)) {
        if (self.navigationController.viewControllers.count <= 1) {
            [self dismissViewControllerAnimated:YES completion:nil];
        }else{
            [self.navigationController popViewControllerAnimated:YES];
        }
    }else
    {
        [self.searchBar resignFirstResponder];
        self.tableView.frame = self.tableViewFrame;
        self.tableViewFrame = CGRectZero;
        self.map.delegate = self;
    }
}
- (void)NavRightBarButtonEvent:(UIButton *)button
{
    if (self.selectedPOI && self.BackSlect ) {
        self.BackSlect(CLLocationCoordinate2DMake(self.selectedPOI.location.latitude, self.selectedPOI.location.longitude), self.selectedPOI.name);
    }
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)displayCurrentLocation
{
    NSLog(@"%f,;;;%f",self.userGeoPoint.latitude,self.userGeoPoint.longitude);
    CLLocationCoordinate2D location = CLLocationCoordinate2DMake(self.userGeoPoint.latitude, self.userGeoPoint.longitude);
    [self.map setCenterCoordinate:location animated:YES];
    [self pinAnimation];
}
//- (void)pinAnimation
//{
//    [UIView animateWithDuration:0.3 animations:^{
//        UIImage *image = IMG(@"location_icon_pin");
//        self.pin.center =  CGPointMake(ScreenWidth / 2.0, self.mapHeight / 2.0 - image.size.height);
//    } completion:^(BOOL finished) {
//        [UIView animateWithDuration:0.2 animations:^{
//            UIImage *image = IMG(@"location_icon_pin");
//            self.pin.center = CGPointMake(ScreenWidth / 2.0,  self.mapHeight / 2.0 - image.size.height / 2.0);
//        }];
//    }];
//}
- (void)pinAnimation {
    [UIView animateWithDuration:0.3 animations:^{
        UIImage *image = [UIImage imageNamed:@"location_icon_pin"];
        self.pin.center = CGPointMake(UIScreen.mainScreen.bounds.size.width / 2.0, self.mapHeight / 2.0 - image.size.height);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.2 animations:^{
            UIImage *image = [UIImage imageNamed:@"location_icon_pin"];
            self.pin.center = CGPointMake(UIScreen.mainScreen.bounds.size.width / 2.0, self.mapHeight / 2.0 - image.size.height / 2.0);
        }];
    }];
}

#pragma mark -- TableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.pois.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Cell"];
    }
    cell.textLabel.font = [UIFont systemFontOfSize:16];
    cell.detailTextLabel.font = [UIFont systemFontOfSize:12];
    cell.detailTextLabel.textColor = UIColor.lightGrayColor;
    if (self.pois.count > 0) {
        AMapPOI *poi = self.pois[indexPath.row];
        cell.textLabel.text = poi.name;
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%@%@%@%@", poi.province, poi.city, poi.district, poi.address];
        if ([poi.uid isEqualToString:self.selectedPOI.uid]) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }else
        {
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryCheckmark;
    AMapPOI *poi = self.pois[indexPath.row];
    self.selectedPOI = poi;
    if (CGRectEqualToRect(self.tableViewFrame, CGRectZero)) {
        self.map.delegate = nil;
        [self.map setCenterCoordinate:CLLocationCoordinate2DMake(poi.location.latitude, poi.location.longitude) animated:YES];
        [self pinAnimation];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.map.delegate = self;
        });
    } else
    {
        if (self.selectedPOI && self.BackSlect) {
            self.BackSlect(CLLocationCoordinate2DMake(self.selectedPOI.location.latitude, self.selectedPOI.location.longitude),self.selectedPOI.name);
        }
        [self.navigationController popViewControllerAnimated:YES];
    }
    [tableView reloadData];
}
#pragma mark -- UISearchDelegate
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    if (CGRectEqualToRect(self.tableViewFrame, CGRectZero)) {
        self.tableViewFrame = self.tableView.frame;
    }
    [self changeUIDisplay];
    self.map.delegate = nil;
    return YES;
}
- (void)changeUIDisplay
{
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    self.searchBar.frame = CGRectMake(0, CGRectGetMaxY([UIApplication sharedApplication].statusBarFrame), ScreenWidth, CGRectGetHeight(self.searchBar.frame));
    [self.searchBar setShowsCancelButton:YES animated:YES];
    self.isStatusBarContentBlack = YES;
    [self setNeedsStatusBarAppearanceUpdate];
    self.tableView.frame = CGRectMake(0, CGRectGetMaxY(self.searchBar.frame), ScreenWidth, self.mapHeight*2.0 + 44);
}
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    UIButton *cancelBtn = [searchBar valueForKey:@"cancelButton"];
    if (searchText.length == 0) {
        [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        AMapPOIKeywordsSearchRequest *request = [[AMapPOIKeywordsSearchRequest alloc] init];
        NSLog(@"%f--1111---%f",self.userGeoPoint.latitude,self.userGeoPoint.longitude);
        request.location = self.userGeoPoint;
        [self.search AMapPOIKeywordsSearch:request];
    }else
    {
        [cancelBtn setTitle:@"搜索" forState:UIControlStateNormal];
         [self searchBarSearchButtonClicked:searchBar];
    
    }
}
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    UIButton *cancelBtn = [searchBar valueForKey:@"cancelButton"];
    if ([cancelBtn.titleLabel.text isEqualToString:@"取消"]) {
        self.searchBar.frame = CGRectMake(0, 64, UIScreen.mainScreen.bounds.size.width, CGRectGetHeight(self.searchBar.frame));
        [self.navigationController setNavigationBarHidden:NO animated:YES];
        [self.searchBar setShowsCancelButton:NO animated:YES];
        self.isStatusBarContentBlack = NO;
        [self setNeedsStatusBarAppearanceUpdate];
        [self navLeftBarButtonEvent:self.navLeftButton];
    } else
    {
         [self searchBarSearchButtonClicked:searchBar];
    }
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    AMapPOIKeywordsSearchRequest *request = [[AMapPOIKeywordsSearchRequest alloc] init];
    request.keywords = searchBar.text;
    [self.search AMapPOIKeywordsSearch:request];
}

#pragma mark --MaMapViewDelegate
//地图区域改变 调用
- (void)mapView:(MAMapView *)mapView regionDidChangeAnimated:(BOOL)animated
{
    AMapReGeocodeSearchRequest *reGeoRequest = [[AMapReGeocodeSearchRequest alloc] init];
    reGeoRequest.location = [AMapGeoPoint locationWithLatitude:mapView.region.center.latitude longitude:mapView.region.center.longitude];
    reGeoRequest.requireExtension = YES;
    [self.search AMapReGoecodeSearch:reGeoRequest];
    if (!self.userGeoPoint) {
        self.userGeoPoint = reGeoRequest.location;
    }
}
//地图移动后调用
- (void)mapView:(MAMapView *)mapView mapDidMoveByUser:(BOOL)wasUserAction
{
    [self pinAnimation];
}
#pragma mark --AMapSearchDelegate
- (void)onReGeocodeSearchDone:(AMapReGeocodeSearchRequest *)request response:(AMapReGeocodeSearchResponse *)response
{
    if (response) {
        [self.pois removeAllObjects];
        AMapAddressComponent *addressComponet = response.regeocode.addressComponent;
        for (AMapPOI *poi in response.regeocode.pois) {
            poi.province = addressComponet.province;
            poi.city = addressComponet.city;
            poi.district = addressComponet.district;
            [self.pois addObject:poi];
        }
        [self.tableView reloadData];
    }
}
- (void)onPOISearchDone:(AMapPOISearchBaseRequest *)request response:(AMapPOISearchResponse *)response
{
    self.addressComponet = nil;
    [self.pois removeAllObjects];
    for (AMapPOI *poi in response.pois) {
        [self.pois addObject:poi];
    }
    [self.tableView reloadData];
}
- (void)AMapSearchRequest:(id)request didFailWithError:(NSError *)error
{
    NSLog(@"输出错误");
}


- (UIButton *)navLeftButton
{
    if (!_navLeftButton) {
        _navLeftButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _navLeftButton.frame = CGRectMake(0, 0, 64, 44);
        _navLeftButton.titleLabel.font = [UIFont systemFontOfSize:16];
        _navLeftButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [_navLeftButton setTitleColor:UIColor.lightGrayColor forState:(UIControlStateHighlighted)];
        [_navLeftButton setImage:[UIImage imageNamed:@"back1_btn"] forState:(UIControlStateNormal)];
        [_navLeftButton setTitleColor:UIColor.lightGrayColor forState:(UIControlStateHighlighted)];
        [_navLeftButton addTarget:self action:@selector(navLeftBarButtonEvent:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _navLeftButton;
}

- (UIButton *)navRightButton
{
    if (!_navRightButton) {
        _navRightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _navRightButton.frame = CGRectMake(0, 0, 64, 44);
        [_navRightButton setTitle:@"确定" forState:(UIControlStateNormal)];
        _navRightButton.titleLabel.font = [UIFont systemFontOfSize:16];
        _navRightButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [_navRightButton setTitleColor:UIColor.lightGrayColor forState:(UIControlStateHighlighted)];
        [_navRightButton addTarget:self action:@selector(NavRightBarButtonEvent:) forControlEvents: UIControlEventTouchUpInside];
    }
    return _navRightButton;
}

- (UISearchBar *)searchBar
{
    if (!_searchBar) {
        _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, 56)];
        _searchBar.backgroundImage  = [AMapViewController imageWithColor:RGB(240, 239, 245)];
        UITextView *searchField = [_searchBar valueForKey:@"searchField"];
        if (searchField) {
            for (UIView *subView in searchField.subviews) {
                if ([subView isKindOfClass:NSClassFromString(@"_UISearchBarSearchFieldBackgroundView")]) {
                    subView.layer.cornerRadius = 4.0f;
                    subView.layer.masksToBounds = YES;
                    subView.backgroundColor = UIColor.whiteColor;
                }
            }
        }
        _searchBar.placeholder = @"搜索地点";
        _searchBar.delegate = self;
    }
    return _searchBar;
}

- (UIView *)mapView
{
    if (!_mapView) {
        NSLog(@"kkk--%f", self.mapHeight);
        _mapView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.searchBar.frame), ScreenWidth, self.mapHeight)];
        
    }
    return _mapView;
}

- (MAMapView *)map
{
    if (!_map) {
        _map = [[MAMapView alloc] initWithFrame:self.mapView.bounds];
        _map.rotateEnabled = NO;
        _map.delegate = self;
        _map.zoomLevel = 12;

    }
    return _map;
}

- (UIImageView *)pin
{
    if (!_pin) {
        UIImage *image = IMG(@"location_icon_pin");
        _pin = [[UIImageView alloc] initWithImage:image];
        _pin.center = CGPointMake(ScreenWidth / 2, self.mapHeight / 2.0 - image.size.height / 2.0);
    }
    return _pin;
}

- (UIButton *)appearlocationBtn
{
    if (!_appearlocationBtn) {
        UIImage *image = IMG(@"location_my_current");
        _appearlocationBtn = [[UIButton alloc] initWithFrame:CGRectMake(ScreenWidth-image.size.width-5,
                                                                        self.mapHeight-image.size.height-10,
                                                                        image.size.width, image.size.height)];
        [_appearlocationBtn setImage:image forState:UIControlStateNormal];
        [_appearlocationBtn addTarget:self action:@selector(displayCurrentLocation) forControlEvents:UIControlEventTouchUpInside];
    }
    return _appearlocationBtn;
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.mapView.frame), ScreenWidth, self.mapHeight) style:UITableViewStylePlain];
        _tableView.delegate  = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
        _tableView.backgroundColor = RGB(245, 245, 245);
        _tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    }
    return _tableView;
}
- (AMapSearchAPI *)search
{
    if (!_search) {
        _search = [[AMapSearchAPI alloc] init];
        _search.delegate = self;
    }
    return _search;
}


+ (UIImage *)imageWithColor:(UIColor *)color
{
    return [self imageWithColor:color size:CGSizeMake(1, 1)];
}
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size
{
    if (!color || size.width <= 0 || size.height <= 0) return nil;
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    //开启上下文
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    //获取上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
