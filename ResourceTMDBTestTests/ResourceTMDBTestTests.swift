import XCTest

@testable import ResourceTMDBTest

// MARK: tests fake data

class LoginViewModelTest: XCTestCase {
    
    // MARK: Test subject
    var viewModel: LoginViewModel?
    private var fakeDataService: FakeDataProvider!
    
    override func setUp() {
        super.setUp()
        self.fakeDataService = FakeDataProvider()
        self.viewModel = LoginViewModel(dataService: fakeDataService)
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class
        self.viewModel = nil
        super.tearDown()
    }
    
    
    func testLoginSuccess() {
        fakeDataService.userLoginTest(username: "ramiro", password: "password", completion: {
            (fakeUser, error)
            in
            XCTAssertEqual(fakeUser?.username, "ramiro")
        })
    }
    
    func testLoginError() {
        fakeDataService.userLoginTest(username: "ramiro", password: "password1234", completion: {
            (fakeUser, error)
            in
            XCTAssertEqual(fakeUser?.username, "testeUser")
            
        })
    }
    
}
