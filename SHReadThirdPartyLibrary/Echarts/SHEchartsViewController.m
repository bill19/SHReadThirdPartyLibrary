//
//  SHEchartsViewController.m
//  SHReadThirdPartyLibrary
//
//  Created by HaoSun on 2018/3/26.
//  Copyright © 2018年 SHKIT. All rights reserved.
//

#import "SHEchartsViewController.h"
#import "iOS-Echarts.h"
#import "PYOption.h"
static NSString *kBordColor = @"#F5F5F5";
static NSString *kAxisBordColor = @"#F5F5F5";
static NSInteger kSplitNumber = 6.0f;
static CGFloat kFormHeight = 180.0f;
#define  ScreenWidth [UIScreen mainScreen].bounds.size.width
@interface SHEchartsViewController ()

@end

@implementation SHEchartsViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    WKEchartsView *wkView = [[WKEchartsView alloc] initWithFrame:CGRectMake(-50, 100, [UIScreen mainScreen].bounds.size.width + 100,300)];
    [wkView setOption:[self setupXOption]];
    [self.view addSubview:wkView];
    [wkView loadEcharts];
}

- (PYOption *)setupXOption {
    PYOption *option = [[PYOption alloc] init];
    //tooltip
    option.tooltip.trigger = PYTooltipTriggerAxis;
    option.tooltip.axisPointer.type = @"cross";
    option.tooltip.axisPointer.crossStyle.color = @"#999";
    //toolbox
    option.toolbox.feature.dataView.show = YES;
    option.toolbox.feature.dataView.readOnly = NO;
    option.toolbox.feature.magicType.show = YES;
    option.toolbox.feature.magicType.type = @[@"line",@"bar"];
    option.toolbox.feature.restore.show = YES;
    option.toolbox.feature.saveAsImage.show = YES;
    //legend
    option.legend.data = @[@"业绩",@"单量"];
    //xAxis
    PYAxis *xaxis = [[PYAxis alloc] init];
    xaxis.type = PYAxisTypeCategory;
    xaxis.data = [[NSMutableArray alloc] initWithArray:@[@"京东事业部",@"京西事业部",@"京东北事业部"]];
    option.xAxis = [[NSMutableArray alloc] initWithArray:@[xaxis]];
    //yAxis
    PYAxis *yaxisLeft = [[PYAxis alloc] init];
    yaxisLeft.type = PYAxisTypeValue;
    yaxisLeft.name = @"业绩";
    yaxisLeft.min = @0;
    yaxisLeft.max = @250;
    yaxisLeft.zlevel = @50;
    yaxisLeft.axisLabel.formatter = @"{value}";

    PYAxis *yaxisRight = [[PYAxis alloc] init];
    yaxisRight.type = PYAxisTypeValue;
    yaxisRight.name = @"单量";
    yaxisRight.min = @0;
    yaxisRight.max = @25;
    yaxisRight.zlevel = @5;
    yaxisRight.axisLabel.formatter = @"{value}";

    option.yAxis = [[NSMutableArray alloc] initWithArray:@[yaxisLeft,yaxisRight]];
    //series
    PYSeries *series1 = [[PYSeries alloc] init];
    series1.name = @"业绩";
    series1.type = PYSeriesTypeBar;
    series1.data = @[@190,@205,@180];
    series1.tooltip.borderWidth = @10;

    PYCartesianSeries *series2 = [[PYCartesianSeries alloc] init];
    series2.name = @"单量";
    series2.yAxisIndex = @1;
    series2.type = PYSeriesTypeLine;
    series2.data = @[@11,@22,@18];

    option.series = [[NSMutableArray alloc] initWithArray:@[series1,series2]];
    return option;
}

