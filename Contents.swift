// შექმენით enum-ი სახელით DayOfWeek შესაბამისი ქეისებით. დაწერეთ function რომელიც იღებს ამ ენამის ტიპს. function-მა უნდა და-print-ოს, გადაწოდებული დღე კვირის დღეა თუ დასვენების.
print("Problem 1")

enum DayOfWeek {
    case monday
    case tuesday
    case wednesday
    case thursday
    case friday
    case saturday
    case sunday
}

func whatDayIsIt(day: DayOfWeek){
    switch day {
    case .sunday, .saturday:
        print("It's a weekend.")
    default:
        print("It's a work day.")
    }
}

whatDayIsIt(day: DayOfWeek.friday)

print("")

// შექმენით enum-ი Weather შემდეგი ქეისებით, Sunny, Cloudy, Rainy და Snowy. ამ ქეისებს უნდა ჰქონდეს associated value Celsius-ის სახით. დაწერეთ function რომელიც მიიღებს ამ enum-ს, და მოგვცემს რეკომენდაციას რა უნდა ჩავიცვათ შესაბამისი ამინდის მიხედვით.
print ("Problem 2")

enum Weather {
    case sunny(Int)
    case cloudy(Int)
    case rainy(Int)
    case snowy(Int)
}

func dressingRecomendationByWeather(weather: Weather) {
    switch weather {
    case .sunny(let celsius):
        print("It's a sunny day, \(celsius) degree")
        
        switch celsius {
        case ..<15:
            print("Wear a light jacket or sweater.")
        case 15...25:
            print("A t-shirt or short-sleeve shirt paired with shorts or a skirt.")
        default:
            print("Wear a wide-brimmed hat and sunglasses to shield yourself from the sun.")
        }
    case .cloudy(let celsius):
        print("It's a cloudy day, \(celsius) degree")
        
        switch celsius {
        case ..<15:
            print("Carry an umbrella or a rain jacket in case it rains.")
        case 15...25:
            print("Long pants and a long-sleeve shirt or a light jacket.")
        default:
            print("Be prepared for sudden weather changes with a light jacket.")
        }
    case .rainy(let celsius):
        print("It's a rainy day, \(celsius) degree")
        
        switch celsius {
        case ..<15:
            print("Wear a waterproof jacket, rain boots, and jeans. Don't forget an umbrella.")
        case 15...25:
            print("Carry an umbrella and wear a hat to keep dry.")
        default:
            print("Light and waterproof clothing to stay dry and cool.")
        }
    case .snowy(let celsius):
        print("It's a snowy day, \(celsius) degree")
        
        switch celsius {
        case ..<15:
            print("Layer with a warm coat, a sweater, and thermal pants.")
        case 15...25:
            print("Winter accessories like a hat, gloves, and a scarf.")
        default:
            print("Be prepared for varying weather conditions. Wear a light jacket and layers if it's warmer.")
        }
    }
}

dressingRecomendationByWeather(weather: Weather.rainy(27))
dressingRecomendationByWeather(weather: Weather.snowy(-5))
dressingRecomendationByWeather(weather: Weather.sunny(5))
dressingRecomendationByWeather(weather: Weather.cloudy(20))

print("")

// შექმენით struct-ი Book, with properties როგორიცაა: title, author, publicationYear. ამის შემდეგ შექმენით array-ი Book-ის ტიპის, შექმენით რამოდენიმე Book-ის ობიექტი, და შეავსეთ array ამ წიგნებით. დაწერეთ function რომელიც მიიღებს ამ წიგნების array-ს და მიიღებს წელს. function-მა უნდა დაგვიბრუნოს ყველა წიგნი რომელიც გამოშვებულია ამ წლის შემდეგ. დავ-print-ოთ ეს წიგნები.
print("Problem 3")

struct Book {
    var title: String
    var author: String
    var publicationYear: Int
}

var books = [
    Book(title: "Sound and Fury", author: "William Falkner", publicationYear: 1929),
    Book(title: "To kill a Mockingbird", author: "Harper Lee", publicationYear: 1960),
    Book(title: "The Metamorphosis", author: "Franz Kafka", publicationYear: 1915),
]

func booksPublishedAfter (books: [Book], year: Int) -> [Book] {
    books.filter { (book: Book) -> Bool in
        return book.publicationYear > year
    }
}

print(booksPublishedAfter(books: books, year: 1925).map({ "Title: \($0.title), author: \($0.author), year: \($0.publicationYear)" }))

