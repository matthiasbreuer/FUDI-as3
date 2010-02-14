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
 
import processing.net.*;
import controlP5.*;

PolicyServer _policyServer;
FudiServer   _fudiServer;
ControlP5 _control;
RadioButton _policyServerControl;
RadioButton _fudiServerControl;

static public void main(String args[]) {
    PApplet.main(new String[] { "flash_fudi" });
}

void setup() {
  size(100, 100);
  frameRate(31);
  _policyServer = new PolicyServer(this);
  _fudiServer = new FudiServer(this, 3001);
  _control = new ControlP5(this);
  // Start
  createInterface(); 
}

void createInterface() {
  _control.addTextlabel("labelPolicy","Policy Server",10,10);
  _policyServerControl = _control.addRadioButton("policyServerControl", 10, 25);
  _policyServerControl.setItemsPerRow(2);
  _policyServerControl.setSpacingColumn(30);
  _policyServerControl.addItem("on", 1);
  _policyServerControl.addItem("off", 0);
  _policyServerControl.getItem(1).setState(true);
  _control.addTextlabel("labelFudi","FUDI Server",10,55);
  _fudiServerControl = _control.addRadioButton("fudiServerControl", 10, 70);
  _fudiServerControl.setItemsPerRow(2);
  _fudiServerControl.setSpacingColumn(30);
  _fudiServerControl.addItem("on", 1);
  _fudiServerControl.addItem("off", 0);
  _fudiServerControl.getItem(1).setState(true);
}

void controlEvent(ControlEvent $e) {
  if($e.group().name() == "policyServerControl") {
    if($e.group().value() == 1) {
      _policyServer.start();
    } else if($e.group().value() == 0) {
      _policyServer.stop();
    }
  }
  else if($e.group().name() == "fudiServerControl") {
    if($e.group().value() == 1) {
      _fudiServer.start();
    } else if($e.group().value() == 0) {
      _fudiServer.stop();
    }
  }
}

void draw() {
  background(#222222);
  if(_policyServer.running()) {
    _policyServer.check();
  }
  if(_fudiServer.running()) {
    _fudiServer.check();
  }
}

void serverEvent(Server $server, Client $client) {
  if(_policyServer.is($server)) {
    println("Connection to policy server.");
  }
  else if(_fudiServer.is($server)) {
    println("Connection to fudi server.");
  }
}

void stop() {
  _policyServer.stop();
}