- (PYOption *)setOption1 {

    PYOption *option = [[PYOption alloc] init];
    //tooltip
    option.tooltip.trigger = PYTooltipTriggerAxis;
    option.tooltip.axisPointer.type = @"cross";
    option.tooltip.axisPointer.crossStyle.color = @"#FFFFFF";
    //color
    PYColor *color1 = [PYColor colorWithHexString:@"#FAC70A"];
    PYColor *color2 = [PYColor colorWithHexString:@"#407A13"];
    option.color = [[NSMutableArray alloc] initWithArray:@[color1,color2]];

    //toolbox
    option.toolbox.feature.dataView.show = YES;
    option.toolbox.feature.dataView.readOnly = NO;
    option.toolbox.feature.magicType.show = YES;
    option.toolbox.feature.magicType.type = @[@"bar"];
    option.toolbox.feature.restore.show = YES;
    option.toolbox.feature.saveAsImage.show = YES;

    //grid
    PYGrid *grid = [[PYGrid alloc] init];
    grid.borderWidth = @.5;
    grid.borderColor = [PYColor colorWithHexString:kBordColor];
    CGFloat padding = 38.0f;
    CGFloat padding2 = 15.0f;
    grid.x = @(padding);
    grid.y = @(padding2);
    grid.width = @(ScreenWidth - padding * 2);
    grid.height = @(kFormHeight - padding - padding2);
    option.grid = grid;
    //PYAxisLine
    PYAxisLine *axisLine = [[PYAxisLine alloc] init];
    axisLine.lineStyle.color = kAxisBordColor;
    axisLine.lineStyle.width = @.5;
    //splitLine
    PYAxisSplitLine *axisSplitLine = [[PYAxisSplitLine alloc] init];
    axisSplitLine.onGap = NO;
    axisSplitLine.lineStyle.color = kBordColor;
    axisSplitLine.lineStyle.width = @.5;

    //PYTextStyle
    PYTextStyle *textStyle = [[PYTextStyle alloc] init];
    textStyle.fontSize = @8;
    textStyle.color = @"#333333";
    //xAxis
    PYAxis *xaxis = [[PYAxis alloc] init];
    xaxis.axisLine = axisLine;
    xaxis.splitLine = axisSplitLine;
    PYAxisTick *xAsisTick = [[PYAxisTick alloc] init];
    xAsisTick.show = NO;
    xaxis.axisTick = xAsisTick;
    xaxis.type = PYAxisTypeCategory;
    xaxis.data =  @[@"第一块",@"第2块",@"第3块"].mutableCopy;
    option.xAxis = [[NSMutableArray alloc] initWithArray:@[xaxis]];
    //yAxis
    PYAxis *yaxisLeft = [[PYAxis alloc] init];
    yaxisLeft.axisLine = axisLine;
    yaxisLeft.splitLine = axisSplitLine;
    yaxisLeft.type = PYAxisTypeValue;
    yaxisLeft.name = @"(金额:万元)";
    yaxisLeft.nameTextStyle = textStyle;
    yaxisLeft.nameLocation = @"start";
    yaxisLeft.min = @0;
    yaxisLeft.max = @(200);
    yaxisLeft.splitNumber = @(kSplitNumber);
    yaxisLeft.axisLabel.formatter = @"{value}";
    option.yAxis = [[NSMutableArray alloc] initWithArray:@[yaxisLeft]];
    //series
    PYCartesianSeries *series1 = [[PYCartesianSeries alloc] init];
    series1.name = @"金额（万元）";
    series1.type = PYSeriesTypeBar;
    series1.barWidth = @20;
    series1.data = @[@11,@123,@233];;

    PYItemStyle *itemStyle = [[PYItemStyle alloc] init];
    itemStyle.normal.label.show = YES;
    itemStyle.normal.label.position = @"inside";
    itemStyle.normal.label.textStyle = textStyle;
    series1.itemStyle = itemStyle;
    option.series = [[NSMutableArray alloc] initWithArray:@[series1]];
    return option;
}


