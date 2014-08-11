#import "PlayerDetailsViewController.h"
#import "Player.h"

@interface PlayerDetailsViewController ()

- (void)mapPlayer:(Player *)player;

@end

@implementation PlayerDetailsViewController
{
    NSString *_game;
}

#pragma mark - NSCoding

- (id)initWithCoder:(NSCoder *)aDecoder {
    if ((self = [super initWithCoder:aDecoder])) {
        NSLog(@"init PlayerDetailsViewController");
        _game = @"Chess";
    }
    return self;
}

#pragma mark - UIViewController

- (void)dealloc {
    NSLog(@"dealloc PlayerDetailsViewController");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.player) {
        self.title = @"Edit Player";
        self.nameTextField.text = self.player.name;
        self.detailLabel.text = self.player.game;
    } else {
        self.detailLabel.text = _game;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"PickGame"]) {
        GamePickerViewController *gamePickerViewController = segue.destinationViewController;
        gamePickerViewController.delegate = self;
        gamePickerViewController.game = _game;
    }
}

#pragma mark - IBAction

- (IBAction)cancel:(id)sender {
    [self.delegate playerDetailsViewControllerDidCancel:self];
}

- (IBAction)done:(id)sender {
    if (self.player) {
        [self mapPlayer:self.player];
        [self.delegate playerDetailsViewControllerDidEdit:self didEditPlayer:self.player];
    } else {
        Player *player = [[Player alloc] init];
        
        [self mapPlayer:player];
        [self.delegate playerDetailsViewControllerDidSave:self didAddPlayer:player];
    }
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        [self.nameTextField becomeFirstResponder];
    }
}

#pragma mark - GamePickerViewControllerDelegate

- (void)gamePickerViewController:(GamePickerViewController *)controller didSelectGame:(NSString *)game {
    _game = game;
    self.detailLabel.text = _game;
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Helpers

- (void)mapPlayer:(Player *)player {
    player.name = self.nameTextField.text;
    player.game = _game;
    player.rating = 1;
}


@end