print("")

// შექმენით struct BankAccount, with properties როგორიცაა: holderName, accountNumber, balance. ამ ობიექტში დაამატეთ methods, დეპოზიტისა და გატანის (withdraw), დაწერეთ შესაბამისი ლოგიკა და ეცადეთ გაითვალისწინოთ სხვადასხვა ეჯ-ქეისები (edge case). მაგ. თანხის გატანისას თუ თანხა იმაზე ნაკლებია ვიდრე გვაქვს, თანხას ვერ გავიტანთ და ასე შემდეგ. print-ის მეშვეობით გამოვიტანოთ შესაბამისი შეცდომები . ამის შემდეგ შექმენით BankAccount ობიექტი და გააკეთეთ ტრანზაქციების იმიტაცია თქვენს მიერ დაწერილი მეთოდებით.
print("Problem 4")

struct BankAccount {
    var holderName: String
    let accountNumber: String
    private var balance = 0.00
    var maxWithdrawalAmount = 100000.00
    var withdrawalFeeRate = 0.001
    var maxDepositAmount = 100000.00
    var withdrawalFeeThreshold = 1000.00
    
    init(holderName: String, accountNumber: String) {
        self.holderName = holderName
        self.accountNumber = accountNumber
    }
    
    mutating func deposit(amount: Double) {
        if amount > maxDepositAmount {
            print("error: deposit limit \(maxDepositAmount) exceeded")
            return
        }
        balance += amount
    }
    
    mutating func withdwaw(amount: Double) {
        let fee = calculateFee(amount: amount)
        let totalAmount = fee + amount
        
        if balance < totalAmount {
            print("error: insufficient balance")
            return
        }
        if amount > maxWithdrawalAmount {
            print("error: withdrawal limit \(maxWithdrawalAmount) exceeded")
            return
        }
        
        balance -= totalAmount
    }
    
    func calculateFee(amount: Double) -> Double {
        var fee = 0.00
        if amount > withdrawalFeeThreshold {
            fee = amount * withdrawalFeeRate
        }
        return fee
    }
    
    func getBalance() -> Double {
        return balance
    }
}

var bankaccount = BankAccount(holderName: "Koka Kandiashvili", accountNumber: "GE67TB68BG78074320")

print("Balance after newly created account: \(bankaccount.getBalance())")

bankaccount.deposit(amount: 5000)
print("Balance after deposit 5000: \(bankaccount.getBalance())")

print("Fee for withdraw 1500 is: \(bankaccount.calculateFee(amount: 1500))")

bankaccount.withdwaw(amount: 1500)
print("Balance after withdraw 1500: \(bankaccount.getBalance())")

bankaccount.deposit(amount: 1500000)

bankaccount.withdwaw(amount: 4000)

print("")

// შექმენით enum-ი Genre მუსიკის ჟანრის ქეისებით. ამის შემდეგ შექმენით struct Song, with properties: title, artist, duration, genre, description (computied propertie უნდა იყოს description) და publisher (lazy propertie-ად შექმენით publisher). შემდეგ შექმენით თქვენი playlist array რომელსაც Song-ებით შეავსებთ (ზოგ song-ს ჰქონდეს publisher, ზოგს არა). შექმენით function რომელსაც გადააწვდით თქვენს playlist-ს და ჟანრს, function-ს დააბრუნებინეთ მხოლოდ იმ Song-ების array, რომელიც ამ ჟანრის იქნება და შემდეგ დაა-print-ინეთ ეს Song-ები.

enum Genre {
    case rock, pop, country, blues, heavyMetal, rap
}

struct Song {
    var title: String
    var artist: String
    var duration: Int
    var ganre: Genre
    var description: String {
        return "\(title) by \(artist), duration: \(duration / 60):\(duration % 60)"
    }
    lazy var publisher: String? = nil
}

var playlist = [
    Song(title: "Amodena mdinare", artist: "33a", duration: 188, ganre: Genre.pop),
    Song(title: "Stan", artist: "Eminem", duration: 220, ganre: Genre.rap, publisher: "The 45 King Eminem"),
    Song(title: "Changes", artist: "2Pac", duration: 170, ganre: Genre.rap)
]

func filterSongsByGenre(playlist: [Song], genre: Genre) -> [Song] {
    playlist.filter { (song: Song) -> Bool in
        return song.ganre == genre
    }
}

print(filterSongsByGenre(playlist: playlist, genre: Genre.rap).map({ $0.description }))