- (PYOption *)setOption2 {

    PYOption *option = [[PYOption alloc] init];
    //tooltip
    option.tooltip.trigger = PYTooltipTriggerAxis;
    option.tooltip.axisPointer.type = @"cross";
    option.tooltip.axisPointer.crossStyle.color = @"#FFFFFF";

    //color
    PYColor *color1 = [PYColor colorWithHexString:@"#FAC70A"];
    PYColor *color2 = [PYColor colorWithHexString:@"#407A13"];
    option.color = [[NSMutableArray alloc] initWithArray:@[color1,color2]];

    //toolbox
    option.toolbox.feature.dataView.show = YES;
    option.toolbox.feature.dataView.readOnly = NO;
    option.toolbox.feature.magicType.show = YES;
    option.toolbox.feature.magicType.type = @[@"line",@"bar"];
    option.toolbox.feature.restore.show = YES;
    option.toolbox.feature.saveAsImage.show = YES;
    //legend
    option.legend.data = @[@"业绩",@"单量"];

    //grid
    PYGrid *grid = [[PYGrid alloc] init];
    grid.borderWidth = @.5;
    grid.borderColor = [PYColor colorWithHexString:kBordColor];
    CGFloat padding = 38.0f;
    CGFloat padding2 = 15.0f;
    grid.x = @(padding);
    grid.y = @(padding2);
    grid.width = @(ScreenWidth - padding * 2);
    grid.height = @(kFormHeight - padding - padding2);
    option.grid = grid;
    //PYAxisLine
    PYAxisLine *axisLine = [[PYAxisLine alloc] init];
    axisLine.lineStyle.color = kAxisBordColor;
    axisLine.lineStyle.width = @.5;
    //splitLine
    PYAxisSplitLine *axisSplitLine = [[PYAxisSplitLine alloc] init];
    axisSplitLine.onGap = NO;
    axisSplitLine.lineStyle.color = kBordColor;
    axisSplitLine.lineStyle.width = @.5;

    //PYTextStyle
    PYTextStyle *textStyle = [[PYTextStyle alloc] init];
    textStyle.fontSize = @8;
    textStyle.color = @"#333333";
    //xAxis
    PYAxis *xaxis = [[PYAxis alloc] init];
    xaxis.axisLine = axisLine;
    xaxis.splitLine = axisSplitLine;
    xaxis.type = PYAxisTypeCategory;
    PYAxisTick *xAsisTick = [[PYAxisTick alloc] init];
    xAsisTick.show = NO;
    xaxis.axisTick = xAsisTick;
    xaxis.data = @[@"第一块",@"第2块",@"第3块"].mutableCopy;
    option.xAxis = [[NSMutableArray alloc] initWithArray:@[xaxis]];
    //yAxis
    PYAxis *yaxisLeft = [[PYAxis alloc] init];
    yaxisLeft.axisLine = axisLine;
    yaxisLeft.splitLine = axisSplitLine;
    yaxisLeft.type = PYAxisTypeValue;
    yaxisLeft.name = @"(金额:万元)";
    yaxisLeft.nameTextStyle = textStyle;
    yaxisLeft.nameLocation = @"start";
    yaxisLeft.min = @0;
    yaxisLeft.max = @(2000);
    yaxisLeft.splitNumber = @(kSplitNumber);
    yaxisLeft.axisLabel.formatter = @"{value}";

    PYAxis *yaxisRight = [[PYAxis alloc] init];
    yaxisRight.axisLine = axisLine;
    yaxisRight.splitLine = axisSplitLine;
    yaxisRight.type = PYAxisTypeValue;
    yaxisRight.name = @"(单量)";
    yaxisRight.nameTextStyle = textStyle;
    yaxisRight.nameLocation = @"start";
    yaxisRight.min = @0;
    yaxisRight.max = @(200);
    yaxisRight.splitNumber = @(kSplitNumber);
    yaxisRight.axisLabel.formatter = @"{value}";

    option.yAxis = [[NSMutableArray alloc] initWithArray:@[yaxisLeft,yaxisRight]];
    //series
    PYCartesianSeries *series1 = [[PYCartesianSeries alloc] init];
    series1.name = @"金额（万元）";
    series1.type = PYSeriesTypeBar;
    series1.data = @[@11,@123,@233];
    series1.barWidth = @30;

    PYCartesianSeries *series2 = [[PYCartesianSeries alloc] init];
    series2.name = @"(单量)";
    series2.yAxisIndex = @1;
    series2.type = PYSeriesTypeLine;
    series2.data = @[@11,@123,@233];

    PYItemStyle *itemStyle = [[PYItemStyle alloc] init];
    itemStyle.normal.label.show = YES;
    itemStyle.normal.label.position = @"top";
    itemStyle.normal.label.textStyle = textStyle;
    series1.itemStyle = itemStyle;
    series2.itemStyle = itemStyle;

    option.series = [[NSMutableArray alloc] initWithArray:@[series1,series2]];

    return option;
}

@end
