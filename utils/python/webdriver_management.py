#requeriments:  webdriver-manager==3.7.0*
from webdriver_manager.chrome import ChromeDriverManager
from webdriver_manager.microsoft import EdgeChromiumDriverManager
from webdriver_manager.firefox import GeckoDriverManager
from webdriver_manager.microsoft import IEDriverManager
from webdriver_manager.core.utils import ChromeType
from robot.libraries.BuiltIn import BuiltIn
import os

"""Para suporte a novos navegadores e/ou configuração do GH_TOKEN,
   por gentileza, acesse a documentação da Lib webdriver-manager:
   https://pypi.org/project/webdriver-manager/"""

def get_webdriver(browser: str):
    """Seleciona o Webdriver adequado de acordo com o browser escolhido."""
    os.environ['GH_TOKEN'] =  str(BuiltIn().get_variable_value("${gh_token}"))
    webdriver_obj = {
        # Chrome:
        'chrome':('chrome', ChromeDriverManager()),
        'headlesschrome':('headlesschrome',ChromeDriverManager()),
        'headless':('chrome', ChromeDriverManager()),
        'chromium':('chrome',ChromeDriverManager(chrome_type=ChromeType.CHROMIUM)),
        # Microsoft Edge:
        'edge':('edge', EdgeChromiumDriverManager()),
        #Internet Explorer:
        ## > PadNMS+ não funciona pois o IE não tem suporte a Javascript;
        ## > precisa que todas as Protected Mode Settings Zones sejam as mesmas;
        ## > precisa de GH_TOKEN.
        'ie':('ie', IEDriverManager()),
        # Firefox:
        ## > precisa de GH_TOKEN
        'firefox': ('firefox',GeckoDriverManager())}
    return webdriver_obj[browser.lower()]