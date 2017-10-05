class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    rootViewController = UIViewController.alloc.init
    rootViewController.title = 'TestApp'
    rootViewController.view.backgroundColor = UIColor.whiteColor

    navigationController = UINavigationController.alloc.initWithRootViewController(rootViewController)

    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    @window.rootViewController = navigationController
    @window.makeKeyAndVisible

    do_database_stuff
    true
  end

  def do_database_stuff
    db = SQLite3::Database.new(":memory:")
    db.execute("CREATE TABLE test (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, age INTEGER)")
    db.execute("INSERT INTO test (name, age) VALUES (?, ?)", ["brad", 28])
    db.execute("INSERT INTO test (name, age) VALUES (?, ?)", ["sparky", 24])

    rows = []
    db.execute("SELECT * FROM test") do |row|
      rows << row
    end

    puts rows
  end
end
