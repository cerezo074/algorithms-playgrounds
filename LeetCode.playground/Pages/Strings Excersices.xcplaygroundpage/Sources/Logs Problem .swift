import Foundation

public func parse(rawLogs: String) -> String {
    let logLines = rawLogs.components(separatedBy: "\n")
        .compactMap { $0.makeLogLine() }
    var groups: Set<GroupLog> = []
    
    for logLine in logLines {
        let group = GroupLog(HTTPRestResource: logLine.HTTPRestResource, line: logLine)
        
        if var foundGroup = groups.remove(group) {
            foundGroup.lines.append(logLine)
            groups.insert(foundGroup)
        } else {
            groups.insert(group)
        }
    }
    
    return groups.map { $0.beautySummary() }
        .joined(separator: "\n")
}

struct LineLog {
    let date: String
    let time: String
    let IPAddress: String
    let HTTPRestResource: String
    let HTTPRestVerb: String
    let HTTPStatusCode: String
    
    var fullDate: String {
        return "\(date) \(time)"
    }
}

struct GroupLog: Hashable {
    let HTTPRestResource: String
    var lines: [LineLog]
    
    init(HTTPRestResource: String, line: LineLog) {
        self.HTTPRestResource = HTTPRestResource
        self.lines = [line]
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(HTTPRestResource)
    }
    
    static func == (lhs: GroupLog, rhs: GroupLog) -> Bool {
        return lhs.HTTPRestResource == rhs.HTTPRestResource
    }
    
    func beautySummary() -> String {
        var userLogs: Set<UserLog> = []
        
        for line in lines {
            let userLog = UserLog(IPAddress: line.IPAddress, line: line)
            
            if var foundUser = userLogs.remove(userLog) {
                foundUser.lines.append(line)
                userLogs.insert(foundUser)
            } else {
                userLogs.insert(userLog)
            }
        }
        
        let beautySummaries = userLogs.map { $0.beautySummary() }.joined(separator: "\n")
        
        return "Resource: \(HTTPRestResource)\n\(beautySummaries)"
    }
}

struct UserLog: Hashable {
    let IPAddress: String
    var lines: [LineLog]
    
    init(IPAddress: String, line: LineLog) {
        self.IPAddress = IPAddress
        self.lines = [line]
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(IPAddress)
    }
    
    func beautySummary() -> String {
        var httpRequests: [String] = []
        var fullDates: [Date] = []
        
        for line in lines {
            if let date = line.fullDate.toDate() {
                fullDates.append(date)
            }
            
            httpRequests.append("(\(line.HTTPRestVerb), \(line.HTTPStatusCode))")
        }
        
        fullDates.sort()
        
        let fullDate = switch fullDates.count {
        case 0: ""
        case 1: fullDates[0].toString()
        default: "\(fullDates.first!.toString()) - \(fullDates.last!.toString())"
        }
        
        return "\t\(IPAddress) - \(httpRequests.joined(separator: " ")) - \(fullDate)"
    }
    
    static func == (lhs: UserLog, rhs: UserLog) -> Bool {
        lhs.IPAddress == rhs.IPAddress
    }
}

extension String {
    enum LogItem: CaseIterable {
        case date
        case time
        case IPAddress
        case HTTPRestResource
        case HTTPRestVerb
        case HTTPStatusCode
    }
    
    func makeLogLine() -> LineLog? {
        let components = components(separatedBy: " ")
        
        guard components.count == LogItem.allCases.count else {
            return nil
        }
        
        return LineLog(
            date: components[0],
            time: components[1],
            IPAddress: components[2],
            HTTPRestResource: components[3],
            HTTPRestVerb: components[4],
            HTTPStatusCode: components[5]
        )
    }
    
    private static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return formatter
    }()
    
    func toDate() -> Date? {
        return String.dateFormatter.date(from: self)
    }
}

extension Date {
    private static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return formatter
    }()
    
    func toString() -> String {
        return Date.dateFormatter.string(from: self)
    }
}
