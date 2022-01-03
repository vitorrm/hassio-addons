# Home Assistant Community Add-on: Oauth2 Proxy

If you are like me and you end up using home assistant with NGINX addon to proxy to a lot of services in your little private server, you can use this plugin to protect some of the not well protected services with [Oauth2 Proxy][oauth2-proxy]

## What this is NOT
1. This is not a replacement for Home Assistant login screen. Although you can add oauth2-proxy in front of the home assistant service you will still need to login with home assistant user after you sign-in with OAuth. Also if you do so, you will not be able to use Home Assistant App
1. This is not a magical protection, you will still need to carefully choose the service paths you want to protect with OAuth on NGINX config

## Tested scenarios
1. This addon was tested with OAuth2 Proxy configured with Google as provider and the NGinx addon used was [Nginx Proxy][nginx-proxy]. 

You can probably make this work with other Nginx addons and providers supported by [Oauth2 Proxy][oauth2-proxy], however it will require that you do some exploring, but if you do make it work with other addons/providers, please report back so we can add more success cases here.

## Installation

TBD

## Configuration

TBD

## Support

TBD

## Authors & contributors

Vitor R Munhoz \<vitor.rm@gmail.com\>

## License

MIT License

Copyright (c) 2017-2021 Vitor R Munhoz

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

[semver]: http://semver.org/spec/v2.0.0.html
[oauth2-proxy]: https://oauth2-proxy.github.io/oauth2-proxy/
[nginx-proxy]: https://github.com/home-assistant/addons/tree/master/nginx_proxy