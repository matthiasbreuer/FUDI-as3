/*
 *  Copyright (c) 2010, Matthias Breuer <www.matthiasbreuer.com>
 *
 *  Permission to use, copy, modify, and/or distribute this software for any
 *  purpose with or without fee is hereby granted, provided that the above
 *  copyright notice and this permission notice appear in all copies.
 *
 *  THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
 *  WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
 *  MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
 *  ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
 *  WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
 *  ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
 *  OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
 */
 
class BaseServer {
  private   Boolean _running;
  protected byte    _zero = 0;
  protected   Server  _server;
  private   PApplet _parent;
  private   int     _port;
  private   String  _name;

  BaseServer(PApplet $parent, int $port, String $name) {
    _parent = $parent;
    _running = false;
    _port = $port;
    _name = $name;
  }

  protected void checkClient(Client $client) {
  }

  public void start() {
    if(_running) return;
    println("Starting " + _name + " at port " + _port);
    _server = new Server(_parent, _port);
    _running = true;
  }

  public void stop() {
    if(!_running) return;
    println("Stopping " + _name + " at port " + _port);
    _server.stop();
    _running = false;
  }

  public void check() {
    Client pClient = _server.available();
    if(pClient != null) {
      checkClient(pClient);
    }
  }

  public Boolean running() {
    return _running;
  }

  public boolean is(Server $server) {
    return $server == _server;
  }
}

