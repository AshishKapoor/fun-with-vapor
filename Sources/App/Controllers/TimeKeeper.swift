import Foundation

class TimeKeeper {
    
    func getSystemTime() -> String {
        let current     = Date()
        return self.dateFormatter().string(from: current)
    }
    
    func dateFormatter() -> DateFormatter {
        let formatter = DateFormatter()
        
        formatter.dateFormat    = "hh:mm a z 'on' EEEE, MMMM dd, y"
        formatter.timeZone      = TimeZone(abbreviation: "GMT-5")
        
        return formatter
    }
}
