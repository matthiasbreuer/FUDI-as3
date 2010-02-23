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

	/**
	 * @author Matthias Breuer -- www.mattbreuer.com
	 */
	public final class Netsend extends FudiBase {
		public function Netsend() {
			super();
		}

		public function connect($host : String, $port : int) : void {
			doConnect($host, $port);
		}

		public function send(...$params) : void {
			if(!connected) return;
			var msg : String = "";
			for(var i : int = 0;i < $params.length;i++) {
				var arg : String = String($params[i]);
				// Space, tab, newline
				arg = arg.replace(/[\x20\x09\x0A]+/g, "\\ ");
				// Semicolon
				arg = arg.replace(/\x3B/g, "");
				msg += arg;
				if(i < $params.length - 1) msg += " ";
			}
			msg += ";";
			trace(msg);
			_socket.writeUTFBytes(msg);
			_socket.flush();
		}
	}
}
