from http.server import SimpleHTTPRequestHandler, HTTPServer
import time

PORT = 6969

class MyHandler(SimpleHTTPRequestHandler):
    def do_GET(self):
        self.send_response(200)
        self.end_headers()
        self.wfile.write(b'Servidor operativo.')

if __name__ == "__main__":
    print(f"Servidor HTTP corriendo en puerto {PORT}")
    server = HTTPServer(("", PORT), MyHandler)
    try:
        server.serve_forever()
    except KeyboardInterrupt:
        pass
    server.server_close()
