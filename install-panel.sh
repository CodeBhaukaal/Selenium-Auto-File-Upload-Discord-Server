from selenium import webdriver
from selenium.webdriver.common.keys import Keys
import time
import json
import os

if os.path.exists(os.getcwd() + "/config.json"):
    
    with open("./config.json") as f:
        configData = json.load(f)

else:
    configTemplate = {"Token": "", "Prefix": "."}

    with open(os.getcwd() + "/config.json", "w+") as f:
        json.dump(configTemplate, f) 

token = configData["Token"]
uploadfile_channel = configData["Uploadfile_channel"]


# Initialize the Selenium WebDriver
driver = webdriver.Chrome() 
driver.maximize_window()
    
driver.get("https://www.discord.com/login")
time.sleep(3)


driver.execute_script('window.t = "' + token + '";window.localStorage = document.body.appendChild(document.createElement `iframe`).contentWindow.localStorage;window.setInterval(() => window.localStorage.token = `"${window.t}"`); window.location.reload();')
time.sleep(5)
driver.get(uploadfile_channel)
driver.maximize_window()
time.sleep(5)


folder_path = configData["folder_paths"]
set_featured_image_button = driver.find_element("xpath", "//body/div[@id='app-mount']/div[2]/div[1]/div[1]/div[1]/div[2]/div[1]/div[1]/div[1]/div[1]/div[3]/div[2]/main[1]/form[1]/div[1]/div[1]/div[1]/div[1]/input[1]")
image_files = [os.path.join(folder_path, f) for f in os.listdir(folder_path) if os.path.isfile(os.path.join(folder_path, f))]


for image_file in image_files:
    set_featured_image_button.send_keys(image_file)
    set_featured_image_buttons = driver.find_element("xpath", "//body/div[@id='app-mount']/div[2]/div[1]/div[1]/div[1]/div[2]/div[1]/div[1]/div[1]/div[1]/div[3]/div[2]/main[1]/form[1]/div[1]/div[1]/div[2]/div[3]/div[1]/div[2]")
    set_featured_image_buttons.send_keys('')
    set_featured_image_buttons.send_keys(Keys.RETURN)
    time.sleep(5)


time.sleep(1800)
driver.quit()
