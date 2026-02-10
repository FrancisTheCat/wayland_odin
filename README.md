## A wayland client implementation in Odin
The code in this library is generated directly from the xml files and does not use libwayland, which allows for a much simpler api without callbacks etc., but due to _intereresting_ decisions in mesa this makes hardware acceleration quite hard to implement:
https://wayland-book.com/surfaces/dmabuf.html#but-i-really-want-to-know-about-the-internals

## Building:
```sh
odin run generator -- wayland/protocol/wayland.xml wayland-protocols/stable/*/*.xml wayland-protocols/staging/*/*.xml
odin run app
```
