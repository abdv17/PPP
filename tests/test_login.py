from playwright.sync_api import sync_playwright

def test_login():
    print('running login test case')
    with sync_playwright as p:
        print('Inside sync playwright block and launching chrome with google.co.in')   
        browser = p.chromium.launch(headless=False)
        context = browser.new_context(viewport=None)
        page = content.new_page()
        page.goto('https://google.co.in')