//
//  ViewController.m
//

#import "ViewController.h"

@interface ViewController()

	@property (strong, nonatomic) NSMutableArray *photos;

	@property (strong, nonatomic) MWPhotoBrowser *browser;

@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	
	
	// Create array of MWPhoto objects
	self.photos = [NSMutableArray array];
	
	// Add photos
	for (int i = 1; i < 100; i++) {
		//NSLog(@"i = %i", i);
		NSString *fName = [NSString stringWithFormat:@"photo%i", i];
		NSString *pth = [[NSBundle mainBundle] pathForResource:fName ofType:@"jpg"];
		if (!pth) {
			break;
		}
		[_photos addObject:[MWPhoto photoWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:fName ofType:@"jpg"]]]];
	}
	

	// Create browser (must be done each time photo browser is displayed. Photo browser objects cannot be re-used)
	_browser = [[MWPhotoBrowser alloc] initWithDelegate:self];
	
	// Set options as desired
	_browser.displayActionButton = YES; // Show action button to allow sharing, copying, etc (defaults to YES)
	_browser.displayNavArrows = NO; // Whether to display left and right nav arrows on toolbar (defaults to NO)
	_browser.displaySelectionButtons = NO; // Whether selection buttons are shown on each image (defaults to NO)
	_browser.zoomPhotosToFill = YES; // Images that almost fill the screen will be initially zoomed to fill (defaults to YES)
	_browser.alwaysShowControls = YES; // Allows to control whether the bars and controls are always visible or whether they fade away to show the photo full (defaults to NO)
	_browser.enableGrid = YES; // Whether to allow the viewing of all the photo thumbnails on a grid (defaults to YES)
	_browser.startOnGrid = YES; // Whether to start on the grid of thumbnails instead of the first photo (defaults to NO)
	_browser.autoPlayOnAppear = NO; // Auto-play first video
	
	// Customise selection images to change colours if required
	_browser.customImageSelectedIconName = @"ImageSelected.png";
	_browser.customImageSelectedSmallIconName = @"ImageSelectedSmall.png";
	
	// calculate bottom half of view
	CGRect r = self.view.frame;
	r.size.height /= 2.0;
	r.origin.y = r.size.height;
	
	_browser.view.frame = r;
	[self.view addSubview:_browser.view];
	
	
}

- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser thumbPhotoAtIndex:(NSUInteger)index {
	
	NSString *fName = [NSString stringWithFormat:@"photo%lut", index + 1];
	return [MWPhoto photoWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:fName ofType:@"jpg"]]];

}

- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser {
	return self.photos.count;
}

- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index {
	if (index < self.photos.count) {
		return [self.photos objectAtIndex:index];
	}
	return nil;
}


- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

@end
