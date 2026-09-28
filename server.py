import os, time, json, socket
from http.server import BaseHTTPRequestHandler, ThreadingHTTPServer

START = time.time()  # measured from process start
VERSION = os.getenv("APP_VERSION", "v1")
DELAY = float(os.getenv("READY_DELAY_SECONDS", "0"))
NEVER_READY = os.getenv("NEVER_READY", "false").lower() == "true"
POD = os.getenv("HOSTNAME", socket.gethostname())

def is_ready():
    if NEVER_READY:
        return False
    return (time.time() - START) >= DELAY

class Handler(BaseHTTPRequestHandler):
    def _send(self, code, body):
        data = json.dumps(body).encode()
        self.send_response(code)
        self.send_header("Content-Type", "application/json")
        self.send_header("Content-Length", str(len(data)))
        self.end_headers()
        self.wfile.write(data)

    def do_GET(self):
        if self.path == "/health":
            self._send(200, {"status": "alive"})
        elif self.path == "/ready":
            ok = is_ready()
            self._send(200 if ok else 503, {"ready": ok})
        elif self.path == "/version":
            if is_ready():
                self._send(200, {"version": VERSION, "pod": POD})
            else:
                self._send(503, {"error": "not ready", "pod": POD})
        else:
            self._send(404, {"error": "not found"})

    def log_message(self, fmt, *args):
        print(f"{time.strftime('%H:%M:%S')} {self.path} {args[1]}", flush=True)

if __name__ == "__main__":
    print(f"starting version={VERSION} delay={DELAY} never_ready={NEVER_READY}", flush=True)
    ThreadingHTTPServer(("0.0.0.0", 8080), Handler).serve_forever()
