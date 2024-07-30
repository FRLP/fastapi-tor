from fastapi import FastAPI, Request
from fastapi.responses import HTMLResponse, Response
import requests
from bs4 import BeautifulSoup
from urllib.parse import urljoin

session = requests.session()
session.proxies = {'http': 'socks5h://localhost:9050',
                   'https': 'socks5h://localhost:9050'}

app = FastAPI()

@app.get("/{path:path}")
async def root(path: str, request: Request):
    url = f'http://{path}'
    response = session.get(url)
    content_type = response.headers.get('Content-Type', '')

    if 'text/html' in content_type:
        html_content = response.text
        soup = BeautifulSoup(html_content, 'html.parser')
        for tag in soup.find_all(True): 
            for attribute in ['href', 'src']:
                if tag.get(attribute):
                    tag[attribute] = urljoin(url, tag[attribute]).replace('http://', str(request.base_url), 1).replace('https://', str(request.base_url), 1)
        updated_html_content = str(soup)
        return HTMLResponse(content=updated_html_content)
    else:
        return Response(content=response.content, media_type=content_type)