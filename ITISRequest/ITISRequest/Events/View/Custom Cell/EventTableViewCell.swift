import UIKit

class EventTableViewCell: UITableViewCell {
    
    // MARK: - IBOutlets
    @IBOutlet private var eventNameLabel: UILabel!
    @IBOutlet private var eventDateTimeLabel: UILabel!
    @IBOutlet private var eventPlaceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    //Functions
    func setCellData(eventDateTime: Date, eventName: String, eventPlace: String) {
        eventNameLabel.adjustsFontSizeToFitWidth = true
        eventNameLabel.text = eventName
        eventDateTimeLabel.adjustsFontSizeToFitWidth = true
        eventDateTimeLabel.text = dateString(eventDateTime: eventDateTime)
        eventPlaceLabel.adjustsFontSizeToFitWidth = true
        eventPlaceLabel.text = eventPlace
    }
    
    func dateString(eventDateTime: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm"
        return formatter.string(from: eventDateTime)
    }
}
