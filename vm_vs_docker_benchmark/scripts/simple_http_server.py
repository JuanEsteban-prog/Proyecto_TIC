import http.server
import socketserver

PORT = 9090
Handler = http.server.SimpleHTTPRequestHandler

with socketserver.TCPServer(("", PORT), Handler) as httpd:
    print(f"Servidor HTTP corriendo en puerto {PORT}")
    httpd.serve_forever()
