
#import "secondCell.h"

@implementation secondCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.lab = [[UILabel alloc] initWithFrame:self.bounds];
        
        [self addSubview:self.lab];
        
    }
    return self;
}
- (void)loadData:(id)obj{
    _lab.text = obj;
}

@end
