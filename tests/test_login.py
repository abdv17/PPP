from playwright.sync_api import sync_playwright

def test_login():
    with sync_playwright as p:
        browser = p.chromium.launch(headless=False)
        context = browser.new_context(viewport=None)
        page = content.new_page()
        page.goto('https://google.co.in')