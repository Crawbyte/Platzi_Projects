#Library
import requests #Make requests to html
import lxml.html as html #apply xpath to html

#Constants paths
HOME_URL = 'https://www.larepublica.co/'
XPATH_LINK= '//div/a[contains(@class, "kicker")]/@href'
XPATH_TITTLE = '//div/h3[contains(@class, "kicker")]/following-sibling::h2/a/text()'
XPATH_SUMMARY = '//div[@class="lead"]/p/text()'
XPATH_BODY = '//div[@class="html-content"]/p/text()'

#Functions
def parse_home():
    try:
        response = requests.get(HOME_URL)
        if response.status_code == 200: 
            home = response.content.decode('utf-8')
            parsed = html.fromstring(home)
            links_to_notices = parsed.xpath(XPATH_LINK)
            print(links_to_notices)
        else:
            raise ValueError(f'Error: {response.status_code}')
    except ValueError as ve:
        print(ve)

def run():
    parse_home()

if __name__ == '__main__':
    run()