from playwright.sync_api import sync_playwright
import logging
from pathlib import Path
import os
from datetime import datetime

def test_login():
    LOG_DIR = "Log"
    os.makedirs(LOG_DIR, exist_ok=True)
    log_path = os.path.join(LOG_DIR, f"test_{datetime.now():%Y-%m-%d}.log")
    
    logging.basicConfig(
        level=logging.INFO,                   # DEBUG | INFO | WARNING | ERROR | CRITICAL
        filename=log_path,                    # <- this creates/writes to file
        filemode="a",                         # "w" to overwrite each run
        format="%(asctime)s [%(levelname)s] %(name)s: %(message)s",
        datefmt="%Y-%m-%d %H:%M:%S"
    )

    
    logging.info('Running the test case')
    print('running login test case')
    with sync_playwright as p:
        logging.info('Inside sync playwright block')
        print('Inside sync playwright block and launching chrome with google.co.in')   
        browser = p.chromium.launch(headless=False)
        context = browser.new_context(viewport=None)
        page = content.new_page()
        page.goto('https://google.co.in')
        