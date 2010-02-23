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
	import flash.errors.EOFError;
	import flash.events.DataEvent;

	/**
	 * @author Matthias Breuer -- www.mattbreuer.com
	 */
	public final class Netreceive extends FudiBase {
		private var _msg : String;

		public function Netreceive($port : int) {
			super();
			_msg = "";
			doConnect("localhost", $port);
		}

		public function convertData($data : String, $format : String) : Array {
			$data = $data.replace(";", "");
			$format = $format.replace(" ", "");
			var converted : Array = new Array();
			var splitted : Array = $data.split(/[\x20\x09\x0A]+/g);
			for(var j : int = 0;j < $format.length;j++) {
				switch($format.charAt(j)) {
					case "f":
						var f : Number = new Number(splitted[j]);
						converted.push(f);
						break;
					case "i":
						var i : int = new int(splitted[j]);
						converted.push(i);
						break;
					default:
						converted.push(splitted[j]);
						break;
				}
			}
			return converted;
		}

		private function send() : void {
			_msg = _msg.replace("\n", "");
			_msg = _msg.replace("\r", "");
			dispatchEvent(new DataEvent(DataEvent.DATA, false, false, _msg));
			_msg = "";
		}

		override protected function data() : void {
			while(true) {
				try {
					var current : String = _socket.readUTFBytes(1);
					_msg += current;
					if(current == ";") send();
				} catch($e : EOFError) {
					break;
				}
			}
		}
	}
}
