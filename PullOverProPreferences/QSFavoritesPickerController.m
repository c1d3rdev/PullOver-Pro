//
//  HBPFavoritesExtensionSettingsController.m
//  HomeButtonPlus
//
//  Created by Will Smillie on 11/12/18.
//

#import "QSFavoritesPickerController.h"

#define kPrefs_Path @"/var/mobile/Library/Preferences/com.c1d3r.PullOverPro.plist"
#define kPrefs_KeyName_Key @"key"
#define kPrefs_KeyName_Defaults @"defaults"

@interface SBApplication : NSObject

@end


@interface QSFavoritesPickerController (){
    NSMutableDictionary *settings;
    ALApplicationList *applications;
    NSMutableArray *enabledApps;
    NSMutableArray *disabledApps;
}

@end

@implementation QSFavoritesPickerController
@synthesize allApps;

-(instancetype)init{
    self = [super initWithStyle:UITableViewStyleGrouped];
    return self;
}
-(instancetype)initWithStyle:(UITableViewStyle)style{
    self = [super initWithStyle:UITableViewStyleGrouped];
    return self;
}
-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithStyle:UITableViewStyleGrouped];
    return self;
}

-(void)viewDidLoad{
    [super viewDidLoad];
    
    self.title = @"QuickSwitch Favorites";
    
    [self.tableView setEditing:YES];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.allowsSelectionDuringEditing = YES;
    
    allApps = [[NSMutableArray alloc] init];
    enabledApps = [[NSMutableArray alloc] init];
    disabledApps = [[NSMutableArray alloc] init];
    
    NSMutableArray *a = [[NSMutableArray alloc] init];

    applications = [ALApplicationList sharedApplicationList];
    [applications applicationsFilteredUsingPredicate:[NSPredicate predicateWithFormat:@"(isSystemApplication = true) OR (isSystemApplication = false)"] onlyVisible:true titleSortedIdentifiers:&a];
    allApps = a;
    
    settings = (NSMutableDictionary*)[self initDictionaryWithFile:kPrefs_Path asMutable:YES];

    enabledApps = [settings[@"favorites"] mutableCopy];
    disabledApps = [allApps mutableCopy];
    [disabledApps removeObjectsInArray:enabledApps];
}



- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    NSMutableArray *sourceArray = (sourceIndexPath.section == 0)?enabledApps:disabledApps;
    NSMutableArray *destinationArray = (destinationIndexPath.section == 0)?enabledApps:disabledApps;
    
    NSString *element = [[sourceArray objectAtIndex:sourceIndexPath.row] copy];
    [sourceArray removeObjectAtIndex:sourceIndexPath.row];
    [destinationArray insertObject:element atIndex:destinationIndexPath.row];
    
    [settings setObject:enabledApps forKey:@"favorites"];
    [settings writeToFile:kPrefs_Path atomically:YES];
}


-(BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}


-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleNone;
}

-(BOOL)tableView:(UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath{
    return NO;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return @"Enabled Apps";
    }else{
        return @"Disabled Apps";
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return enabledApps.count;
    }else{
        return disabledApps.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleGray;

    NSString *identifier;

    if (indexPath.section == 0) {
        identifier = enabledApps[indexPath.row];
    }else{
        identifier = disabledApps[indexPath.row];
    }
    
    UIImage *icon;
    @try {
        icon = [applications iconOfSize:ALApplicationIconSizeSmall forDisplayIdentifier:identifier];
        cell.imageView.image = icon;
        cell.detailTextLabel.text = [applications valueForKey:@"displayName" forDisplayIdentifier:identifier];
    } @catch (NSException *exception) {
        
    }

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        [self tableView:tableView moveRowAtIndexPath:[NSIndexPath indexPathForRow:indexPath.row inSection:1] toIndexPath:[NSIndexPath indexPathForRow:enabledApps.count inSection:0]];
    }else{
        [self tableView:tableView moveRowAtIndexPath:[NSIndexPath indexPathForRow:indexPath.row inSection:0] toIndexPath:[NSIndexPath indexPathForRow:disabledApps.count inSection:1]];
    }
    
    [self.tableView reloadData];
}





- (id)initDictionaryWithFile:(NSString*)plistPath asMutable:(BOOL)asMutable
{
    Class class;
    if (asMutable)
        class = [NSMutableDictionary class];
    else
        class = [NSDictionary class];
    
    id dict;
    if ([[NSFileManager defaultManager] fileExistsAtPath:plistPath]){
        NSLog(@"[HBP] extension plist exists");
        dict = [[class alloc] initWithContentsOfFile:plistPath];
    }else{
        NSLog(@"[HBP] creating new dict");
        dict = [[class alloc] init];
        dict[@"favorites"] = [[NSArray alloc] init];
    }
    
    return dict;
}



@end
