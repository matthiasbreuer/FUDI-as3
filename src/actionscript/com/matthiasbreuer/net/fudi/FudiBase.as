/**
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
 
package com.matthiasbreuer.net.fudi {
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.Socket;

	/**
	 * @author Matthias Breuer -- www.mattbreuer.com
	 */
	internal class FudiBase extends EventDispatcher {
		protected var _socket : Socket;
		private var _connected : Boolean;

		public function FudiBase() {
			_socket = new Socket;
			_socket.addEventListener(Event.CONNECT, onConnect, false, 0, true);
			_socket.addEventListener(Event.CLOSE, onClose, false, 0, true);			_socket.addEventListener(ProgressEvent.SOCKET_DATA, onData, false, 0, true);
			_socket.addEventListener(IOErrorEvent.IO_ERROR, onError, false, 0, true);
			_socket.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecurityError, false, 0, true);
			_connected = false;
		}

		protected function doConnect($host : String, $port : int) : void {
			if(_connected) return;
			if($host == "localhost") $host = "127.0.0.1";
			_socket.connect($host, $port);
		}

		public function disconnect() : void {
			if(!_connected) return;
			_socket.close();
		}

		public function get connected() : Boolean {
			return _connected;
		}

		protected function data() : void {
		}

		private function onData($e : ProgressEvent) : void {
			data();
		}

		private function onSecurityError($e : SecurityErrorEvent) : void {
			dispatchEvent($e);
		}

		private function onClose($e : Event) : void {
			_connected = false;
			dispatchEvent($e);
		}

		private function onError($e : IOErrorEvent) : void {
			dispatchEvent($e);
		}

		private function onConnect($e : Event) : void {
			_connected = true;
			dispatchEvent($e);
		}
	}
}
