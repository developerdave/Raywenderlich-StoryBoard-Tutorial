#import <UIKit/UIKit.h>
#import "PlayerDetailsViewController.h"

@interface PlayersViewController : UITableViewController <PlayersDetailViewControllerDelegate>

@property (nonatomic, strong) NSMutableArray *players;

@end
